# SIALogger
library for simplify log and assertion

## Features

1. Five log levels:
  * Fatal
  * Error
  * Warning
  * Info
  * Trace
2. Assertion logs - in debug mode abort program, but in release mode only write message.
3. Log by condition (LogIf)
4. Configuration
5. Extensibility
6. Self log format (beginning with v1.1.0)
7. Colorful (beginning with v1.1.0)

## Install
Via CocoaPods.

### Core
`pod 'SIALogger'` Objective-C  
`pod 'SIALoggerSwift'` Swift (iOS8+) also need write in your PodFile `use_frameworks!`

### Colorful (beginning with v1.1.0)
`pod 'SIALogger/Colorful'` Objective-C  
`pod 'SIALoggerSwift/Colorful'` Swift

## Documentation
### v1.1.0
Objective-C documentation can be found at [SIALogger Objective-C](https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Objective-C_v110)  
Swift documentation can be found at [SIALogger Swift](https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Swift_v110)

### v1.0.0
Objective-C documentation can be found at [SIALogger Objective-C](https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Objective-C)  
Swift documentation can be found at [SIALogger Swift](https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Swift)

## Third Party Tools That Work With XCGLogger
* [XcodeColors](https://github.com/robbiehanson/XcodeColors): Enable colour in the Xcode console 
* [KZLinkedConsole](https://github.com/krzysztofzablocki/KZLinkedConsole): Link from a log line directly to the code that produced it 

# Changelog
## v1.1.0 -> v1.1.1
* Fixed pod spec bug for Objective-C library. (No include SIALogger.h)
## v1.0.0 -> v1.1.0
* Added self log format, and removed old. For example: "%t [%L] {%f:%l}: %m". See more into documentation.
* Added global date format. Use `NSDateFormatter`.
* Supported XcodeColors plugins for enable colour.
* Changed `SIALogOutputProtocol` declaration log method to: `log(SIALogMessage)`, for a place: `log(String)`.
* Removed `SIALogRet{Level}If(...)`. Now `SIALog{Level}If(...)` return boolean value both Swift version.
