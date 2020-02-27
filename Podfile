source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

def common_pods
  pod 'Fabric', '1.10.2'
  pod 'Crashlytics', '3.14.0'
  pod 'Intercom', '6.0.2'
end

target 'T_Pro_Intercom' do
  common_pods
end

post_install do |installer|

  puts 'Making SWIFT_EXEC-no-coverage executable'
  system('chmod +x SWIFT_EXEC-no-coverage')

  Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
    File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
  end

  installer.pods_project.targets.each do |target|

    if target.name.include?('URITemplate')
      target.build_configurations.each do |config|
        if config.name.start_with?('Debug')
          config.build_settings['SWIFT_VERSION'] = '4.0'
        end
      end
    end

    target.build_configurations.each do |config|
      if config.name.start_with?('Debug')
        config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end

      # Disable Code Coverage for Pods projects
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      config.build_settings['SWIFT_EXEC'] = '$(SRCROOT)/../SWIFT_EXEC-no-coverage'

    end
  end

end
