Pod::Spec.new do |s|
  s.name             = 'background_location_tracker'
  s.version          = '1.0.0'
  s.summary          = 'Background location tracking plugin using significant location changes.'
  s.description      = <<-DESC
                       Tracks significant location changes (~1km) in the background using
                       CLLocationManager on iOS and FusedLocationProviderClient on Android.
                       DESC
  s.homepage         = 'https://github.com/YumNumm/EQMonitor'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'YumNumm' => 'yumnumm@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'background_location_tracker/Sources/background_location_tracker/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '14.0'
  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
