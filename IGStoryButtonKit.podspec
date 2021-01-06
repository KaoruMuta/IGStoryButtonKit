Pod::Spec.new do |spec|
  spec.name = "IGStoryButtonKit"
  spec.version = "1.0.0"
  spec.summary = "IGStoryButtonKit provides an easy-to-use button with rich animation and multiple display inspired by instagram story."
  spec.homepage = "https://github.com/KaoruMuta/IGStoryButtonKit"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.authors = { "Kaoru Muta" => "muttaroni8827@gmail.com" }
  spec.platform = :ios, "13.0"
  spec.source = { :git => "https://github.com/KaoruMuta/IGStoryButtonKit.git", :tag => "#{spec.version}" }
  spec.source_files = "IGStoryButtonKit/**/*.{swift}"
  spec.swift_version = '5.0'
  spec.ios.frameworks = 'UIKit'
  spec.requires_arc = true
end
