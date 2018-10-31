Pod::Spec.new do |s|
    s.name             = "QuickRollingNotice"
    s.version          = "1.0.3"
    s.summary          = "滚动公告、广告，支持灵活自定义cell。"
    s.description      = <<-DESC
    Roll Notice or Advertising, Customize cell as UITableViewCell supported. 滚动公告、广告，支持灵活自定义cell。
    DESC
    s.homepage         = "https://github.com/pcjbird/QuickRollingNotice"
    s.license          = 'MIT'
    s.author           = {"pcjbird" => "pcjbird@hotmail.com"}
    s.source           = {:git => "https://github.com/pcjbird/QuickRollingNotice.git", :tag => s.version.to_s}
    s.social_media_url = 'http://www.lessney.com'
    s.requires_arc     = true
    #s.documentation_url = ''
    #s.screenshot       = ''

    s.platform         = :ios, '8.0'
    s.frameworks       = 'Foundation', 'UIKit', 'CoreGraphics'
    #s.preserve_paths   = ''
    s.source_files     = 'QuickRollingNotice/*.{h,m}'
    s.public_header_files = 'QuickRollingNotice/*.{h}'


    s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }

end

