Pod::Spec.new do |spec|
  spec.name         = 'LogDrop'
  spec.version      = '1.0.10-alpha1'
  spec.summary      = 'Lightweight real-time log and crash tracking SDK for iOS.'
  spec.description  = <<-DESC
    LogDrop helps developers monitor app behavior and crashes in real-time through a visual dashboard.
    Simple to integrate, powerful in production. Monitor your app in real-time, view all errors on a single dashboard!
  DESC
  spec.homepage     = 'https://logdrop.io/'
  spec.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Copyright 2025 Initial Code Software Solutions

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
  LICENSE
  }
  spec.author       = { 'InitialCode' => 'engineering@initialcode.io' }
  spec.source       = { :git => 'https://github.com/initialcodess/LogDrop-iOS.git', :tag => spec.version }
  spec.ios.deployment_target = '13.0'
  spec.swift_version = '5.0'
  spec.vendored_frameworks = 'Frameworks/LogDropSDK.xcframework'
  spec.resources = ['upload_dsym.sh']
end


