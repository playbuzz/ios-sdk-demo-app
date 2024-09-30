#source 'https://exco1.jfrog.io/artifactory/api/pods/ios-releases-cocoapods-local'
install! 'cocoapods' ,
:warn_for_unused_master_specs_repo  => false;

workspace 'ExCoSDK-Integration.xcworkspace'

project 'DemoApp/DemoApp.xcodeproj'

platform :ios, '13.0'

target 'DemoApp' do
  project 'DemoApp/DemoApp.xcodeproj'

  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for HostApp
  pod 'XCGLogger'

  pod 'ExcoMobileSDK'
  pod 'OMSDK_Exco', '~> 1.4.8'
  
#  target 'DemoAppTests' do
#    inherit! :search_paths
    # Pods for testing
#  end
  
#  target 'DemoAppUITests' do
    # Pods for testing
#  end
  
end

post_install do |installer|
  
  #installer.pods_project.build_configurations.each do |config|
  #  config.build_settings['ONLY_ACTIVE_ARCH'] = false
  #  config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf-with-dsym';
  #
  #  if config.name == 'Debug'
  #    cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
  #    cflags << '-fembed-bitcode-marker'
  #    config.build_settings['OTHER_CFLAGS'] = cflags
  #
  #    config.build_settings['BITCODE_GENERATION_MODE'] = 'marker'
  #  end
  #  if config.name == 'Release'
  #    cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
  #    cflags << '-fembed-bitcode'
  #    config.build_settings['OTHER_CFLAGS'] = cflags
  #
  #    config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
  #  end
  #end
  
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "11.0"
      # config.build_settings['ONLY_ACTIVE_ARCH'] = false
      # config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "11.0"
      # config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      # config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      # config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      
      #if config.name == 'Debug'
      #  cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
      #  cflags << '-fembed-bitcode-marker'
      #  config.build_settings['OTHER_CFLAGS'] = cflags
      #
      #  config.build_settings['BITCODE_GENERATION_MODE'] = 'marker'
      #end
      #if config.name == 'Release'
      #  cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
      #  cflags << '-fembed-bitcode'
      #  config.build_settings['OTHER_CFLAGS'] = cflags
      #
      #  config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
      #end
    end
  end
end
