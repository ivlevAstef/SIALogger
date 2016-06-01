//
//  SIALogLevels.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#ifndef __SIA_LOG_LEVELS_H__
#define __SIA_LOG_LEVELS_H__

#define SIALog(LEVEL, MSG, ...) [[SIALogger sharedInstance] log:(LEVEL) Line:__LINE__ File:@__FILE__ Msg:[NSString stringWithFormat:MSG, ##__VA_ARGS__]]

#define SIALogFatal(MSG, ...) do { SIALog(SIALogLevel_Fatal   , MSG, ##__VA_ARGS__); abort(); } while (0)
#define SIALogError(MSG, ...)      SIALog(SIALogLevel_Error   , MSG, ##__VA_ARGS__)
#define SIALogWarning(MSG, ...)    SIALog(SIALogLevel_Warning , MSG, ##__VA_ARGS__)
#define SIALogInfo(MSG, ...)       SIALog(SIALogLevel_Info    , MSG, ##__VA_ARGS__)
#define SIALogTrace(MSG, ...)      SIALog(SIALogLevel_Trace   , MSG, ##__VA_ARGS__)

#endif /* __SIA_LOG_LEVELS_H__ */
