Pod::Spec.new do |s|

  s.name         = "UITableView+Header"
  s.version      = "0.0.1"
  s.summary      = "UITableView convenience classes for resizing header and footer with autolayout."

  s.description  = <<-DESC
			
                   DESC

  s.homepage     = "https://gist.github.com/andreacremaschi/833829c80367d751cb83"
  
  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author             = { "Andrea Cremaschi" => "andrea.cremaschi@midainformatica.it" }
  s.platform     = :ios, "5.0"
  s.source       = { :svn => "https://gist.github.com/833829c80367d751cb83.git", :tag => "0.0.1" }

  s.source_files  = "*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.public_header_files = "*.h"

  s.requires_arc = true

end
