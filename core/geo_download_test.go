package main

import (
	"bytes"
	"context"
	"errors"
	"net"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	"github.com/metacubex/mihomo/component/dialer"
	"github.com/metacubex/mihomo/component/geodata/router"
	mihomoHttp "github.com/metacubex/mihomo/component/http"
	"google.golang.org/protobuf/proto"
)

type geoTestDownloadDialer struct {
	dialer.Dialer
	address string
}

func (d geoTestDownloadDialer) DialContext(ctx context.Context, network, _ string) (net.Conn, error) {
	return (&net.Dialer{}).DialContext(ctx, network, d.address)
}

func geoTestDownloadRoute(name string, server *httptest.Server) geoDownloadRoute {
	return geoDownloadRoute{
		name: name,
		options: []mihomoHttp.Option{mihomoHttp.WithDialer(geoTestDownloadDialer{
			address: server.Listener.Addr().String(),
		})},
	}
}

func geoTestIPData(t *testing.T) []byte {
	t.Helper()
	data, err := proto.Marshal(&router.GeoIPList{Entry: []*router.GeoIP{{
		CountryCode: "CN",
		Cidr:        []*router.CIDR{{Ip: []byte{1, 0, 0, 0}, Prefix: 8}},
	}}})
	if err != nil {
		t.Fatal(err)
	}
	return data
}

func TestGeoDownloadUsesCompletedRouteAndCancelsStalledBody(t *testing.T) {
	for _, stalledName := range []string{"direct", "configured route"} {
		t.Run(stalledName, func(t *testing.T) {
			started := make(chan struct{})
			canceled := make(chan struct{})
			stalled := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				// Headers arrive first but the body never finishes.
				w.WriteHeader(http.StatusOK)
				_, _ = w.Write([]byte("partial database"))
				w.(http.Flusher).Flush()
				close(started)
				<-r.Context().Done()
				close(canceled)
			}))
			defer stalled.Close()
			data := geoTestIPData(t)
			winner := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				select {
				case <-started:
					_, _ = w.Write(data)
				case <-r.Context().Done():
				}
			}))
			defer winner.Close()
			winnerName := "direct"
			if stalledName == "direct" {
				winnerName = "configured route"
			}
			ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
			defer cancel()
			got, err := downloadGeoDataWithRoutes(ctx, "http://download.invalid/GEOIP.dat", func(data []byte) error {
				return validateGeoData("GEOIP", data)
			}, []geoDownloadRoute{
				geoTestDownloadRoute(stalledName, stalled),
				geoTestDownloadRoute(winnerName, winner),
			})
			if err != nil || !bytes.Equal(got, data) {
				t.Fatalf("completed valid download = %x, %v", got, err)
			}
			select {
			case <-canceled:
			case <-time.After(2 * time.Second):
				t.Fatal("losing download body was not canceled")
			}
		})
	}
}

func TestGeoDownloadKeepsOtherRouteAfterInvalidHTTP200(t *testing.T) {
	rejected := make(chan struct{})
	invalid := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("<html>blocked</html>"))
	}))
	defer invalid.Close()
	data := geoTestIPData(t)
	valid := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		select {
		case <-rejected:
			_, _ = w.Write(data)
		case <-r.Context().Done():
		}
	}))
	defer valid.Close()
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	got, err := downloadGeoDataWithRoutes(ctx, "http://download.invalid/GEOIP.dat", func(data []byte) error {
		err := validateGeoData("GEOIP", data)
		if err != nil {
			close(rejected)
		}
		return err
	}, []geoDownloadRoute{
		geoTestDownloadRoute("direct", invalid),
		geoTestDownloadRoute("configured route", valid),
	})
	if err != nil || !bytes.Equal(got, data) {
		t.Fatalf("valid route was not retained after invalid HTTP 200: %x, %v", got, err)
	}
}

func TestGeoDownloadKeepsOtherRouteAfterHTTPFailure(t *testing.T) {
	failed := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		http.Error(w, "unavailable", http.StatusServiceUnavailable)
	}))
	defer failed.Close()
	data := geoTestIPData(t)
	valid := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write(data)
	}))
	defer valid.Close()
	got, err := downloadGeoDataWithRoutes(context.Background(), "http://download.invalid/GEOIP.dat", func(data []byte) error {
		return validateGeoData("GEOIP", data)
	}, []geoDownloadRoute{
		geoTestDownloadRoute("direct", failed),
		geoTestDownloadRoute("configured route", valid),
	})
	if err != nil || !bytes.Equal(got, data) {
		t.Fatalf("HTTP failure masked a valid route: %x, %v", got, err)
	}
}

func TestGeoDownloadPublicForbiddenDoesNotMaskValidRoute(t *testing.T) {
	refused := make(chan struct{})
	failed := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		http.Error(w, "egress blocked", http.StatusForbidden)
		close(refused)
	}))
	defer failed.Close()
	data := geoTestIPData(t)
	valid := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		select {
		case <-refused:
			// Keep the valid response behind the first route's rejection.
			time.Sleep(20 * time.Millisecond)
			_, _ = w.Write(data)
		case <-r.Context().Done():
		}
	}))
	defer valid.Close()
	got, err := downloadGeoDataWithRoutes(context.Background(), "http://download.invalid/GEOIP.dat", func(data []byte) error {
		return validateGeoData("GEOIP", data)
	}, []geoDownloadRoute{geoTestDownloadRoute("direct", failed), geoTestDownloadRoute("configured route", valid)})
	if err != nil || !bytes.Equal(got, data) {
		t.Fatalf("public 403 masked a valid route: %x, %v", got, err)
	}
}

func TestGeoDownloadReportsBothFailuresAndValidationCause(t *testing.T) {
	failed := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		http.Error(w, "unavailable", http.StatusServiceUnavailable)
	}))
	defer failed.Close()
	invalid := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("not a database"))
	}))
	defer invalid.Close()
	_, err := downloadGeoDataWithRoutes(context.Background(), "http://download.invalid/GEOIP.dat", func(data []byte) error {
		return validateGeoData("GEOIP", data)
	}, []geoDownloadRoute{
		geoTestDownloadRoute("direct", failed),
		geoTestDownloadRoute("configured route", invalid),
	})
	var validationError *geoDownloadValidationError
	if !errors.As(err, &validationError) || !strings.Contains(err.Error(), "direct: unexpected HTTP status: 503") ||
		!strings.Contains(err.Error(), "configured route: ") {
		t.Fatalf("failed routes or validation cause were lost: %v", err)
	}
}

func TestGeoDownloadCancellationStopsEveryRoute(t *testing.T) {
	started := make(chan struct{}, 2)
	canceled := make(chan struct{}, 2)
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.(http.Flusher).Flush()
		started <- struct{}{}
		<-r.Context().Done()
		canceled <- struct{}{}
	}))
	defer server.Close()
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	result := make(chan error, 1)
	go func() {
		_, err := downloadGeoDataWithRoutes(ctx, "http://download.invalid/GEOIP.dat", nil, []geoDownloadRoute{
			geoTestDownloadRoute("direct", server),
			geoTestDownloadRoute("configured route", server),
		})
		result <- err
	}()
	for range 2 {
		select {
		case <-started:
		case <-time.After(5 * time.Second):
			t.Fatal("download routes did not start concurrently")
		}
	}
	cancel()
	select {
	case err := <-result:
		if !errors.Is(err, context.Canceled) {
			t.Fatalf("cancellation cause lost: %v", err)
		}
	case <-time.After(2 * time.Second):
		t.Fatal("download did not return after cancellation")
	}
	for range 2 {
		select {
		case <-canceled:
		case <-time.After(2 * time.Second):
			t.Fatal("an HTTP request remained active after cancellation")
		}
	}
}

func TestGeoDownloadRejectsCandidateIfContextExpiresDuringValidation(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("complete response"))
	}))
	defer server.Close()
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	data, err := downloadGeoDataWithRoutes(ctx, "http://download.invalid/GEOIP.dat", func([]byte) error {
		cancel()
		return nil
	}, []geoDownloadRoute{geoTestDownloadRoute("direct", server)})
	if data != nil || !errors.Is(err, context.Canceled) {
		t.Fatalf("canceled download returned installable data: %q, %v", data, err)
	}
}

func TestGeoDownloadCredentialURLsRaceBothRoutes(t *testing.T) {
	for _, test := range []struct {
		name, url string
		basicAuth bool
		query     bool
	}{
		{"basic auth", "http://test-user:test-token@download.invalid/GEOIP.dat", true, false},
		{"query token", "http://download.invalid/GEOIP.dat?token=test-token", false, true},
		{"auth and query", "http://test-user:test-token@download.invalid/GEOIP.dat?token=test-token", true, true},
	} {
		t.Run(test.name, func(t *testing.T) {
			started := make(chan struct{}, 2)
			release := make(chan struct{})
			data := geoTestIPData(t)
			handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				user, password, hasAuth := r.BasicAuth()
				if hasAuth != test.basicAuth || (hasAuth && (user != "test-user" || password != "test-token")) {
					t.Error("read attempt did not preserve Basic Auth")
				}
				if (r.URL.Query().Get("token") == "test-token") != test.query {
					t.Error("read attempt did not preserve query parameters")
				}
				started <- struct{}{}
				select {
				case <-release:
					_, _ = w.Write(data)
				case <-r.Context().Done():
				}
			})
			configured := httptest.NewServer(handler)
			defer configured.Close()
			direct := httptest.NewServer(handler)
			defer direct.Close()
			ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
			defer cancel()
			result := make(chan error, 1)
			go func() {
				got, err := downloadGeoDataWithRoutes(ctx, test.url, func(candidate []byte) error {
					return validateGeoData("GEOIP", candidate)
				}, []geoDownloadRoute{
					geoTestDownloadRoute("configured route", configured),
					geoTestDownloadRoute("direct", direct),
				})
				if err == nil && !bytes.Equal(got, data) {
					err = errors.New("racing read returned different database contents")
				}
				result <- err
			}()
			for range 2 {
				select {
				case <-started:
				case <-ctx.Done():
					t.Fatal("credential URL did not start both routes concurrently")
				}
			}
			close(release)
			if err := <-result; err != nil {
				t.Fatalf("credential URL race failed: %v", err)
			}
		})
	}
}

func TestGeoDownloadAuthorizationRefusalCancelsOtherRoute(t *testing.T) {
	for _, status := range []int{http.StatusUnauthorized, http.StatusForbidden} {
		t.Run(http.StatusText(status), func(t *testing.T) {
			started := make(chan struct{})
			canceled := make(chan struct{})
			other := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				w.WriteHeader(http.StatusOK)
				_, _ = w.Write([]byte("partial database"))
				w.(http.Flusher).Flush()
				close(started)
				<-r.Context().Done()
				close(canceled)
			}))
			defer other.Close()
			refused := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				select {
				case <-started:
					http.Error(w, "access denied", status)
				case <-r.Context().Done():
				}
			}))
			defer refused.Close()
			ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
			defer cancel()
			data, err := downloadGeoDataWithRoutes(ctx,
				"http://test-user:test-token@download.invalid/GEOIP.dat?token=test-token", nil,
				[]geoDownloadRoute{
					geoTestDownloadRoute("configured route", refused),
					geoTestDownloadRoute("direct", other),
				})
			var statusError geoDownloadHTTPError
			if data != nil || !errors.As(err, &statusError) || int(statusError) != status {
				t.Fatalf("authorization refusal was lost: %q, %v", data, err)
			}
			select {
			case <-canceled:
			case <-time.After(2 * time.Second):
				t.Fatal("another route remained active after authorization refusal")
			}
		})
	}
}

func TestGeoDownloadClosesCompletedHTTPConnection(t *testing.T) {
	closed := make(chan struct{}, 1)
	server := httptest.NewUnstartedServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("complete response"))
	}))
	server.Config.ConnState = func(_ net.Conn, state http.ConnState) {
		if state == http.StateClosed {
			closed <- struct{}{}
		}
	}
	server.Start()
	defer server.Close()
	data, err := downloadGeoDataWithRoutes(context.Background(), "http://download.invalid/GEOIP.dat", nil,
		[]geoDownloadRoute{geoTestDownloadRoute("direct", server)})
	if err != nil || string(data) != "complete response" {
		t.Fatalf("download = %q, %v", data, err)
	}
	select {
	case <-closed:
	case <-time.After(time.Second):
		t.Fatal("one-shot HTTP transport retained an unused connection")
	}
}

func TestGeoDownloadFailureDoesNotExposeURLCredentials(t *testing.T) {
	server := httptest.NewServer(http.NotFoundHandler())
	route := geoTestDownloadRoute("direct", server)
	server.Close()
	_, err := downloadGeoDataWithRoutes(context.Background(),
		"http://private-user:private-password@download.invalid/GEOIP.dat?token=private-token", nil,
		[]geoDownloadRoute{route})
	if err == nil {
		t.Fatal("closed download endpoint unexpectedly succeeded")
	}
	for _, secret := range []string{"private-user", "private-password", "private-token"} {
		if strings.Contains(err.Error(), secret) {
			t.Fatalf("download error contains a URL credential: %v", err)
		}
	}
	var networkError *net.OpError
	if !errors.As(err, &networkError) {
		t.Fatalf("redaction lost the underlying network failure: %v", err)
	}
}
