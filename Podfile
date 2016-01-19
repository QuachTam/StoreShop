source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'
inhibit_all_warnings!

xcodeproj 'StoreManager'

target :StoreManager do
pod 'MagicalRecord'
pod 'PureLayout'
pod 'AFNetworking'
pod 'MBProgressHUD'
pod 'JSONModel'
pod 'WYPopoverController'
pod 'MZFormSheetController'
pod 'MBLocationManager'
pod 'GoogleMaps'
pod 'Parse'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
  end
end