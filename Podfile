platform :ios, '12.0'
use_frameworks!
target 'SPHTechTest' do
pod 'Alamofire'
pod 'RxSwift'
pod 'RxAlamofire'
pod 'SwiftyJSON'
pod 'ObjectMapper'
pod 'ReachabilitySwift'
pod 'Bond', '~> 6.10.2'
end
project 'SPHTechTest.xcodeproj'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
