Pod::Spec.new do |s|
  s.name         = "NitroMisc"
  s.version      = "1.0.2"
  s.summary      = "A lot of helpful code missing in iOS foundation and uikit classes + utility macros."
  s.homepage     = "http://github.com/danielalves/NitroMisc"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Daniel L. Alves"
  s.social_media_url   = "http://twitter.com/alveslopesdan"
  s.source       = { :git => "https://github.com/danielalves/NitroMisc.git", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files  = "NitroMisc/NitroMisc"
  s.xcconfig     = { 'OTHER_LDFLAGS' => '-ObjC' }
  s.requires_arc = true
end
