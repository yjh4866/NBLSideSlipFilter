#
# Be sure to run `pod lib lint NBLSideSlipFilter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NBLSideSlipFilter'
  s.version          = '0.1.2'
  s.summary          = '侧滑的筛选器视图。filter view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
从侧面滑出的筛选视图的功能。Filter view slip from side.
                       DESC

  s.homepage         = 'https://github.com/yjh4866/NBLSideSlipFilter'
  s.screenshots     = 'https://github.com/yjh4866/NBLSideSlipFilter/blob/master/screenshots/screenshots_1.jpg?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '杨建红' => 'yjh4866@163.com' }
  s.source           = { :git => 'https://github.com/yjh4866/NBLSideSlipFilter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://blog.csdn.net/yjh4866'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NBLSideSlipFilter/Classes/**/*'
  
  s.resource_bundles = {
      'NBLSideSlipFilter' => ['NBLSideSlipFilter/Assets/*.{xib}']
  }

  s.public_header_files = 'NBLSideSlipFilter/Classes/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SDWebImage'
end
