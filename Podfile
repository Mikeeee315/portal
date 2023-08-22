
# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'portal' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for portal
  
  #MSAL
  pod 'MSAL'

  # Notifications
  pod 'Firebase/Messaging'

  # Networking
  pod 'Moya/RxSwift'

  # Security
  pod 'KeychainSwift'

  # UI
  pod 'IQKeyboardManager'
  pod 'Kingfisher', '~> 4.10.0'
  pod 'MBProgressHUD'
  pod 'PopupDialog'
  pod 'RxCocoa'
  pod 'SnapKit'

  # Crash Reporting
  pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '8.8.0'

  
	post_install do |installer|
		installer.generated_projects.each do |project|
			project.targets.each do |target|
				target.build_configurations.each do |config|
					config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
					config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
				end
			end
		end
	end

  
end
