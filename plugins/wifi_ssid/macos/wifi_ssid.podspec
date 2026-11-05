Pod::Spec.new do |s|
  s.name = 'wifi_ssid'
  s.version = '0.0.1'
  s.summary = 'Wi-Fi SSID and permission access.'
  s.description = s.summary
  s.homepage = 'https://github.com/chen08209/FlClash'
  s.license = { :file => '../LICENSE' }
  s.author = { 'FlClash' => 'https://github.com/chen08209/FlClash' }
  s.source = { :path => '.' }
  s.source_files = 'wifi_ssid/Sources/wifi_ssid/**/*'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '11.0'
  s.swift_version = '5.0'
  s.frameworks = 'CoreWLAN', 'CoreLocation'
end
