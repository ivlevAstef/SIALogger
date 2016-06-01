//
//  SIALogMessages.h
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#ifndef __SIA_LOG_MESSAGES_H__
#define __SIA_LOG_MESSAGES_H__

#define SIALogMsg(LEVEL, MSG, ...) [SIALog log:LEVEL Line:__LINE__ File:@__FILE__ Msg:[NSString stringWithFormat:MSG, ##__VA_ARGS__]]

#define SIALogFatal(MSG, ...) do { SIALogMsg(SIALogLevel_Fatal   , MSG, ##__VA_ARGS__); abort(); } while (0)
#define SIALogError(MSG, ...)      SIALogMsg(SIALogLevel_Error   , MSG, ##__VA_ARGS__)
#define SIALogWarning(MSG, ...)    SIALogMsg(SIALogLevel_Warning , MSG, ##__VA_ARGS__)
#define SIALogInfo(MSG, ...)       SIALogMsg(SIALogLevel_Info    , MSG, ##__VA_ARGS__)
#define SIALogTrace(MSG, ...)      SIALogMsg(SIALogLevel_Trace   , MSG, ##__VA_ARGS__)

#endif /* __SIA_LOG_MESSAGES_H__ */
