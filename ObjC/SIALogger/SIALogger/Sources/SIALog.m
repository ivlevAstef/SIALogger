//
//  SIALog.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALog.h"

@implementation SIALog

+ (void)log:(SIALogLevel* const)level Line:(NSNumber* const)line File:(NSString* const)filePath Msg:(NSString* const)msg {
  assert(nil != level && nil != filePath && nil != line && nil != msg);
  
  assert(nil != SIALogConfig.maxLogLevel);
  if (SIALogConfig.maxLogLevel.priority < level.priority) {
    return;
  }
  
  NSString* file = [filePath lastPathComponent];
  assert(nil != filePath);
  
  @synchronized (self.monitor) {
    NSString* time = [self currentTime];
    assert(nil != time);
    
    assert(nil != SIALogConfig.outputs);
    for (id<SIALogOutputProtocol> output in SIALogConfig.outputs) {
      [output logWithTime:time Level:level File:file Line:line Msg:msg];
    }
  }
}

+ (NSString*)currentTime {
  static dispatch_once_t once;
  static NSDateFormatter* dateFormatter = nil;
  
  dispatch_once(&once, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
  });
  
  [dateFormatter setDateFormat:SIALogConfig.formatTime];
  return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSObject*)monitor {
  static NSObject* monitor = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    monitor = [NSObject new];
  });
  
  return monitor;
}

+ (BOOL)logIf:(const BOOL)condition Level:(SIALogLevel* const)level Line:(NSNumber* const)line File:(NSString* const)file Msg:(NSString* const)msg {
  if (condition) {
    [self log:level Line:line File:file Msg:msg];
  }
  return condition;
}

@end