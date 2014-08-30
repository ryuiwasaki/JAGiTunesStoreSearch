#
# Be sure to run `pod lib lint JAGiTunesStoreSearch.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JAGiTunesStoreSearch"
  s.version          = "1.0.3"
  s.summary          = "iTunesStoreSearch API for Objective-C."
  s.description  = <<-DESC
                   iTunesStoreSearch API for Objective-C.
                   
                   DESC
                   
  s.homepage         = "https://github.com/ryuiwasaki/JAGiTunesStoreSearch"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ryu Iwasaki" => "ryu.contact.jp@gmail.com" }
  s.source           = { :git => "https://github.com/ryuiwasaki/JAGiTunesStoreSearch.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  #s.resources = 'Pod/Assets/*.png'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Reachability'
  s.dependency 'SVProgressHUD'
  s.dependency 'SDWebImage'
  s.dependency 'JAGTableViewController'
  s.dependency 'JAGMultiThreadOperation'
end
