//
//  SIALog.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALog.h"

@implementation SIALog

+ (void)log:(const SIALogLevel)level Line:(const SIALineNumber)line File:(NSString* const)file Msg:(NSString* const)msg {
#define SIA_LOG_LEVEL_COUNTER(NAME) 1 +
  static size_t const logLevelsCount = SIA_LOG_LEVELS(SIA_LOG_LEVEL_COUNTER) 0;
#undef SIA_LOG_LEVEL_COUNTER
  
  if (logLevelsCount <= level || [SIALogConfig sharedInstance].maxLogLevel < level) {
    return;
  }
  
#define SIA_LOG_LEVEL_STRING(NAME) @#NAME,
  static NSString* const logLevelsString[logLevelsCount] = {
    SIA_LOG_LEVELS(SIA_LOG_LEVEL_STRING)
  };
#undef SIA_LOG_LEVEL_STRING  

  [self executeLog:[SIALogConfig sharedInstance].formatFunction(logLevelsString[level], [file lastPathComponent], line, msg)];
}

+ (void)executeLog:(NSString*)log {
  static NSObject* monitor = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    monitor = [NSObject new];
  });
  
  @synchronized (monitor) {
    for (id<SIALoggerOutputProtocol> output in [SIALogConfig sharedInstance].outputArray) {
      [output log:log];
    }
  }
}

@end