Pod::Spec.new do |s|
  s.name             = 'FirebaseHelper'
  s.version          = '1.0.0'
  s.summary          = 'Safe and easy wrappers for common Firebase Database functions.'
  s.description      = 'Safe and easy wrappers for common Firebase Database functions like get, set, delete, and increment. Also for creating a DatabaseReference with specified children added to its path. Filters the children and throws an error if a child key is invalid, such as a blank or double slashes. Without this check, Firebase Database crashes at runtime.'
  s.homepage         = 'https://github.com/quanvo87/FirebaseHelper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'quanvo87' => 'qvo1987@gmail.com', 'Wilson Ding' => 'hello@wilsonding.com' }
  s.source           = { :git => 'https://github.com/quanvo87/FirebaseHelper.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.swift_version = '4.0.3'
  s.source_files = 'FirebaseHelper/Classes/**/*'
  s.static_framework = true
  s.dependency 'Firebase/Database', '~> 4.1'
end

