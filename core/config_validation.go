package main

import (
	"fmt"
	"io"
	"maps"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"sync"

	adapterProvider "github.com/metacubex/mihomo/adapter/provider"
	mihomoYaml "github.com/metacubex/mihomo/common/yaml"
	metaAge "github.com/metacubex/mihomo/component/age"
	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	providerConstant "github.com/metacubex/mihomo/constant/provider"
	"github.com/metacubex/mihomo/rules"
	ruleBundle "github.com/metacubex/mihomo/rules/bundle"
	ruleProvider "github.com/metacubex/mihomo/rules/provider"
	"github.com/metacubex/mihomo/tunnel"
	metaTLS "github.com/metacubex/tls"
)

var configValidationMutex sync.Mutex

func parseAndValidateConfigData(data []byte) error {
	configValidationMutex.Lock()
	defer configValidationMutex.Unlock()
	previousForceSafePathCheck := constant.SetForceSafePathCheck(true)
	defer constant.SetForceSafePathCheck(previousForceSafePathCheck)
	rawConfig, err := prepareValidationConfig(data)
	if err != nil {
		return err
	}
	rawConfig.GeoXUrl.GeoIp = "validator://disabled"
	rawConfig.GeoXUrl.Mmdb = "validator://disabled"
	rawConfig.GeoXUrl.ASN = "validator://disabled"
	rawConfig.GeoXUrl.GeoSite = "validator://disabled"
	parsedConfig, err := config.ParseRawConfig(rawConfig)
	if err != nil {
		return err
	}
	closeParsedProviders(parsedConfig)
	for name, mapping := range rawConfig.ProxyProvider {
		if mapping["type"] != "file" {
			continue
		}
		validationMapping := maps.Clone(mapping)
		validationMapping["health-check"] = map[string]any{"enable": false}
		provider, err := adapterProvider.ParseProxyProvider(
			name,
			validationMapping,
			tunnel.Tunnel,
		)
		if err != nil {
			return fmt.Errorf("proxy provider %s: %w", name, err)
		}
		if proxyProvider, ok := provider.(*adapterProvider.ProxySetProvider); ok {
			defer proxyProvider.Close()
		}
		if err = provider.Initial(); err != nil {
			return fmt.Errorf("proxy provider %s: %w", name, err)
		}
	}
	ruleProvider.SetTunnel(tunnel.Tunnel)
	for name, mapping := range rawConfig.RuleProvider {
		if mapping["type"] != "file" {
			continue
		}
		provider, err := ruleProvider.ParseRuleProvider(
			name,
			maps.Clone(mapping),
			rules.ParseRule,
			ruleBundle.MakeBundleFile,
		)
		if err != nil {
			return fmt.Errorf("rule provider %s: %w", name, err)
		}
		if rulesProvider, ok := provider.(*ruleProvider.RuleSetProvider); ok {
			defer rulesProvider.Close()
		}
		if err = provider.Initial(); err != nil {
			return fmt.Errorf("rule provider %s: %w", name, err)
		}
	}
	return nil
}

func prepareValidationResources(data []byte) error {
	_, err := prepareValidationConfig(data)
	return err
}

func prepareValidationConfig(data []byte) (*config.RawConfig, error) {
	rawConfig, err := config.UnmarshalRawConfig(normalizeConfigShortIds(data))
	if err != nil {
		return nil, err
	}
	sourceHome := GlobalValidationSourceHome
	if sourceHome == "" {
		sourceHome = os.Getenv("FLCLASH_VALIDATION_SOURCE_HOME")
	}
	targetHome := constant.Path.HomeDir()
	if sourceHome == "" || sourceHome == targetHome {
		return rawConfig, nil
	}
	const (
		maxFileBytes  = 128 * 1024 * 1024
		maxTotalBytes = 256 * 1024 * 1024
		maxEntries    = 4096
	)
	paths := map[string]struct{}{}
	sourceRoot, err := os.OpenRoot(sourceHome)
	if err != nil {
		return nil, err
	}
	defer sourceRoot.Close()
	if err := collectValidationGeoPaths(sourceHome, paths); err != nil {
		return nil, err
	}
	if err := collectValidationResourcePaths(rawConfig, sourceHome, paths); err != nil {
		return nil, err
	}
	var totalBytes int64
	entries := 0
	visited := map[string]struct{}{}
	copyPaths := func() error {
		for relative := range paths {
			if relative == "" {
				continue
			}
			if relative == "." || filepath.IsAbs(relative) || !filepath.IsLocal(relative) {
				return fmt.Errorf("validation resource path must be relative to the app home: %s", relative)
			}
			source := filepath.Join(sourceHome, relative)
			hasLink, err := validationPathHasLink(sourceHome, relative)
			if err != nil {
				return err
			}
			if hasLink {
				return fmt.Errorf(
					"validation resource path cannot contain links or reparse points: %s",
					source,
				)
			}
			if _, err := os.Lstat(source); os.IsNotExist(err) {
				continue
			} else if err != nil {
				return err
			}
			if err := copyValidationResource(
				sourceRoot,
				relative,
				filepath.Join(targetHome, relative),
				&entries,
				&totalBytes,
				maxEntries,
				maxFileBytes,
				maxTotalBytes,
				visited,
			); err != nil {
				return err
			}
		}
		return nil
	}
	if err := copyPaths(); err != nil {
		return nil, err
	}
	if err := collectFileProviderResourcePaths(rawConfig, sourceHome, targetHome, paths); err != nil {
		return nil, err
	}
	if err := copyPaths(); err != nil {
		return nil, err
	}
	return rawConfig, nil
}

func collectValidationGeoPaths(sourceHome string, paths map[string]struct{}) error {
	entries, err := os.ReadDir(sourceHome)
	if os.IsNotExist(err) {
		return nil
	}
	if err != nil {
		return err
	}
	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}
		switch strings.ToLower(entry.Name()) {
		case "asn.mmdb", "country.mmdb", "geoip.db", "geoip.metadb", "geoip.dat", "geosite.dat":
			paths[entry.Name()] = struct{}{}
		}
	}
	return nil
}

func collectFileProviderResourcePaths(
	rawConfig *config.RawConfig,
	sourceHome string,
	targetHome string,
	paths map[string]struct{},
) error {
	for _, mapping := range rawConfig.ProxyProvider {
		if mapping["type"] != "file" {
			continue
		}
		path, _ := mapping["path"].(string)
		if path == "" || filepath.IsAbs(path) || !filepath.IsLocal(path) {
			continue
		}
		data, err := os.ReadFile(filepath.Join(targetHome, path))
		if os.IsNotExist(err) {
			continue
		}
		if err != nil {
			return err
		}
		ageSecretKey, _ := mapping["age-secret-key"].(string)
		data, err = metaAge.DecryptBytes(data, ageSecretKey)
		if err != nil {
			return fmt.Errorf("decrypt proxy provider %s: %w", path, err)
		}
		var document map[string]any
		if err := mihomoYaml.Unmarshal(data, &document); err != nil {
			continue
		}
		proxies, valid := strictProxyMappings(document["proxies"])
		if !valid {
			continue
		}
		if err := collectOutboundResourcePaths(proxies, sourceHome, paths); err != nil {
			return err
		}
		document["proxies"] = proxies
		normalized, err := mihomoYaml.Marshal(document)
		if err != nil {
			return err
		}
		if err := os.WriteFile(filepath.Join(targetHome, path), normalized, 0o600); err != nil {
			return err
		}
	}
	return nil
}

func strictProxyMappings(value any) ([]map[string]any, bool) {
	if mappings, ok := value.([]map[string]any); ok {
		return mappings, len(mappings) > 0
	}
	items, ok := value.([]any)
	if !ok || len(items) == 0 {
		return nil, false
	}
	mappings := make([]map[string]any, 0, len(items))
	for _, item := range items {
		mapping, ok := item.(map[string]any)
		if !ok {
			return nil, false
		}
		mappings = append(mappings, mapping)
	}
	return mappings, true
}

func collectValidationResourcePaths(
	rawConfig *config.RawConfig,
	sourceHome string,
	paths map[string]struct{},
) error {
	for _, providers := range []map[string]map[string]any{
		rawConfig.ProxyProvider,
		rawConfig.RuleProvider,
	} {
		for _, mapping := range providers {
			providerType, _ := mapping["type"].(string)
			if providerType != "file" && providerType != "http" {
				continue
			}
			if err := normalizeValidationMappingPath(
				mapping,
				"path",
				sourceHome,
				paths,
				providerType == "file",
			); err != nil {
				return err
			}
		}
	}
	if err := normalizeValidationStringPath(&rawConfig.ExternalUI, sourceHome); err != nil {
		return err
	}
	if err := collectOutboundResourcePaths(rawConfig.Proxy, sourceHome, paths); err != nil {
		return err
	}
	for _, mapping := range rawConfig.ProxyProvider {
		if mapping["type"] == "inline" {
			if err := collectOutboundResourcePaths(
				asProxyMappings(mapping["payload"]),
				sourceHome,
				paths,
			); err != nil {
				return err
			}
		}
	}
	return nil
}

func collectOutboundResourcePaths(
	proxies []map[string]any,
	sourceHome string,
	paths map[string]struct{},
) error {
	addKeyPair := func(mapping map[string]any, certificateKey, privateKeyKey string) error {
		certificateText, _ := mapping[certificateKey].(string)
		privateKeyText, _ := mapping[privateKeyKey].(string)
		if certificateText == "" && privateKeyText == "" {
			return nil
		}
		if _, err := metaTLS.X509KeyPair(
			[]byte(certificateText),
			[]byte(privateKeyText),
		); err == nil {
			return nil
		}
		if err := normalizeValidationMappingPath(
			mapping,
			certificateKey,
			sourceHome,
			paths,
			true,
		); err != nil {
			return err
		}
		return normalizeValidationMappingPath(
			mapping,
			privateKeyKey,
			sourceHome,
			paths,
			true,
		)
	}
	for _, proxy := range proxies {
		proxyType, _ := proxy["type"].(string)
		switch proxyType {
		case "ssh":
			privateKey, _ := proxy["private-key"].(string)
			if !strings.Contains(privateKey, "PRIVATE KEY") {
				if err := normalizeValidationMappingPath(
					proxy,
					"private-key",
					sourceHome,
					paths,
					true,
				); err != nil {
					return err
				}
			}
		case "http", "socks5":
			if validationBool(proxy["tls"]) {
				if err := addKeyPair(proxy, "certificate", "private-key"); err != nil {
					return err
				}
			}
		case "hysteria", "hysteria2", "tuic":
			if err := addKeyPair(proxy, "certificate", "private-key"); err != nil {
				return err
			}
			if proxyType == "hysteria2" {
				realm := asStringMap(proxy["realm-opts"])
				if validationBool(realm["enable"]) {
					if err := addKeyPair(realm, "certificate", "private-key"); err != nil {
						return err
					}
				}
			}
		case "trusttunnel":
			if validationBool(proxy["quic"]) {
				if err := addKeyPair(proxy, "certificate", "private-key"); err != nil {
					return err
				}
			}
		case "snell":
			obfs := asStringMap(proxy["obfs-opts"])
			if obfs["mode"] == "ech-tls" {
				if err := normalizeValidationMappingPath(
					obfs,
					"ech-config-file",
					sourceHome,
					paths,
					true,
				); err != nil {
					return err
				}
			}
		case "tailscale":
			if err := normalizeValidationMappingPath(
				proxy,
				"state-dir",
				sourceHome,
				paths,
				false,
			); err != nil {
				return err
			}
		}
	}
	return nil
}

func normalizeValidationMappingPath(
	mapping map[string]any,
	key string,
	sourceHome string,
	paths map[string]struct{},
	copyResource bool,
) error {
	value, ok := mapping[key].(string)
	if !ok || strings.TrimSpace(value) == "" {
		return nil
	}
	relative, err := validationRelativePath(sourceHome, value)
	if err != nil {
		return err
	}
	mapping[key] = relative
	if copyResource {
		paths[relative] = struct{}{}
	}
	return nil
}

func normalizeValidationStringPath(value *string, sourceHome string) error {
	if strings.TrimSpace(*value) == "" {
		return nil
	}
	relative, err := validationRelativePath(sourceHome, *value)
	if err != nil {
		return err
	}
	*value = relative
	return nil
}

func validationRelativePath(sourceHome, value string) (string, error) {
	cleaned := filepath.Clean(strings.TrimSpace(value))
	if filepath.IsAbs(cleaned) {
		relative, err := filepath.Rel(sourceHome, cleaned)
		if err != nil || relative == "." || !filepath.IsLocal(relative) {
			return "", fmt.Errorf(
				"validation resource path must be inside the app home: %s",
				value,
			)
		}
		return relative, nil
	}
	if cleaned == "." || !filepath.IsLocal(cleaned) {
		return "", fmt.Errorf(
			"validation resource path must be relative to the app home: %s",
			value,
		)
	}
	return cleaned, nil
}

func asProxyMappings(value any) []map[string]any {
	if mappings, ok := value.([]map[string]any); ok {
		return mappings
	}
	items, _ := value.([]any)
	mappings := make([]map[string]any, 0, len(items))
	for _, item := range items {
		if mapping := asStringMap(item); mapping != nil {
			mappings = append(mappings, mapping)
		}
	}
	return mappings
}

func asStringMap(value any) map[string]any {
	mapping, _ := value.(map[string]any)
	return mapping
}

func validationBool(value any) bool {
	if boolean, ok := value.(bool); ok {
		return boolean
	}
	text, ok := value.(string)
	if !ok {
		return false
	}
	boolean, _ := strconv.ParseBool(text)
	return boolean
}

func validationPathHasLink(root, relative string) (bool, error) {
	current := root
	for _, part := range strings.Split(filepath.Clean(relative), string(os.PathSeparator)) {
		current = filepath.Join(current, part)
		info, err := os.Lstat(current)
		if os.IsNotExist(err) {
			return false, nil
		}
		if err != nil {
			return false, err
		}
		if validationPathEntryIsLink(info) {
			return true, nil
		}
	}
	return false, nil
}

func openValidationResource(sourceRoot *os.Root, relative string) (*os.File, error) {
	input, err := sourceRoot.Open(relative)
	if err == nil || !shouldFallbackValidationResourceOpen(err) {
		return input, err
	}
	return openValidationResourceFallback(sourceRoot, relative)
}

func openValidationResourceFallback(sourceRoot *os.Root, relative string) (*os.File, error) {
	sourceHome := sourceRoot.Name()
	source := filepath.Join(sourceHome, relative)
	input, err := os.Open(source)
	if err != nil {
		return nil, err
	}
	closeWithError := func(err error) (*os.File, error) {
		_ = input.Close()
		return nil, err
	}
	hasLink, err := validationPathHasLink(sourceHome, relative)
	if err != nil {
		return closeWithError(err)
	}
	if hasLink {
		return closeWithError(fmt.Errorf(
			"validation resource path cannot contain links or reparse points: %s",
			source,
		))
	}
	pathInfo, err := os.Lstat(source)
	if err != nil {
		return closeWithError(err)
	}
	if validationPathEntryIsLink(pathInfo) {
		return closeWithError(fmt.Errorf(
			"validation resource path cannot contain links or reparse points: %s",
			source,
		))
	}
	inputInfo, err := input.Stat()
	if err != nil {
		return closeWithError(err)
	}
	if !os.SameFile(pathInfo, inputInfo) {
		return closeWithError(fmt.Errorf("validation resource changed while opening: %s", source))
	}
	return input, nil
}

func copyValidationResource(
	sourceRoot *os.Root,
	relative string,
	target string,
	entries *int,
	totalBytes *int64,
	maxEntries int,
	maxFileBytes int64,
	maxTotalBytes int64,
	visited map[string]struct{},
) error {
	cleanSource := filepath.Clean(relative)
	if _, exists := visited[cleanSource]; exists {
		return nil
	}
	visited[cleanSource] = struct{}{}
	input, err := openValidationResource(sourceRoot, relative)
	if err != nil {
		return err
	}
	defer input.Close()
	info, err := input.Stat()
	if err != nil {
		return err
	}
	*entries++
	if *entries > maxEntries {
		return fmt.Errorf("validation resources have too many entries")
	}
	if info.Mode()&os.ModeSymlink != 0 {
		return fmt.Errorf("validation resource cannot be a symbolic link: %s", relative)
	}
	if info.IsDir() {
		return fmt.Errorf("validation resource must be a regular file: %s", relative)
	}
	if !info.Mode().IsRegular() {
		return nil
	}
	if info.Size() > maxFileBytes {
		return fmt.Errorf("validation resource is too large: %s", relative)
	}
	remaining := maxTotalBytes - *totalBytes
	if remaining < 0 {
		return fmt.Errorf("validation resources exceed size limit")
	}
	if err := os.MkdirAll(filepath.Dir(target), 0o700); err != nil {
		return err
	}
	output, err := os.OpenFile(target, os.O_CREATE|os.O_EXCL|os.O_WRONLY, 0o600)
	if err != nil {
		return err
	}
	limit := min(maxFileBytes, remaining)
	written, copyErr := io.Copy(output, io.LimitReader(input, limit+1))
	closeErr := output.Close()
	if copyErr != nil {
		return copyErr
	}
	if written > limit {
		_ = os.Remove(target)
		return fmt.Errorf("validation resources exceed size limit: %s", relative)
	}
	*totalBytes += written
	return closeErr
}

func closeParsedProviders(parsedConfig *config.Config) {
	for _, provider := range parsedConfig.Providers {
		if proxyProvider, ok := provider.(*adapterProvider.ProxySetProvider); ok &&
			provider.VehicleType() != providerConstant.Inline {
			_ = proxyProvider.Close()
		}
	}
	for _, provider := range parsedConfig.RuleProviders {
		if rulesProvider, ok := provider.(*ruleProvider.RuleSetProvider); ok &&
			provider.VehicleType() != providerConstant.Inline {
			_ = rulesProvider.Close()
		}
	}
}
