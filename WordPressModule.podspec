Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "WordPressModule"
s.summary = "WordPressModule "
s.requires_arc = true

# 2
s.version = "0.1.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Afsara" => "afsarunnisa@wavelabs.in" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/Afsarunnisa/WordPressModule"

# For example,
# s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/Afsarunnisa/WordPressModule.git", :tag => "#{s.version}"}

# For example,
# s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"
s.dependency 'BTNavigationDropdownMenu', :git => 'https://github.com/PhamBaTho/BTNavigationDropdownMenu.git', :branch => 'swift-3.0'


s.dependency 'RealmSwift'
s.dependency 'idn_sdk_ios', :git => 'https://gitlab.com/wavelabs/idn-sdk-ios.git'
s.dependency 'GRMustache.swift'






# 8
s.source_files = "WordPressModule/**/*.{swift}"

# 9
s.resources = "WordPressModule/**/*.{png,jpeg,jpg,storyboard,xib,plist}"
end
