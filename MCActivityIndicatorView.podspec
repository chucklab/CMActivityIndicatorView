Pod::Spec.new do |s|
  s.name         = "MCActivityIndicatorView"
  s.version      = "0.0.3"
  s.summary      = "An activity indicator view."
  s.description  = <<-DESC
  An activity indicator view, have fun.
                   DESC
  s.homepage     = "https://github.com/imegatron/MCActivityIndicatorView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Chao Ma" => "mc@imegatron.com" }
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => "https://github.com/imegatron/MCActivityIndicatorView.git", :tag => "#{s.version}" }
  s.source_files  = "Classes"
  s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/*.h"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
end

