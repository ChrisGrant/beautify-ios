#
# Be sure to run `pod lib lint beautify.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#

Pod::Spec.new do |s|
  s.name             = "beautify"
  s.version          = "0.1.0"
  s.summary          = "Beautify enhances Apple's UIKit controls, re-rendering them to give you much more control over their visual appearance."
  s.description      = <<-DESC
                       You can add beautify to your application with cocoapods. Once added, all the UIKit controls are re-rendered with a style that matches the native look and feel. The extra rendering capabilities that beautify provides are accessible via a renderer property.
                       DESC
  s.homepage         = "http://beautify.io/"
  s.license          = 'Apache'
  s.author           = { "Chris Grant" => "christopherscottgrant@gmail.com" }
  s.source           = { :git => "https://github.com/beautify/beautify-ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Beautifyio'

  s.platform     	 = :ios, '7.0'
  s.requires_arc 	 = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.public_header_files = 'Pod/Classes/**/*.h'

  s.frameworks = 'UIKit'
  s.dependency 'JSONModel', '1.0.1'
end
