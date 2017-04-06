# Wavelabs IDS Sdk


## Requirements

- iOS 9.0+
- Xcode 8.3


## Installation


### CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:


```bash
$ gem install cocoapods
```

create the Podfile by uisng following commands 

```bash
$ cd <path-to-project/>
$ pod init
$ open -a Xcode Podfile

```


To integrate this library into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

pod ' idn-sdk-ios', '~> 0.7.5'
```

  
  and using terminal, run the following command:

```bash
$ pod install
```

## Usage

### Add Url and ClientId
  
   Add Baseurl and clientId in Targets/info as WavelabsAPISettings
