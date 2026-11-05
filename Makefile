SHELL := /bin/bash
include tool/go_build_tags.env
# The release harness builds with this toolchain; GOTOOLCHAIN=local overrides it.
GOTOOLCHAIN ?= go1.26.9

.PHONY: help submodules hooks analyze format lint test test-safe test-macos-isolated test-go test-tailscale test-rust test-all

help:
	@echo 'make submodules     # update git submodules (Clash.Meta core, flutter_distributor)'
	@echo 'make hooks          # install the pre-commit, pre-push and commit-msg hooks'
	@echo 'make analyze        # dart analyze lib test tool'
	@echo 'make format         # format owned Dart sources'
	@echo 'make lint           # comment density gate over the working tree'
	@echo 'make test           # flutter test with the native asset hooks switched off'
	@echo 'make test-safe      # isolated desktop safe-mode checks'
	@echo 'make test-macos-isolated # offline macOS GUI smoke test (APP=/path/to/safe.app)'
	@echo 'make test-go        # Go core tests'
	@echo 'make test-tailscale # Tailscale outbound against the official test control server'
	@echo 'make test-rust      # rust_api and helper tests'
	@echo 'make test-all       # test, test-go and test-rust'
	@echo ''
	@echo 'Packaging stays with setup.dart; see AGENTS.md.'

submodules:
	git submodule update --init --recursive

hooks:
	pre-commit install --install-hooks
	pre-commit install --hook-type commit-msg --hook-type pre-push

analyze:
	dart analyze lib test tool

format:
	python3 tool/check_dart_format.py --write

lint:
	./tool/check_comment_density.sh < /dev/null

test:
	dart tool/run_tests.dart $(FLUTTER_TEST_ARGS)

test-safe:
	dart tool/run_tests.dart --dart-define=SAFE_MODE=true test/safe_mode test/common/safe_mode_profile_test.dart

test-macos-isolated:
	python3 tool/run_macos_isolated.py --app "$(APP)" $(MACOS_TEST_ARGS)

test-go:
	cd core && GOTOOLCHAIN=$(GOTOOLCHAIN) CGO_ENABLED=0 go test -tags $(GO_TAGS) ./...

test-tailscale:
	cd core/Clash.Meta && GOTOOLCHAIN=$(GOTOOLCHAIN) MIHOMO_TAILSCALE_FIXTURE=1 go test -count=1 -timeout=300s -tags $(GO_TAGS) -run '^TestTailscaleFixture' ./adapter/outbound/

test-rust:
	cargo test --manifest-path plugins/rust_api/rust/Cargo.toml
	cargo test --manifest-path services/helper/Cargo.toml

test-all: test test-go test-rust
