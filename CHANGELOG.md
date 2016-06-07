### v1.1.2 (Only Objective-C)
* Supported auto including preprocessor macros: `__SIA_LOG_COLORFUL__`.

### v1.1.1
* Fixed pod spec bug for Objective-C library. (No include SIALogger.h)

### v1.1.0
* Added self log format, and removed old. For example: "%t [%L] {%f:%l}: %m". See more into documentation.
* Added global date format. Use `NSDateFormatter`.
* Supported XcodeColors plugins for enable colour.
* Changed `SIALogOutputProtocol` declaration log method to: `log(SIALogMessage)`, for a place: `log(String)`.
* Removed `SIALogRet{Level}If(...)`. Now `SIALog{Level}If(...)` return boolean value both Swift version.

### v1.0.0
* Initial version
