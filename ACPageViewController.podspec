Pod::Spec.new do |s|
 
  s.name         = "ACPageViewController"
  s.version      = "0.0.1"
  s.summary      = "A PageViewController subclass with a configuration block and scroll handling."
 
  s.description  = <<-DESC
A PageViewController subclass with a configuration block and scroll handling.
                   DESC
 
  s.homepage     = "https://gist.github.com/andreacremaschi/0aeeea12fa66ca1fbf78"
  
  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author             = { "Andrea Cremaschi" => "andrea.cremaschi@midainformatica.it" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://gist.github.com/0aeeea12fa66ca1fbf78.git", :tag => s.version.to_s }
 
  s.source_files  = "*.{h,m}"

  s.public_header_files = "ACPageViewController.h"
 
  s.requires_arc = true

end