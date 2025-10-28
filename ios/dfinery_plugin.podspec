Pod::Spec.new do |s|
  s.name             = 'dfinery_plugin'
  s.version          = '1.0.2'
  s.summary          = 'Dfinery Flutter Plugin'
  s.description      = <<-DESC
Dfinery Flutter Plugin
                       DESC
  s.homepage         = 'https://www.dfinery.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Dfinery' => 'cs@igaworks.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency "DfinerySDK", "2.3.2"
  s.dependency "DfinerySDKServiceExtension", "2.3.2"

  s.platform = :ios, '12.0'
  
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
