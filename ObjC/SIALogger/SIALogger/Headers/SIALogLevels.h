//
//  SIALogLevels.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#ifndef __SIA_LOG_LEVELS_H__
#define __SIA_LOG_LEVELS_H__

#define SIA_LOG_LEVELS(X) \
  X(Fatal) \
  X(Error) \
  X(Warning) \
  X(Info) \
  X(Trace)

#define SIA_LOG_LEVEL_ENUM(NAME) SIALogLevel_##NAME,
typedef NS_ENUM(NSUInteger, SIALogLevel) {
  SIA_LOG_LEVELS(SIA_LOG_LEVEL_ENUM)
};
#undef SIA_LOG_LEVEL_ENUM

#endif /* __SIA_LOG_LEVELS_H__ */
