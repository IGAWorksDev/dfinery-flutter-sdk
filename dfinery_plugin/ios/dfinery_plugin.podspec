Pod::Spec.new do |s|
  s.name             = 'dfinery_plugin'
  s.version          = '2.0.0'
  s.summary          = 'Dfinery Flutter Plugin'
  s.description      = <<-DESC
Official Flutter plugin for Dfinery - a Customer Data Platform (CDP) and CRM campaign management solution.
                       DESC
  s.homepage         = 'https://www.dfinery.io'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Dfinery' => 'cs@igaworks.com' }
  s.source           = { :git => 'https://github.com/AdbrixRemaster/dfinery-flutter-sdk.git', :tag => s.version.to_s }
  s.source_files = 'dfinery_plugin/Sources/dfinery_plugin/**/*.swift'
  s.dependency 'Flutter'
  s.dependency "DfinerySDK", "2.5.1"

  s.platform = :ios, '15.0'
  
  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES', 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'IPHONEOS_DEPLOYMENT_TARGET' => '15.0'
  }
  s.swift_version = '5.0'
end
