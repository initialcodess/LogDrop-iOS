Pod::Spec.new do |spec|
  spec.name         = 'LogDrop'
  spec.version      = '1.0.0-beta12'
  spec.summary      = 'LogDrop iOS SDK'
  spec.description  = 'Detect Errors Instantly, Resolve Issues Quickly! ✍️
Monitor Your App in Real-Time, View All Errors on a Single Dashboard!'
  spec.homepage     = 'https://logdrop.io/'
  spec.license      = "MIT"
  spec.author       = { 'InitialCode' => 'engineering@initialcode.io' }
  spec.source       = { :git => 'https://github.com/initialcodess/LogDrop-iOS.git', :tag => "#{spec.version}" }
  spec.ios.deployment_target = '13.0'
  spec.swift_version = '5.0'
  spec.vendored_frameworks = 'Frameworks/LogDropSDK.xcframework'
end

