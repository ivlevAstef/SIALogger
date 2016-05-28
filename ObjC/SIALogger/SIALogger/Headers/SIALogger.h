//
//  SIALogger.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIAILoggerOutput.h"

#define SIA_LOG_LEVELS(X) \
  X(Fatal) \
  X(Error) \
  X(Warning) \
  X(Info) \
  X(Trace) \

#define SIA_LOG_LEVEL_ENUM(NAME) SIALogLevel_##NAME,
typedef NS_ENUM(NSUInteger, SIALogLevel) {
  SIA_LOG_LEVELS(SIA_LOG_LEVEL_ENUM)
};
#undef SIA_LOG_LEVEL_ENUM

typedef unsigned long long int SIALineNumber;
typedef NSString* (^SIALoggerFormatFunction)(NSString* const level, NSString* const file, const SIALineNumber line, NSString* const msg);

@interface SIALogger : NSObject

+ (instancetype)sharedInstance;

- (void)log:(const SIALogLevel)level Line:(const SIALineNumber)line File:(NSString* const)file Msg:(NSString* const)msg;

@property (atomic, assign) SIALogLevel maxLogLevel;

- (void)setOutputArray:(NSArray<id<SIAILoggerOutput>>*)outputArray;
- (void)setFormatFunction:(SIALoggerFormatFunction)formatFunction;

@end

#include "SIALogLevels.h"
#include "SIALogChecks.h"
#include "SIALogContracts.h"