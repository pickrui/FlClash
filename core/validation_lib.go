//go:build cgo

package main

func isolatedValidateConfigData(data []byte) string {
	// Android routes validation RPCs to the separate :validator service process,
	// while forwarding runs in :remote. Its temporary General settings and Geo
	// caches therefore cannot affect active traffic. This native wrapper alone
	// does not provide that process boundary; serialize direct native callers
	// with applies so parser rollback cannot undo a newer apply in this process.
	runLock.Lock()
	defer runLock.Unlock()
	err := parseAndValidateConfigData(data)
	if err != nil {
		return "Parse Error: " + err.Error()
	}
	return ""
}
