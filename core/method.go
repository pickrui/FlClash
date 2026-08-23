package main

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"runtime"
	"unsafe"

	"github.com/metacubex/mihomo/config"
)

type MethodCall struct {
	ID        string          `json:"id,omitempty"`
	Method    CoreMethod      `json:"method"`
	Arguments json.RawMessage `json:"arguments"`
}

func (call MethodCall) decodeArguments(target any) error {
	if len(call.Arguments) == 0 || string(call.Arguments) == "null" {
		return fmt.Errorf("missing arguments")
	}
	return json.Unmarshal(call.Arguments, target)
}

func decodeMethodArguments(call *MethodCall, response MethodResponse, target any) bool {
	if err := call.decodeArguments(target); err != nil {
		response.failure(
			"invalid_arguments",
			fmt.Sprintf("invalid arguments for %s: %v", call.Method, err),
			nil,
		)
		return false
	}
	return true
}

type MethodError struct {
	Code    string `json:"code"`
	Message string `json:"message"`
	Details any    `json:"details"`
}

type MethodResponse struct {
	ID       string       `json:"id,omitempty"`
	Result   any          `json:"result"`
	Error    *MethodError `json:"error,omitempty"`
	callback unsafe.Pointer
}

func (response MethodResponse) JSON() ([]byte, error) {
	return json.Marshal(response)
}

func (response MethodResponse) success(result any) {
	response.Result = result
	response.Error = nil
	response.send()
}

func (response MethodResponse) failure(code, message string, details any) {
	response.Result = nil
	response.Error = &MethodError{Code: code, Message: message, Details: details}
	response.send()
}

func (response MethodResponse) notImplemented(method CoreMethod) {
	response.failure("not_implemented", fmt.Sprintf("unknown method: %s", method), nil)
}

func decodeAndDecrypt(base64Str string) ([]byte, error) {
	decoded, err := base64.StdEncoding.DecodeString(base64Str)
	if err != nil {
		return nil, err
	}
	return decryptFlClashIfNeeded(decoded)
}

func handleMethodCall(call *MethodCall, response MethodResponse) {
	if call.Method == crashMethod {
		handleCrash()
		return
	}
	defer func() {
		if recovered := recover(); recovered != nil {
			buf := make([]byte, 4096)
			n := runtime.Stack(buf, false)
			log.Printf("panic in handleMethodCall(%s): %v\n%s", call.Method, recovered, buf[:n])
			response.failure("internal_error", fmt.Sprintf("internal panic: %v", recovered), nil)
		}
	}()

	switch call.Method {
	case initClashMethod:
		params := InitParams{}
		if !decodeMethodArguments(call, response, &params) {
			return
		}
		response.success(handleInitClash(&params))
	case getIsInitMethod:
		response.success(handleGetIsInit())
	case forceGcMethod:
		handleForceGC()
		response.success(true)
	case shutdownMethod:
		response.success(handleShutdown())
	case validateConfigMethod:
		path := ""
		if decodeMethodArguments(call, response, &path) {
			response.success(handleValidateConfig(path))
		}
	case validateConfigWithBytesMethod:
		encoded := ""
		if !decodeMethodArguments(call, response, &encoded) {
			return
		}
		data, err := decodeAndDecrypt(encoded)
		if err != nil {
			response.failure("core_error", err.Error(), nil)
			return
		}
		response.success(validateConfigData(data))
	case updateConfigMethod:
		params := UpdateParams{}
		if !decodeMethodArguments(call, response, &params) {
			return
		}
		response.success(handleUpdateConfig(&params))
	case setupConfigMethod:
		params := defaultSetupParams()
		if !decodeMethodArguments(call, response, params) {
			return
		}
		response.success(handleSetupConfig(params))
	case getProxiesMethod:
		response.success(handleGetProxies())
	case changeProxyMethod:
		params := ChangeProxyParams{}
		if !decodeMethodArguments(call, response, &params) {
			return
		}
		response.success(handleChangeProxy(&params))
	case getTrafficMethod, getTotalTrafficMethod:
		onlyStatisticsProxy := false
		if !decodeMethodArguments(call, response, &onlyStatisticsProxy) {
			return
		}
		value := handleGetTraffic(onlyStatisticsProxy)
		if call.Method == getTotalTrafficMethod {
			value = handleGetTotalTraffic(onlyStatisticsProxy)
		}
		response.success(value)
	case resetTrafficMethod:
		handleResetTraffic()
		response.success(true)
	case asyncTestDelayMethod:
		params := TestDelayParams{}
		if !decodeMethodArguments(call, response, &params) {
			return
		}
		handleAsyncTestDelay(&params, func(value *Delay) { response.success(value) })
	case getConnectionsMethod:
		response.success(handleGetConnections())
	case closeConnectionsMethod:
		response.success(handleCloseConnections())
	case resetConnectionsMethod:
		response.success(handleResetConnections())
	case closeConnectionMethod:
		id := ""
		if decodeMethodArguments(call, response, &id) {
			response.success(handleCloseConnection(id))
		}
	case getConfigMethod:
		path := ""
		if !decodeMethodArguments(call, response, &path) {
			return
		}
		result, err := handleGetConfig(path)
		if err != nil {
			response.failure("core_error", err.Error(), nil)
			return
		}
		response.success(result)
	case getConfigFromBytesMethod:
		encoded := ""
		if !decodeMethodArguments(call, response, &encoded) {
			return
		}
		data, err := decodeAndDecrypt(encoded)
		if err != nil {
			response.failure("core_error", err.Error(), nil)
			return
		}
		result, err := config.UnmarshalRawConfig(normalizeConfigShortIds(data))
		if err != nil {
			response.failure("core_error", err.Error(), nil)
			return
		}
		response.success(result)
	case getExternalProvidersMethod:
		response.success(handleGetExternalProviders())
	case getExternalProviderMethod:
		name := ""
		if !decodeMethodArguments(call, response, &name) {
			return
		}
		response.success(handleGetExternalProvider(name))
	case updateGeoDataMethod:
		params := UpdateGeoDataParams{}
		if !decodeMethodArguments(call, response, &params) {
			return
		}
		handleUpdateGeoData(params.GeoType, params.GeoName, params.URL, func(value string) {
			response.success(value)
		})
	case updateExternalProviderMethod:
		name := ""
		if decodeMethodArguments(call, response, &name) {
			handleUpdateExternalProvider(name, func(value string) { response.success(value) })
		}
	case sideLoadExternalProviderMethod:
		params := map[string]string{}
		if !decodeMethodArguments(call, response, &params) {
			return
		}
		handleSideLoadExternalProvider(params["providerName"], []byte(params["data"]), func(value string) {
			response.success(value)
		})
	case startLogMethod:
		handleStartLog()
		response.success(true)
	case stopLogMethod:
		handleStopLog()
		response.success(true)
	case startListenerMethod:
		response.success(handleStartListener())
	case stopListenerMethod:
		response.success(handleStopListener())
	case getCountryCodeMethod:
		ip := ""
		if decodeMethodArguments(call, response, &ip) {
			handleGetCountryCode(ip, func(value string) { response.success(value) })
		}
	case getMemoryMethod:
		handleGetMemory(func(value uint64) { response.success(value) })
	case deleteFileMethod:
		path := ""
		if !decodeMethodArguments(call, response, &path) {
			return
		}
		go func() {
			if err := os.RemoveAll(path); err != nil {
				response.failure("core_error", err.Error(), nil)
				return
			}
			response.success("")
		}()
	default:
		response.notImplemented(call.Method)
	}
}
