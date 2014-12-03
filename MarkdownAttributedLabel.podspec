Pod::Spec.new do |s|
 
  s.name         = "MarkdownAttributedLabel"
  s.version      = "0.0.1"
  s.summary      = "A TTTAttributedLabel convenience subclass that uses XNGMarkdownParser to parse markdown text."
 
  s.description  = <<-DESC
			
                   DESC
 
  s.homepage     = "https://gist.github.com/ec7f6569fbb612778031.git"
  
  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author             = { "Andrea Cremaschi" => "andrea.cremaschi@midainformatica.it" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://gist.github.com/ec7f6569fbb612778031.git", :tag => "0.0.1" }
 
  s.source_files  = "*.{h,m}"
  s.exclude_files = "Classes/Exclude"
 
  s.public_header_files = "*.h"
 
  s.requires_arc = true
  
  s.dependency 'TTTAttributedLabel'
  s.dependency 'XNGMarkdownParser'
 
end