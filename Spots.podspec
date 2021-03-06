Pod::Spec.new do |s|
  s.name             = "Spots"
  s.summary          = "Spots is a view controller framework that makes your setup and future development blazingly fast."
  s.version          = "1.1.2"
  s.homepage         = "https://github.com/hyperoslo/Spots"
  s.license          = 'MIT'
  s.author           = { "Hyper Interaktiv AS" => "ios@hyper.no" }
  s.source           = { :git => "https://github.com/hyperoslo/Spots.git" }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
#adfdfd



  s.requires_arc = true
  s.ios.source_files = 'Sources/{iOS,Shared}/**/*'
  s.osx.source_files = 'Sources/{Shared}/**/*'

  s.frameworks = 'Foundation'

end
