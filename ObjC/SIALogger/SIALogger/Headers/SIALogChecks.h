//
//  SIALogChecks.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#ifndef __SIA_LOG_CHECKS_H__
#define __SIA_LOG_CHECKS_H__

//LogAssert
#define SIALogAssertMsg(CONDITION, MSG, ...)       \
  if (!(CONDITION)) {                              \
    SIALog(SIALogLevel_Fatal, MSG, ##__VA_ARGS__); \
    NSAssert(false, MSG);                          \
  }

#define SIALogAssert(CONDITION) SIALogAssertMsg(CONDITION, @"Activation assert: " @#CONDITION)

//Not Implemented
#define SIANotImplemented() do { SIALog(SIALogLevel_Fatal, [NSString stringWithFormat:@"Not Implemented:%s", __PRETTY_FUNCTION__]); NSAssert(false, MSG); } while(0)

//LogCheck
#define SIALogCheck(CONDITION)                     \
  if (CONDITION) {                                 \
    SIALogFatal(@"Check " @#CONDITION @" failed"); \
  }

//LogIf
#define SIALogIf(CONDITION, SEVERITY, MSG, ...) \
  if (CONDITION) {                              \
    SIALog##SEVERITY(MSG, ##__VA_ARGS__);       \
  }

#define SIALogIfFatal(CONDITION, MSG, ...)   SIALogIf(CONDITION, Fatal  , MSG, ##__VA_ARGS__)
#define SIALogIfError(CONDITION, MSG, ...)   SIALogIf(CONDITION, Error  , MSG, ##__VA_ARGS__)
#define SIALogIfWarning(CONDITION, MSG, ...) SIALogIf(CONDITION, Warning, MSG, ##__VA_ARGS__)
#define SIALogIfInfo(CONDITION, MSG, ...)    SIALogIf(CONDITION, Info   , MSG, ##__VA_ARGS__)
#define SIALogIfTrace(CONDITION, MSG, ...)   SIALogIf(CONDITION, Trace  , MSG, ##__VA_ARGS__)

//LogIfRet
#define SIALogRetIf(CONDITION, SEVERITY, RET_VALUE, MSG, ...) \
  if (CONDITION) {                                            \
    SIALog##SEVERITY(MSG, ##__VA_ARGS__);                     \
    return RET_VALUE;                                         \
  }

#define SIALogRetIfError(CONDITION, RET_VALUE, MSG, ...)   SIALogRetIf(CONDITION, Error  , RET_VALUE, MSG, ##__VA_ARGS__)
#define SIALogRetIfWarning(CONDITION, RET_VALUE, MSG, ...) SIALogRetIf(CONDITION, Warning, RET_VALUE, MSG, ##__VA_ARGS__)
#define SIALogRetIfInfo(CONDITION, RET_VALUE, MSG, ...)    SIALogRetIf(CONDITION, Info   , RET_VALUE, MSG, ##__VA_ARGS__)
#define SIALogRetIfTrace(CONDITION, RET_VALUE, MSG, ...)   SIALogRetIf(CONDITION, Trace  , RET_VALUE, MSG, ##__VA_ARGS__)

#endif /* __SIA_LOG_CHECKS_H__ */

