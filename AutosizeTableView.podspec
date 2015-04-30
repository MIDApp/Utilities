Pod::Spec.new do |s|

  s.name         = "AutosizeTableView"
  s.version      = "0.0.3"
  s.summary      = "UITableView convenience classes for resizing header and footer with autolayout."

  s.description  = <<-DESC
			
                   DESC

  s.homepage     = "https://github.com/MIDApp/Utilities/tree/AutosizeTableView"
  
  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author             = { "Alessio Anesa" => "alessio.anesa@midainformatica.it" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/MIDApp/Utilities.git", :branch => "AutosizeTableView" }

  s.source_files  = "*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.public_header_files = "*.h"

  s.requires_arc = true

end
