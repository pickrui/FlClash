Pod::Spec.new do |s|
  s.name = 'tray'
  s.version = '0.0.1'
  s.summary = 'Desktop system tray.'
  s.description = s.summary
  s.homepage = 'https://github.com/chen08209/FlClash'
  s.license = { :file => '../LICENSE' }
  s.author = { 'FlClash' => 'https://github.com/chen08209/FlClash' }
  s.source = { :path => '.' }
  s.source_files = 'tray/Sources/tray/**/*'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '11.0'
  s.swift_version = '5.0'
end
