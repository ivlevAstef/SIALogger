//
//  SIALogMessages.h
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#ifndef __SIA_LOG_MESSAGES_H__
#define __SIA_LOG_MESSAGES_H__

#define SIALogLevelMsg(LEVEL, MSG, ...) [SIALog log:SIALogLevels.LEVEL Line:@__LINE__ File:@__FILE__ Msg:[NSString stringWithFormat:MSG, ##__VA_ARGS__]]

#define SIALogFatal(MSG, ...) do { SIALogLevelMsg(Fatal   , MSG, ##__VA_ARGS__); abort(); } while (0)
#define SIALogError(MSG, ...)      SIALogLevelMsg(Error   , MSG, ##__VA_ARGS__)
#define SIALogWarning(MSG, ...)    SIALogLevelMsg(Warning , MSG, ##__VA_ARGS__)
#define SIALogInfo(MSG, ...)       SIALogLevelMsg(Info    , MSG, ##__VA_ARGS__)
#define SIALogTrace(MSG, ...)      SIALogLevelMsg(Trace   , MSG, ##__VA_ARGS__)

#endif /* __SIA_LOG_MESSAGES_H__ */
