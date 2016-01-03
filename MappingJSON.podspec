Pod::Spec.new do |s|
  s.name         = "MappingJSON"
  s.version      = "1.0.0"
  s.summary      = "A framework written in Swift for mapping JSON to object"
  s.description  = <<-DESC
MappingJSON is a framework written in Swift to make it easy to map JSON to your object.
DESC
  s.homepage     = "https://github.com/hinoppy/MappingJSON"
  s.license      = "MIT"
  s.author             = { "Shinya Hino" => "shinya.hino@gmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.1"
  s.tvos.deployment_target = "9.1"
  s.source       = { :git => "https://github.com/hinoppy/MappingJSON.git", :tag => s.version }
  s.source_files  = "MappingJSON/*.swift"
  s.requires_arc = true
end
