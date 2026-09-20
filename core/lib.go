//go:build cgo

package main

/*
#include <stdlib.h>
*/
import "C"

import (
	"core/platform"
	t "core/tun"
	"encoding/json"
	"errors"
	"net"
	"strings"
	"sync"
	"sync/atomic"
	"syscall"
	"unsafe"

	"github.com/metacubex/mihomo/component/dialer"
	"github.com/metacubex/mihomo/component/process"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/dns"
	"github.com/metacubex/mihomo/listener/sing_tun"
	"github.com/metacubex/mihomo/log"
)

var (
	eventListenerLock sync.RWMutex
	eventListener     unsafe.Pointer
)

type TunHandler struct {
	listener *sing_tun.Listener
	callback unsafe.Pointer

	callbacks tunCallbackLease
}

func (th *TunHandler) start(fd int, stack, address, dns string, mtu int) bool {
	runLock.Lock()
	defer runLock.Unlock()
	th.initHook()
	tunListener := t.Start(fd, stack, address, dns, mtu)
	if tunListener != nil {
		log.Infoln("TUN address: %v", tunListener.Address())
		th.listener = tunListener
		th.callbacks.activate()
		return true
	}
	th.clear()
	return false
}

func (th *TunHandler) close() { th.clear() }

func (th *TunHandler) clear() {
	th.callbacks.close()
	if th.listener != nil {
		_ = th.listener.Close()
	}
	th.removeHook()
	th.listener = nil
}

func (th *TunHandler) handleProtect(fd int) error {
	return th.callbacks.protect(fd, func(fd int) bool { return protect(th.callback, fd) })
}

func (th *TunHandler) handleResolveProcess(source, target net.Addr) string {
	var result string
	th.callbacks.use(func() {
		var protocol int
		uid := -1
		switch source.Network() {
		case "udp", "udp4", "udp6":
			protocol = syscall.IPPROTO_UDP
		case "tcp", "tcp4", "tcp6":
			protocol = syscall.IPPROTO_TCP
		}
		if version < 29 {
			uid = platform.QuerySocketUidFromProcFs(source, target)
		}
		result = resolveProcess(th.callback, protocol, source.String(), target.String(), uid)
	})
	return result
}

var activeTunHandler atomic.Pointer[TunHandler]

// Install function pointers before any Core goroutines can read them. Only the
// active handler changes on start/stop; an old callback cannot clear a new one.
func init() {
	dialer.DefaultSocketHook = func(network, address string, conn syscall.RawConn) error {
		if platform.ShouldBlockConnection() {
			return errBlocked
		}
		th := activeTunHandler.Load()
		if th == nil {
			return nil
		}
		return protectSocket(conn, th.handleProtect)
	}
	process.DefaultPackageNameResolver = func(metadata *constant.Metadata) (string, error) {
		th := activeTunHandler.Load()
		if th == nil {
			return "", process.ErrInvalidNetwork
		}
		src, dst := metadata.RawSrcAddr, metadata.RawDstAddr
		if src == nil || dst == nil {
			return "", process.ErrInvalidNetwork
		}
		return th.handleResolveProcess(src, dst), nil
	}
}

func (th *TunHandler) initHook()   { activeTunHandler.Store(th) }
func (th *TunHandler) removeHook() { activeTunHandler.CompareAndSwap(th, nil) }

var (
	tunLock    sync.Mutex
	errBlocked = errors.New("blocked")
	tunHandler *TunHandler
)

func handleStopTun() {
	tunLock.Lock()
	defer tunLock.Unlock()
	if tunHandler != nil {
		tunHandler.close()
		tunHandler = nil
	}
	handleStopListener()
}

func handleStartTun(callback unsafe.Pointer, fd int, stack, address, dns string, mtu int) bool {
	tunLock.Lock()
	defer tunLock.Unlock()
	if tunHandler != nil {
		tunHandler.close()
		tunHandler = nil
	}
	if fd <= 0 || callback == nil {
		if fd >= 0 {
			_ = syscall.Close(fd)
		}
		if callback != nil {
			releaseObject(callback)
		}
		handleStopListener()
		return false
	}
	tunHandler = &TunHandler{
		callback:  callback,
		callbacks: tunCallbackLease{release: func() { releaseObject(callback) }},
	}
	if !tunHandler.start(fd, stack, address, dns, mtu) {
		tunHandler = nil
		handleStopListener()
		return false
	}
	if !handleStartListener() {
		tunHandler.close()
		tunHandler = nil
		handleStopListener()
		return false
	}
	return true
}

func handleUpdateDns(value string) {
	go func() {
		log.Infoln("[DNS] updateDns %s", value)
		dns.UpdateSystemDNS(strings.Split(value, ","))
		dns.FlushCacheWithDefaultResolver()
	}()
}

func (response MethodResponse) send() {
	defer releaseObject(response.callback)
	data, err := response.JSON()
	if err != nil {
		return
	}
	invokeResult(response.callback, string(data))
}

//export invokeMethod
func invokeMethod(callback unsafe.Pointer, paramsChar *C.char) {
	params := takeCString(paramsChar)
	call := &MethodCall{}
	err := json.Unmarshal([]byte(params), call)
	if err != nil {
		response := MethodResponse{callback: callback}
		response.failure("invalid_method_call", err.Error(), nil)
		return
	}
	response := MethodResponse{
		ID:       call.ID,
		callback: callback,
	}
	go handleMethodCall(call, response)
}

//export startTUN
func startTUN(callback unsafe.Pointer, fd, mtu C.int, stackChar, addressChar, dnsChar *C.char) bool {
	return handleStartTun(callback, int(fd), takeCString(stackChar), takeCString(addressChar), takeCString(dnsChar), int(mtu))
}

//export quickSetup
func quickSetup(callback unsafe.Pointer, initParamsChar *C.char, setupParamsChar *C.char) {
	go func() {
		defer releaseObject(callback)
		initParamsString := takeCString(initParamsChar)
		setupParamsString := takeCString(setupParamsChar)
		initParams := InitParams{}
		if err := UnmarshalJson([]byte(initParamsString), &initParams); err != nil {
			invokeResult(callback, err.Error())
			return
		}
		setupParams := defaultSetupParams()
		if err := UnmarshalJson([]byte(setupParamsString), setupParams); err != nil {
			invokeResult(callback, err.Error())
			return
		}
		if !handleInitClash(&initParams) {
			invokeResult(callback, "init failed")
			return
		}
		runLock.Lock()
		isRunning = true
		runLock.Unlock()
		message := handleSetupConfig(setupParams)
		if message != "" {
			handleStopListener()
		}
		invokeResult(callback, message)
	}()
}

//export setEventListener
func setEventListener(listener unsafe.Pointer) {
	eventListenerLock.Lock()
	defer eventListenerLock.Unlock()
	if eventListener != nil {
		releaseObject(eventListener)
	}
	eventListener = listener
}

//export getTotalTraffic
func getTotalTraffic(onlyStatisticsProxy bool) *C.char {
	return C.CString(marshalResult(handleGetTotalTraffic(onlyStatisticsProxy)))
}

//export getTraffic
func getTraffic(onlyStatisticsProxy bool) *C.char {
	return C.CString(marshalResult(handleGetTraffic(onlyStatisticsProxy)))
}

func marshalResult(value any) string {
	data, err := json.Marshal(value)
	if err != nil {
		return ""
	}
	return string(data)
}

func sendMessageBatch(messages []Message) {
	eventListenerLock.RLock()
	defer eventListenerLock.RUnlock()
	if eventListener == nil {
		return
	}
	arguments, err := json.Marshal(messages)
	if err != nil {
		return
	}
	call := MethodCall{Method: messageMethod, Arguments: arguments}
	data, err := json.Marshal(call)
	if err != nil {
		return
	}
	invokeResult(eventListener, string(data))
}

//export stopTun
func stopTun() {
	handleStopTun()
}

//export suspend
func suspend(suspended bool) {
	handleSuspend(suspended)
}

//export forceGC
func forceGC() {
	handleForceGC()
}

//export updateDns
func updateDns(s *C.char) {
	handleUpdateDns(takeCString(s))
}
