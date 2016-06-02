//
//  SIALog.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALog.h"
#import "SIALogLevels.h"

@implementation SIALog

+ (void)log:(SIALogLevel* const)level Line:(const SIALineNumber)line File:(NSString* const)file Msg:(NSString* const)msg {
  if (nil == level || nil == file || nil == msg) {
    return;
  }
  
  if (SIALogConfig.maxLogLevel.priority < level.priority) {
    return;
  }
  
  NSString* message = SIALogConfig.formatFunction(level, [file lastPathComponent], line, msg);
  if (nil == message) {
    return;
  }
  
  @synchronized (self.monitor) {
    for (id<SIALogOutputProtocol> output in SIALogConfig.outputs) {
      if ([output respondsToSelector:@selector(logLevel:AndMessage:)]) {
        [output logLevel:level AndMessage:message];
      }
    }
  }
}

+ (BOOL)logIf:(const BOOL)condition Level:(SIALogLevel* const)level Line:(const SIALineNumber)line File:(NSString* const)file Msg:(NSString* const)msg {
  if (condition) {
    [self log:level Line:line File:file Msg:msg];
  }
  return condition;
}

+ (void)event:(NSString*)name WithData:(NSDictionary*)eventData {
  if (nil == name) {
    return;
  }
  
  @synchronized (self.monitor) {
    for (id<SIALogOutputProtocol> output in SIALogConfig.outputs) {
      if ([output respondsToSelector:@selector(event:WithData:)]) {
        [output event:name WithData:eventData];
      }
    }
  }
}

+ (NSObject*)monitor {
  static NSObject* monitor = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    monitor = [NSObject new];
  });
  
  return monitor;
}

@end