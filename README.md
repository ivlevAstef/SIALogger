# SIALogger
library for simplify log and assertion

# Features

1. Five log levels:
  * Fatal
  * Error
  * Warning
  * Info
  * Trace
2. Fatal log level abort a program.
3. Assertion logs - in debug mode abort program, but in release mode only write message.
4. Log by condition (LogIf) and log with return by condition (LogRetIf)
5. Contracts requires (assertions by specific conditional)
6. Not Implemented log
7. Settings

# Using
## Settings
For changes settings get 'SIALogger' class instance use method 'sharedInstance'.
List settings:
* Max log level - Writing only if log level less the variable.
* Outputs - Classes implementation protocol 'SIAILoggerOutput' for show log messages. For example: Console, File, Crashlytics.
* Format functions - Method for generating string by level, file, line, msg.

## Logs
For log use Macros SIALog{LEVEL}(MSG, ...). For example: SIALogTrace(@"Trace message with value:%@", value);
If you needs log by condition use Macros SIALogIf{LEVEL}(CONDITION, MSG, ...). For example: SIALogIfWarning(nil == model, @"Model is nil");
If you needs log by condition and return from function use Macros SIALogRetIf{LEVEL}(CONDITION, RET_VALUE, MSG, ...). For example: SIALogRetIfInfo(nil == model, nil, @"Model is nil");

##Assertion
Assertion abort program only debug mode, but always logs.
For assert use Macros SIALogAssertMsg(CONDITION, MSG, ...) or SIALogAssert(CONDITION). For example: SIALogAssert(nil != model);

## Contracts requires
It's not real contracts because these works only runtime. These contracts not support code analysis.
It's specifics assertion.
Macros List:
* SIARequires(CONDITION)
* SIARequiresNotNil(VALUE) For example. SIARequiresNotNil(model)
* SIARequiresType(VALUE, TYPE) For example. SIARequiresType(model, Model)
* SIARequiresProtocol(VALUE, PROTOCOL) For example. SIARequiresProtocol(model, ModelProtocol)
* SIARequiresSelector(VALUE, SELECTOR) For example. SIARequiresSelector(model, @selector(method))
* SIARequiresArrayInterval(BEGIN, VALUE, END) For example. SIARequiresArrayInterval(0, model.value, 100)

##Not implemented
It's specifics assert, with specific log.
Use macros SIANotImplemented()