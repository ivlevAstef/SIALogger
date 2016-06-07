//
//  SIALog.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALog.h"
#import "SIALogMessage.h"

@implementation SIALog

+ (void)log:(SIALogLevel* const)level Line:(NSNumber* const)line File:(NSString* const)filePath Msg:(NSString* const)msg {
  assert(nil != level && nil != filePath && nil != line && nil != msg);
  
  if (SIALogConfig.maxLogLevel.priority < level.priority) {
    return;
  }
  
  NSString* file = [filePath lastPathComponent];
  
  @synchronized (self.monitor) {
    NSString* time = [self currentTime];
    SIALogMessage* message = [[SIALogMessage alloc] initWithTime:time Level:level File:file Line:line Text:msg];
    
    for (id<SIALogOutputProtocol> output in SIALogConfig.outputs) {
      [output log:message];
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