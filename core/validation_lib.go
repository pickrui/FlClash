//go:build cgo

package main

func isolatedValidateConfigData(data []byte) string {
	err := parseAndValidateConfigData(data)
	if err != nil {
		return "Parse Error: " + err.Error()
	}
	return ""
}
