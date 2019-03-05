#
# Be sure to run `pod lib lint WBTabbar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WBTabbar'
  s.version          = '0.1.0'
  s.summary          = '一个功能丰富的tabbar'

  s.description      = <<-DESC
  自定义的tabbar，功能丰富，简单易用
                       DESC

  s.homepage         = 'https://github.com/WangBoX/WBTabbar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WangBoX' => '563915318@qq.com' }
  s.source           = { :git => 'https://github.com/WangBoX/WBTabbar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'WBTabbar/Classes/**/*'
  
   s.resource_bundles = {
     'WBTabbar' => ['WBTabbar/Assets/*.bundle']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
