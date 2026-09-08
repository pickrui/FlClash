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
	"time"

	"github.com/metacubex/mihomo/component/dialer"
	"github.com/metacubex/mihomo/component/geodata"
	"github.com/metacubex/mihomo/component/geodata/router"
	mihomoHttp "github.com/metacubex/mihomo/component/http"
	"github.com/metacubex/mihomo/component/mmdb"
	"github.com/metacubex/mihomo/component/resolver"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/constant/features"
	"github.com/metacubex/mihomo/hub/route"
	"github.com/metacubex/mihomo/listener/inner"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel"
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

	data, err := downloadGeoData(ctx, geoURL, func(data []byte) error {
		return validateGeoData(geoType, data)
	})
	if err != nil {
		var validationError *geoDownloadValidationError
		if errors.As(err, &validationError) {
			err = fmt.Errorf("invalid %s database file: %w", geoType, err)
		} else {
			err = fmt.Errorf("GEO download failed: %w", err)
		}
	}
	if err == nil {
		newHash := sha256.Sum256(data)
		if err = ctx.Err(); err == nil {
			if oldHashErr == nil && oldHash == newHash {
				sendGeoUpdate(geoType, false, true, nil)
				return nil
			}
			err = replaceGeoData(ctx, geoType, path, data)
		}
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
	var validName bool
	name := strings.ToLower(geoName)
	switch geoType {
	case "MMDB":
		// The app uses GEOIP.metadb even when the core has selected a legacy
		// Country.mmdb or geoip.db file. Names identify the resource; only the
		// core's path resolver selects the destination to replace.
		path = constant.Path.MMDB()
		validName = name == "geoip.metadb" || name == "country.mmdb" || name == "geoip.db"
	case "ASN":
		path = constant.Path.ASN()
		validName = name == "asn.mmdb"
	case "GEOIP":
		path = constant.Path.GeoIP()
		validName = name == "geoip.dat"
	case "GEOSITE":
		path = constant.Path.GeoSite()
		validName = name == "geosite.dat"
	default:
		return "", errors.New("unsupported GEO resource")
	}
	if !validName {
		return "", errors.New("invalid GEO resource name")
	}
	return path, nil
}

type geoDownloadRoute struct {
	name    string
	options []mihomoHttp.Option
}

type geoDownloadValidationError struct {
	err error
}

func (e *geoDownloadValidationError) Error() string { return e.err.Error() }
func (e *geoDownloadValidationError) Unwrap() error { return e.err }

type geoDownloadHTTPError int

func (e geoDownloadHTTPError) Error() string {
	return fmt.Sprintf("unexpected HTTP status: %d %s", e, http.StatusText(int(e)))
}

func downloadGeoData(ctx context.Context, url string, validate func([]byte) error) ([]byte, error) {
	routes := []geoDownloadRoute{{
		name: "direct",
		options: []mihomoHttp.Option{mihomoHttp.WithDialer(
			dialer.NewDialer(dialer.WithResolver(resolver.DirectHostResolver)),
		)},
	}}
	// Keep the configured routing and selected proxy groups for the other
	// attempt. Forcing GLOBAL or an arbitrary node would change user choices.
	// A stopped/uninitialized tunnel has only a usable direct route.
	if inner.GetTunnel() != nil && tunnel.Status() != tunnel.Suspend {
		routes = append([]geoDownloadRoute{{name: "configured route"}}, routes...)
	}
	return downloadGeoDataWithRoutes(ctx, url, validate, routes)
}

func downloadGeoDataWithRoutes(
	ctx context.Context,
	url string,
	validate func([]byte) error,
	routes []geoDownloadRoute,
) ([]byte, error) {
	if url == "" {
		return nil, errors.New("unsupported GEO resource")
	}
	parsedURL, err := urlpkg.Parse(url)
	if err != nil || parsedURL.Host == "" ||
		(parsedURL.Scheme != "http" && parsedURL.Scheme != "https") {
		return nil, errors.New("invalid GEO download URL")
	}
	ctx, cancelDeadline := context.WithTimeout(ctx, geoDownloadTimeout)
	defer cancelDeadline()
	ctx, cancel := context.WithCancelCause(ctx)
	defer cancel(nil)
	if err := ctx.Err(); err != nil {
		return nil, err
	}
	if len(routes) == 0 {
		return nil, errors.New("no GEO download route")
	}
	type result struct {
		name string
		data []byte
		err  error
	}
	results := make(chan result, len(routes))
	for _, route := range routes {
		go func() {
			data, err := downloadGeoDataAttempt(ctx, parsedURL.String(), route.options)
			// Account refusals remain authoritative. An anonymous CDN 403 may
			// only block this egress, so keep the other public route running.
			var statusError geoDownloadHTTPError
			privateURL := parsedURL.User != nil || parsedURL.RawQuery != "" || parsedURL.ForceQuery
			if errors.As(err, &statusError) &&
				(statusError == http.StatusUnauthorized || (statusError == http.StatusForbidden && privateURL)) {
				cancel(fmt.Errorf("%s: %w", route.name, err))
			}
			results <- result{name: route.name, data: data, err: err}
		}()
	}
	var failures []error
	for range routes {
		select {
		case <-ctx.Done():
			return nil, context.Cause(ctx)
		case result := <-results:
			// Validate completed candidates serially to bound parser memory.
			// An HTTP 200 carrying an error page must not cancel a valid route.
			result.err = validateGeoDownload(ctx, result.data, result.err, validate)
			if ctx.Err() != nil {
				return nil, context.Cause(ctx)
			}
			if result.err == nil {
				return result.data, nil
			}
			failures = append(failures, fmt.Errorf("%s: %w", result.name, result.err))
		}
	}
	return nil, errors.Join(failures...)
}

func validateGeoDownload(ctx context.Context, data []byte, err error, validate func([]byte) error) error {
	if ctx.Err() != nil {
		return ctx.Err()
	}
	if err == nil && validate != nil {
		if validationError := validate(data); validationError != nil {
			err = &geoDownloadValidationError{err: validationError}
		}
	}
	if ctx.Err() != nil {
		return ctx.Err()
	}
	return err
}

func downloadGeoDataAttempt(ctx context.Context, url string, options []mihomoHttp.Option) ([]byte, error) {
	// HttpRequest creates a transport for each attempt. Its idle connections
	// cannot be reused by another download, so close them with the response.
	headers := map[string][]string{"Connection": {"close"}}
	response, err := mihomoHttp.HttpRequest(ctx, url, http.MethodGet, headers, nil, options...)
	if err != nil {
		if requestErr, ok := err.(*urlpkg.Error); ok {
			// UI/status errors must not reveal custom URL credentials or tokens.
			redacted := *requestErr
			if safeURL, parseErr := urlpkg.Parse(redacted.URL); parseErr == nil {
				safeURL.User = nil
				safeURL.RawQuery = ""
				safeURL.Fragment = ""
				redacted.URL = safeURL.String()
			} else {
				redacted.URL = ""
			}
			err = &redacted
		}
		return nil, err
	}
	defer response.Body.Close()
	if response.StatusCode < 200 || response.StatusCode > 299 {
		return nil, geoDownloadHTTPError(response.StatusCode)
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
			return err
		}
		defer instance.Close()
		return validateMMDBGeoData(geoType, instance)
	case "GEOIP":
		loader, err := geodata.GetGeoDataLoader("standard")
		if err != nil {
			return err
		}
		cidrs, err := loader.LoadIPByBytes(data, "cn")
		if err != nil {
			return err
		}
		if len(cidrs) == 0 {
			return errors.New("GEOIP database has no CN IP records")
		}
		_, err = router.NewGeoIPMatcher(cidrs)
		return err
	case "GEOSITE":
		loader, err := geodata.GetGeoDataLoader("standard")
		if err != nil {
			return err
		}
		domains, err := loader.LoadSiteByBytes(data, "cn")
		if err != nil {
			return err
		}
		if len(domains) == 0 {
			return errors.New("GEOSITE database has no CN domain records")
		}
		for _, domain := range domains {
			if domain == nil || domain.Value == "" ||
				domain.Type < router.Domain_Plain || domain.Type > router.Domain_Full {
				return errors.New("GEOSITE database contains an invalid CN domain record")
			}
		}
		_, err = router.NewSuccinctMatcherGroup(domains)
		return err
	default:
		return errors.New("unsupported GEO resource")
	}
}

// Match the reader's supported layouts, including custom MaxMind databases
// whose metadata names differ but whose records still contain country.iso_code.
func validateMMDBGeoData(geoType string, database *maxminddb.Reader) error {
	databaseType := database.Metadata.DatabaseType
	switch databaseType {
	case "GeoLite2-ASN", "DBIP-ASN-Lite (compat=GeoLite2-ASN)", "ipinfo generic_asn_free.mmdb":
		if geoType == "ASN" {
			return nil
		}
		return fmt.Errorf("invalid MMDB database type: %s", databaseType)
	default:
		if geoType == "ASN" {
			return fmt.Errorf("unsupported ASN database type: %s", databaseType)
		}
	}

	networks := database.Networks(maxminddb.SkipAliasedNetworks)
	for networks.Next() {
		var record any
		if _, err := networks.Network(&record); err != nil {
			return fmt.Errorf("invalid MMDB country record: %w", err)
		}
		var valid bool
		switch databaseType {
		case "sing-geoip", "Meta-geoip0":
			switch value := record.(type) {
			case string:
				valid = value != ""
			case []any:
				valid = databaseType == "Meta-geoip0" && len(value) > 0
				for _, item := range value {
					if code, ok := item.(string); !ok || code == "" {
						valid = false
						break
					}
				}
			}
		default:
			value, _ := record.(map[string]any)
			country, _ := value["country"].(map[string]any)
			code, _ := country["iso_code"].(string)
			valid = code != ""
		}
		if valid {
			return nil
		}
	}
	if err := networks.Err(); err != nil {
		return fmt.Errorf("invalid MMDB search tree: %w", err)
	}
	return errors.New("MMDB database has no usable country records")
}

func replaceGeoData(ctx context.Context, geoType string, path string, data []byte) (err error) {
	if err = ctx.Err(); err != nil {
		return err
	}
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
	// Cancellation during staging must not publish the candidate database.
	if err = ctx.Err(); err != nil {
		return err
	}
	if err = replaceFileAtomic(tempPath, path); err != nil {
		return err
	}
	switch geoType {
	case "MMDB":
		mmdb.ReloadIP()
	case "ASN":
		mmdb.ReloadASN()
	case "GEOIP":
		geodata.ClearGeoIPCache()
	case "GEOSITE":
		geodata.ClearGeoSiteCache()
	}
	return nil
}

type geoResource struct {
	geoType string
	path    string
}

func allGeoResources() []geoResource {
	return []geoResource{
		{"MMDB", constant.Path.MMDB()},
		{"ASN", constant.Path.ASN()},
		{"GEOIP", constant.Path.GeoIP()},
		{"GEOSITE", constant.Path.GeoSite()},
	}
}

func updateAllGeoDataAction(ctx context.Context) error {
	var updateErr error
	for _, resource := range allGeoResources() {
		if err := ctx.Err(); err != nil {
			if errors.Is(updateErr, err) {
				return updateErr
			}
			return errors.Join(updateErr, err)
		}
		if err := updateGeoDataLocked(ctx, resource.geoType, resource.path); err != nil {
			log.Errorln("[GEO] Failed to update %s: %s", resource.geoType, err.Error())
			updateErr = errors.Join(updateErr, fmt.Errorf("%s: %w", resource.geoType, err))
		}
	}
	return updateErr
}

func updateAllGeoData(ctx context.Context) error {
	return runGeoUpdate(ctx, updateAllGeoDataAction)
}

func tryUpdateAllGeoData(ctx context.Context) error {
	return tryRunGeoUpdate(ctx, updateAllGeoDataAction)
}

func handleGeoUpdateRequest(w http.ResponseWriter, request *http.Request) {
	if err := tryUpdateAllGeoData(request.Context()); err != nil {
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
			_ = updateAllGeoData(ctx)
		}
		if ctx.Err() != nil {
			return
		}
		ticker := time.NewTicker(duration)
		defer ticker.Stop()
		for {
			select {
			case <-ticker.C:
				_ = updateAllGeoData(ctx)
			case <-ctx.Done():
				return
			}
		}
	}()
}

func shouldUpdateGeoData(interval time.Duration) bool {
	resources := allGeoResources()
	paths := make([]string, 0, len(resources))
	for _, resource := range resources {
		paths = append(paths, resource.path)
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
