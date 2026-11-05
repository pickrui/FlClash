package main

const (
	linuxInterfaceNameMaxBytes = 15
	linuxTunDeviceName         = "FlClash"
)

func normalizeTunDeviceName(device, goos string) string {
	if goos == "linux" && len(device) > linuxInterfaceNameMaxBytes {
		return linuxTunDeviceName
	}
	return device
}
