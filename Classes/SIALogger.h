//
//  SIALogger.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIAILoggerOutput.h"

typedef NS_ENUM(NSUInteger, SIALogLevel) {
  SIALogLevel_Fatal,
  SIALogLevel_Error,
  SIALogLevel_Warning,
  SIALogLevel_Info,
  SIALogLevel_Trace,
  SIALogLevel_End
};

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