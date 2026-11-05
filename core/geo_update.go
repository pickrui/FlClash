package main

import (
	"bytes"
	"context"
	"crypto/sha256"
	"errors"
	"fmt"
	"io"
	urlpkg "net/url"
	"os"
	"path/filepath"
	"strings"
	"sync"
	"sync/atomic"
	"time"

	"github.com/metacubex/mihomo/component/geodata"
	mihomoHttp "github.com/metacubex/mihomo/component/http"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/constant/features"
	"github.com/metacubex/mihomo/hub/route"
	"github.com/metacubex/mihomo/log"
	"github.com/oschwald/maxminddb-golang"

	"github.com/metacubex/chi"
	"github.com/metacubex/http"
)

const (
	maxGeoUpdateInterval = 24 * 365
	maxGeoDownloadBytes  = 64 * 1024 * 1024
	geoDownloadTimeout   = 90 * time.Second
)

type geoSchedulerState struct {
	cancel context.CancelFunc
	done   chan struct{}
}

var (
	geoUpdateGate   = make(chan struct{}, 1)
	geoSchedulerMu  sync.Mutex
	geoScheduler    *geoSchedulerState
	geoReloadNeeded atomic.Bool
	geoLifecycleMu  sync.Mutex
	geoLifecycleCtx context.Context
	geoLifecycleEnd context.CancelFunc
	geoLifecycleWG  sync.WaitGroup
)

var errGeoUpdateBusy = errors.New("GEO update is already in progress")

func init() {
	geoUpdateGate <- struct{}{}
	resetGeoLifecycle()
	if !features.Android {
		route.Register(func(r chi.Router) {
			r.Post("/configs/geo", handleGeoUpdateRequest)
			r.Post("/upgrade/geo", handleGeoUpdateRequest)
		})
	}
}

func resetGeoLifecycle() {
	geoLifecycleMu.Lock()
	if geoLifecycleEnd != nil {
		geoLifecycleEnd()
	}
	geoLifecycleCtx, geoLifecycleEnd = context.WithCancel(context.Background())
	geoLifecycleMu.Unlock()
}

func stopGeoLifecycle() {
	geoLifecycleMu.Lock()
	cancel := geoLifecycleEnd
	geoLifecycleEnd = nil
	geoLifecycleMu.Unlock()
	if cancel != nil {
		cancel()
	}
	stopGeoScheduler()
	geoLifecycleWG.Wait()
}

func runLifecycleGeoTask(action func(context.Context)) bool {
	geoLifecycleMu.Lock()
	ctx := geoLifecycleCtx
	if geoLifecycleEnd == nil || ctx == nil || ctx.Err() != nil {
		geoLifecycleMu.Unlock()
		return false
	}
	geoLifecycleWG.Add(1)
	geoLifecycleMu.Unlock()
	go func() {
		defer geoLifecycleWG.Done()
		action(ctx)
	}()
	return true
}

func sendGeoUpdate(geoType string, updating bool, skipped bool, err error) {
	data := GeoUpdateStatus{
		Type:     geoType,
		Updating: updating,
		Skipped:  skipped,
	}
	if err != nil {
		data.Error = err.Error()
	}
	sendMessage(Message{Type: GeoUpdateMessage, Data: data})
}

func sendGeoReload() {
	sendMessage(Message{
		Type: GeoUpdateMessage,
		Data: GeoUpdateStatus{Reload: true},
	})
}

func getFileHash(path string) ([sha256.Size]byte, error) {
	file, err := os.Open(path)
	if err != nil {
		return [sha256.Size]byte{}, err
	}
	defer file.Close()
	hash := sha256.New()
	if _, err = io.Copy(hash, file); err != nil {
		return [sha256.Size]byte{}, err
	}
	var value [sha256.Size]byte
	copy(value[:], hash.Sum(nil))
	return value, nil
}

func updateGeoData(geoType string, path string) error {
	return updateGeoDataFromURL(geoType, path, geoDataURL(geoType))
}

func updateGeoDataFromURL(geoType string, path string, geoURL string) error {
	geoLifecycleMu.Lock()
	ctx := geoLifecycleCtx
	geoLifecycleMu.Unlock()
	if ctx == nil {
		return context.Canceled
	}
	return tryRunGeoUpdate(ctx, func(ctx context.Context) error {
		return updateGeoDataLockedFromURL(ctx, geoType, path, geoURL)
	})
}

func runGeoUpdate(ctx context.Context, action func(context.Context) error) error {
	select {
	case <-ctx.Done():
		return ctx.Err()
	case <-geoUpdateGate:
	}
	defer func() { geoUpdateGate <- struct{}{} }()
	if err := ctx.Err(); err != nil {
		return err
	}
	return action(ctx)
}

func tryRunGeoUpdate(ctx context.Context, action func(context.Context) error) error {
	select {
	case <-ctx.Done():
		return ctx.Err()
	case <-geoUpdateGate:
	default:
		return errGeoUpdateBusy
	}
	defer func() { geoUpdateGate <- struct{}{} }()
	if err := ctx.Err(); err != nil {
		return err
	}
	return action(ctx)
}

func updateGeoDataLocked(ctx context.Context, geoType string, path string) error {
	return updateGeoDataLockedFromURL(ctx, geoType, path, geoDataURL(geoType))
}

func updateGeoDataLockedFromURL(
	ctx context.Context,
	geoType string,
	path string,
	geoURL string,
) error {
	sendGeoUpdate(geoType, true, false, nil)
	oldHash, oldHashErr := getFileHash(path)

	data, err := downloadGeoData(ctx, geoURL)
	if err == nil {
		err = validateGeoData(geoType, data)
	}
	if err == nil {
		newHash := sha256.Sum256(data)
		if oldHashErr == nil && oldHash == newHash {
			sendGeoUpdate(geoType, false, true, nil)
			return nil
		}
		err = replaceGeoData(geoType, path, data)
	}
	if err != nil {
		sendGeoUpdate(geoType, false, false, err)
		return err
	}
	sendGeoUpdate(geoType, false, false, nil)
	return nil
}

func geoDataURL(geoType string) string {
	switch geoType {
	case "MMDB":
		return geodata.MmdbUrl()
	case "ASN":
		return geodata.ASNUrl()
	case "GEOIP":
		return geodata.GeoIpUrl()
	case "GEOSITE":
		return geodata.GeoSiteUrl()
	default:
		return ""
	}
}

func geoResourcePath(geoType string, geoName string) (string, error) {
	var path string
	var expectedName string
	switch geoType {
	case "MMDB":
		path = constant.Path.MMDB()
		expectedName = filepath.Base(path)
	case "ASN":
		path = constant.Path.ASN()
		expectedName = filepath.Base(path)
	case "GEOIP":
		path = constant.Path.GeoIP()
		expectedName = filepath.Base(path)
	case "GEOSITE":
		path = constant.Path.GeoSite()
		expectedName = filepath.Base(path)
	default:
		return "", errors.New("unsupported GEO resource")
	}
	if !strings.EqualFold(filepath.Base(geoName), expectedName) ||
		filepath.Base(geoName) != geoName {
		return "", errors.New("invalid GEO resource name")
	}
	return path, nil
}

func downloadGeoData(ctx context.Context, url string) ([]byte, error) {
	if url == "" {
		return nil, errors.New("unsupported GEO resource")
	}
	parsedURL, err := urlpkg.Parse(url)
	if err != nil || parsedURL.Host == "" ||
		(parsedURL.Scheme != "http" && parsedURL.Scheme != "https") {
		return nil, errors.New("invalid GEO download URL")
	}
	ctx, cancel := context.WithTimeout(ctx, geoDownloadTimeout)
	defer cancel()
	response, err := mihomoHttp.HttpRequest(ctx, parsedURL.String(), http.MethodGet, nil, nil)
	if err != nil {
		return nil, err
	}
	defer response.Body.Close()
	if response.StatusCode < 200 || response.StatusCode > 299 {
		return nil, fmt.Errorf("GEO download failed: %s", response.Status)
	}
	if response.ContentLength > maxGeoDownloadBytes {
		return nil, errors.New("GEO download exceeds size limit")
	}
	data, err := io.ReadAll(io.LimitReader(response.Body, maxGeoDownloadBytes+1))
	if err != nil {
		return nil, err
	}
	if len(data) == 0 {
		return nil, errors.New("GEO download is empty")
	}
	if len(data) > maxGeoDownloadBytes {
		return nil, errors.New("GEO download exceeds size limit")
	}
	return data, nil
}

func validateGeoData(geoType string, data []byte) error {
	switch geoType {
	case "MMDB", "ASN":
		instance, err := maxminddb.FromBytes(data)
		if err != nil {
			return fmt.Errorf("invalid %s database file: %w", geoType, err)
		}
		return instance.Close()
	case "GEOIP":
		loader, err := geodata.GetGeoDataLoader("standard")
		if err != nil {
			return err
		}
		_, err = loader.LoadIPByBytes(data, "cn")
		return err
	case "GEOSITE":
		loader, err := geodata.GetGeoDataLoader("standard")
		if err != nil {
			return err
		}
		_, err = loader.LoadSiteByBytes(data, "cn")
		return err
	default:
		return errors.New("unsupported GEO resource")
	}
}

func replaceGeoData(geoType string, path string, data []byte) (err error) {
	directory := filepath.Dir(path)
	if err = os.MkdirAll(directory, 0o755); err != nil {
		return err
	}
	temp, err := os.CreateTemp(directory, ".flclash-geo-*")
	if err != nil {
		return err
	}
	tempPath := temp.Name()
	defer func() {
		_ = temp.Close()
		_ = os.Remove(tempPath)
	}()
	if err = temp.Chmod(0o644); err != nil {
		return err
	}
	if _, err = io.Copy(temp, bytes.NewReader(data)); err != nil {
		return err
	}
	if err = temp.Sync(); err != nil {
		return err
	}
	if err = temp.Close(); err != nil {
		return err
	}
	if err = replaceFileAtomic(tempPath, path); err != nil {
		return err
	}
	switch geoType {
	case "MMDB", "ASN":
		geoReloadNeeded.Store(true)
	case "GEOIP":
		geodata.ClearGeoIPCache()
	case "GEOSITE":
		geodata.ClearGeoSiteCache()
	}
	return nil
}

func updateEnabledGeoDataAction(ctx context.Context) error {
	var updateErr error
	if geodata.GeoIpEnable() {
		if geodata.GeodataMode() {
			if err := updateGeoDataLocked(ctx, "GEOIP", constant.Path.GeoIP()); err != nil {
				log.Errorln("[GEO] Failed to update GEOIP: %s", err.Error())
				updateErr = errors.Join(updateErr, err)
			}
		} else if err := updateGeoDataLocked(ctx, "MMDB", constant.Path.MMDB()); err != nil {
			log.Errorln("[GEO] Failed to update MMDB: %s", err.Error())
			updateErr = errors.Join(updateErr, err)
		}
	}
	if geodata.ASNEnable() {
		if err := updateGeoDataLocked(ctx, "ASN", constant.Path.ASN()); err != nil {
			log.Errorln("[GEO] Failed to update ASN: %s", err.Error())
			updateErr = errors.Join(updateErr, err)
		}
	}
	if geodata.GeoSiteEnable() {
		if err := updateGeoDataLocked(ctx, "GEOSITE", constant.Path.GeoSite()); err != nil {
			log.Errorln("[GEO] Failed to update GEOSITE: %s", err.Error())
			updateErr = errors.Join(updateErr, err)
		}
	}
	return updateErr
}

func updateEnabledGeoData(ctx context.Context) error {
	err := runGeoUpdate(ctx, updateEnabledGeoDataAction)
	if geoReloadNeeded.Swap(false) {
		sendGeoReload()
	}
	return err
}

func tryUpdateEnabledGeoData(ctx context.Context) error {
	err := tryRunGeoUpdate(ctx, updateEnabledGeoDataAction)
	if geoReloadNeeded.Swap(false) {
		sendGeoReload()
	}
	return err
}

func handleGeoUpdateRequest(w http.ResponseWriter, request *http.Request) {
	if err := tryUpdateEnabledGeoData(request.Context()); err != nil {
		if errors.Is(err, errGeoUpdateBusy) {
			http.Error(w, err.Error(), http.StatusConflict)
			return
		}
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusNoContent)
}

func stopGeoScheduler() {
	geoSchedulerMu.Lock()
	state := geoScheduler
	geoScheduler = nil
	geoSchedulerMu.Unlock()
	if state != nil {
		state.cancel()
		<-state.done
	}
}

func restartGeoScheduler() {
	stopGeoScheduler()
	if currentConfig == nil || !currentConfig.General.GeoAutoUpdate {
		return
	}
	interval := currentConfig.General.GeoUpdateInterval
	if interval <= 0 || interval > maxGeoUpdateInterval {
		log.Errorln("[GEO] Invalid update interval: %d", interval)
		return
	}
	duration := time.Duration(interval) * time.Hour

	ctx, cancel := context.WithCancel(context.Background())
	state := &geoSchedulerState{cancel: cancel, done: make(chan struct{})}
	geoSchedulerMu.Lock()
	geoScheduler = state
	geoSchedulerMu.Unlock()

	go func() {
		defer close(state.done)
		if shouldUpdateGeoData(duration) {
			_ = updateEnabledGeoData(ctx)
		}
		if ctx.Err() != nil {
			return
		}
		ticker := time.NewTicker(duration)
		defer ticker.Stop()
		for {
			select {
			case <-ticker.C:
				_ = updateEnabledGeoData(ctx)
			case <-ctx.Done():
				return
			}
		}
	}()
}

func shouldUpdateGeoData(interval time.Duration) bool {
	paths := make([]string, 0, 3)
	if geodata.GeoIpEnable() {
		if geodata.GeodataMode() {
			paths = append(paths, constant.Path.GeoIP())
		} else {
			paths = append(paths, constant.Path.MMDB())
		}
	}
	if geodata.ASNEnable() {
		paths = append(paths, constant.Path.ASN())
	}
	if geodata.GeoSiteEnable() {
		paths = append(paths, constant.Path.GeoSite())
	}
	return shouldUpdateGeoFiles(paths, interval)
}

func shouldUpdateGeoFiles(paths []string, interval time.Duration) bool {
	for _, path := range paths {
		fileInfo, err := os.Stat(path)
		if err != nil || time.Since(fileInfo.ModTime()) >= interval {
			return true
		}
	}
	return false
}
