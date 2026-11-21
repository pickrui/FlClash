SHELL := /bin/bash
.DEFAULT_GOAL := help
include tool/go_build_tags.env
# The release harness builds with this toolchain; GOTOOLCHAIN=local overrides it.
GOTOOLCHAIN ?= go1.27.4

##> FLUTTER_TEST_ARGS=... test: tool/run_tests.dart arguments; "--plain test/x_test.dart" runs one program per file
##> APP=path              test-macos-isolated: the SAFE_MODE .app to launch
##> MACOS_TEST_ARGS=...   test-macos-isolated: extra tool/run_macos_isolated.py arguments
##> FILES=paths           lint: files to measure instead of the uncommitted changes
##> ARCH=name             package-*: amd64 or arm64; Android also arm, every ABI when unset
##> FORM=a,b              package-*: exe, zip, dmg, deb, rpm or appimage
##> APP_ENV=name          package-*: pre (default) or stable
##> DRY=1                 package-* on the desktop: print the packaging plan of an existing build
##> ARGS=...              package-*: extra setup.dart arguments

CARGO := env -u all_proxy -u ALL_PROXY CARGO_INCREMENTAL=0 cargo
COVERAGE_TESTS := test plugins/proxy/test/proxy_test.dart plugins/wifi_ssid/test plugins/tray/test plugins/window/test
# setup.dart reads the build secrets from the environment, as .env.local holds them.
SETUP := set -a; if [ -f .env.local ]; then . ./.env.local; fi; set +a; dart setup.dart
PACKAGE_FLAGS = $(if $(ARCH),--arch $(ARCH)) $(if $(FORM),--targets $(FORM))
package_platform = $(if $(filter 1,$(DRY)),dart tool/package.dart $(1) --dry-run $(PACKAGE_FLAGS),$(SETUP) $(1) $(PACKAGE_FLAGS) $(if $(APP_ENV),--env $(APP_ENV)) $(ARGS))

.PHONY: help setup submodules pub-get doctor hooks \
	gen gen-watch l10n status-icons frb \
	analyze format format-check lint notices plugins-check setup-hooks-test ci-test coverage check \
	test test-safe test-macos-isolated test-go vet-go android-core-check test-tailscale test-rust rust-check test-all \
	package-android package-linux package-macos package-windows \
	clean clean-core

help: ## List every target and variable
	@awk 'BEGIN { FS = ":.*## " } \
		/^##@ / { printf "\n%s\n", substr($$0, 5) } \
		/^[a-z0-9-]+:.*## / { printf "  %-20s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@printf '\nVariables\n'
	@sed -n 's/^##> /  /p' $(MAKEFILE_LIST)

##@ Environment

setup: submodules pub-get ## Fetch submodules and Dart packages

submodules: ## Update git submodules (Clash.Meta core, prism_ui)
	git submodule update --init --recursive

pub-get: ## flutter pub get
	flutter pub get

doctor: ## Report missing toolchains: Flutter, Go, rustup, NDK, JDK, packaging tools
	bash tool/doctor.sh

hooks: ## Install the pre-commit, pre-push and commit-msg git hooks
	pre-commit install --install-hooks
	pre-commit install --hook-type commit-msg --hook-type pre-push

##@ Generate

gen: ## Run build_runner once (freezed, json, riverpod, drift)
	dart run build_runner build --delete-conflicting-outputs

gen-watch: ## Run build_runner in watch mode
	dart run build_runner watch --delete-conflicting-outputs

l10n: ## Regenerate lib/l10n from the ARB files
	flutter gen-l10n

status-icons: ## Regenerate the tray icons (needs rsvg-convert)
	dart run tool/generate_status_icons.dart

frb: ## Regenerate the flutter_rust_bridge bindings of plugins/rust_api
	cd plugins/rust_api && flutter_rust_bridge_codegen generate

##@ Check

analyze: ## dart analyze lib test tool (flutter analyze crashes on this non-ASCII path)
	dart analyze lib test tool

format: ## Format owned Dart sources in place
	python3 tool/check_dart_format.py --write

format-check: ## Fail on unformatted Dart sources, as CI does
	python3 tool/check_dart_format.py

lint: ## Comment density gate over the working tree, or FILES=paths
	./tool/check_comment_density.sh $(FILES) < /dev/null

notices: ## Check the NOTICE header of every tracked source, as CI does
	bash tool/check_build_notices.sh

plugins-check: ## Analyze every bundled plugin package, as CI does
	bash tool/check_plugins.sh

setup-hooks-test: ## Test the setup_hooks package with dart test
	cd plugins/setup/setup_hooks && dart test

ci-test: ## Run the Python tests of the release check scripts
	python3 -m unittest discover -s test/ci

coverage: ## Run CI's test set with coverage and hold it to tool/coverage_floors.json
	dart tool/run_tests.dart $(COVERAGE_TESTS) -- --coverage
	dart tool/check_coverage.dart

check: ci-test format-check analyze plugins-check notices setup-hooks-test coverage ## Run CI's Dart job

##@ Test

test: ## Tests from shared entrypoints, native asset hooks off; FLUTTER_TEST_ARGS=...
	dart tool/run_tests.dart $(FLUTTER_TEST_ARGS)

test-safe: ## Isolated desktop safe-mode checks
	dart tool/run_tests.dart --dart-define=SAFE_MODE=true test/safe_mode test/common/safe_mode_profile_test.dart test/views/mitm_view_test.dart

test-macos-isolated: ## Offline macOS GUI smoke test of a SAFE_MODE build; APP=/path/to/safe.app
	python3 tool/run_macos_isolated.py --app "$(APP)" $(MACOS_TEST_ARGS)

test-go: ## Go core tests
	cd core && GOTOOLCHAIN=$(GOTOOLCHAIN) CGO_ENABLED=0 go test -tags $(GO_TAGS) ./...

vet-go: ## go vet the core with the release build tags, as CI does
	cd core && GOTOOLCHAIN=$(GOTOOLCHAIN) CGO_ENABLED=0 go vet -tags $(GO_TAGS) ./...

android-core-check: ## Vet and bind the arm64 Android core, check its secret symbol and alignment
	bash tool/check_android_core.sh arm64

test-tailscale: ## Tailscale outbound against the official test control server
	cd core/Clash.Meta && GOTOOLCHAIN=$(GOTOOLCHAIN) MIHOMO_TAILSCALE_FIXTURE=1 go test -count=1 -timeout=300s -tags $(GO_TAGS) -run '^TestTailscaleFixture' ./adapter/outbound/

test-rust: ## rust_api and Helper tests
	$(CARGO) test --manifest-path plugins/rust_api/rust/Cargo.toml
	$(CARGO) test --manifest-path services/helper/Cargo.toml

rust-check: ## Format check and test both Rust crates, as CI does
	$(CARGO) fmt --manifest-path services/helper/Cargo.toml -- --check
	$(CARGO) fmt --manifest-path plugins/rust_api/rust/Cargo.toml -- --check
	$(CARGO) test --manifest-path plugins/rust_api/rust/Cargo.toml
	$(CARGO) test --manifest-path services/helper/Cargo.toml

test-all: test test-go test-rust ## test, test-go and test-rust

##@ Package

package-android: ## Build the Android APKs into dist/ with setup.dart
	$(SETUP) android $(PACKAGE_FLAGS) $(if $(APP_ENV),--env $(APP_ENV)) $(ARGS)

package-linux: ## Build deb, AppImage and rpm on Linux; DRY=1 plans anywhere
	$(call package_platform,linux)

package-macos: ## Build the dmg on macOS; DRY=1 plans anywhere
	$(call package_platform,macos)

package-windows: ## Build the setup exe and zip on Windows; DRY=1 plans anywhere
	$(call package_platform,windows)

##@ Clean

clean: ## flutter clean, which also drops .dart_tool/lib, and remove dist/
	flutter clean
	rm -rf dist

clean-core: ## Drop the staged Core and the build hook cache so the next build reruns the hook
	rm -rf libclash .dart_tool/setup_build_cache
