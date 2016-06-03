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
#define SIALogAssertMsg(CONDITION, MSG, ...)\
  if (!(CONDITION)) {                       \
    SIALogLevelMsg(Fatal, MSG, ##__VA_ARGS__); \
    NSAssert(false, MSG);                   \
  }

#define SIALogAssert(CONDITION) SIALogAssertMsg(CONDITION, @"Activation assert: " @#CONDITION)

//Not Implemented
#define SIANotImplemented() do { SIALogLevelMsg(Fatal, [NSString stringWithFormat:@"Not Implemented:%s", __PRETTY_FUNCTION__]); NSAssert(false, MSG); } while(0)

//LogCheck
#define SIALogCheck(CONDITION)                     \
  if (CONDITION) {                                 \
    SIALogFatal(@"Check " @#CONDITION @" failed"); \
  }

//LogIf
#define SIALogIf(CONDITION, LEVEL, MSG, ...) [SIALog logIf:CONDITION Level:SIALogLevels.LEVEL Line:@__LINE__ File:@__FILE__ Msg:[NSString stringWithFormat:MSG, ##__VA_ARGS__]]

#define SIALogFatalIf(CONDITION, MSG, ...)   do { if (SIALogIf(CONDITION, Fatal, MSG, ##__VA_ARGS__)) { abort(); } } while (0)
#define SIALogErrorIf(CONDITION, MSG, ...)   SIALogIf(CONDITION, Error  , MSG, ##__VA_ARGS__)
#define SIALogWarningIf(CONDITION, MSG, ...) SIALogIf(CONDITION, Warning, MSG, ##__VA_ARGS__)
#define SIALogInfoIf(CONDITION, MSG, ...)    SIALogIf(CONDITION, Info   , MSG, ##__VA_ARGS__)
#define SIALogTraceIf(CONDITION, MSG, ...)   SIALogIf(CONDITION, Trace  , MSG, ##__VA_ARGS__)

#endif /* __SIA_LOG_CHECKS_H__ */

