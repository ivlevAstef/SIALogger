//
//  SIALogMessages.h
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#ifndef __SIA_LOG_MESSAGES_H__
#define __SIA_LOG_MESSAGES_H__

#define SIALogLevel(LEVEL, MSG, ...) [SIALog log:SIALogLevels.LEVEL Line:__LINE__ File:@__FILE__ Msg:[NSString stringWithFormat:MSG, ##__VA_ARGS__]]

#define SIALogFatal(MSG, ...) do { SIALogLevel(Fatal   , MSG, ##__VA_ARGS__); abort(); } while (0)
#define SIALogError(MSG, ...)      SIALogLevel(Error   , MSG, ##__VA_ARGS__)
#define SIALogWarning(MSG, ...)    SIALogLevel(Warning , MSG, ##__VA_ARGS__)
#define SIALogInfo(MSG, ...)       SIALogLevel(Info    , MSG, ##__VA_ARGS__)
#define SIALogTrace(MSG, ...)      SIALogLevel(Trace   , MSG, ##__VA_ARGS__)

#endif /* __SIA_LOG_MESSAGES_H__ */
