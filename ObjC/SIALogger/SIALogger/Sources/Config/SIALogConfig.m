//
//  SIALogConfig.m
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogConfig.h"
#import "SIALogLevels.h"

#import "SIALogConsoleOutput.h"

@interface SIALogConfig()

@property (atomic, strong) SIALogLevel* maxLogLevel;
@property (atomic, copy) NSArray<id<SIALogOutputProtocol>>* outputs;
@property (atomic, copy) NSString* formatTime;

@end

@implementation SIALogConfig

+ (SIALogConfig*)sharedInstance {
  static dispatch_once_t once;
  static id sharedInstance = nil;
  
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (id)init {
  self = [super init];
  
  if (self) {
    self.maxLogLevel = [SIALogConfig defaultMaxLogLevel];
    self.outputs = [SIALogConfig defaultOutputs];
    self.formatTime = [SIALogConfig defaultFormatTime];
  }
  
  return self;
}

//Max Log Level

+ (SIALogLevel*)maxLogLevel {
  return [self sharedInstance].maxLogLevel;
}

+ (void)setMaxLogLevel:(SIALogLevel*)newMaxLogLevel {
  if (nil == newMaxLogLevel) {
    newMaxLogLevel = [self defaultMaxLogLevel];
  }
  [self sharedInstance].maxLogLevel = newMaxLogLevel;
}

+ (SIALogLevel*)defaultMaxLogLevel {
#ifdef DEBUG
  return SIALogLevels.Info;
#else
  return SIALogLevels.Warning;
#endif
}

//Outputs

+ (NSArray<id<SIALogOutputProtocol>>*)outputs {
  return [self sharedInstance].outputs;
}

+ (void)setOutputs:(NSArray<id<SIALogOutputProtocol>>*)newOutputs {
  if (nil == newOutputs) {
    newOutputs = [self defaultOutputs];
  }
  [self sharedInstance].outputs = newOutputs;
}

+ (NSArray<id<SIALogOutputProtocol>>*)defaultOutputs {
  return @[ [[SIALogConsoleOutput alloc] init] ];
}

//Format Time

+ (NSString*)formatTime {
  return [self sharedInstance].formatTime;
}
+ (void)setFormatTime:(NSString*)formatTime {
  if (nil == formatTime) {
    formatTime = [self defaultFormatTime];
  }
  [self sharedInstance].formatTime = formatTime;
}

+ (NSString*)defaultFormatTime {
  return @"HH:mm:ss:SSS";
}

@end

