//
//  SIALogConfig.m
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogConfig.h"
#import "SIALogLevels.m"
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
#ifdef DEBUG
    self.maxLogLevel = SIALogLevels.Info;
#else
    self.maxLogLevel = SIALogLevels.Warning;
#endif
    
    self.outputs = @[ [[SIALogConsoleOutput alloc] init] ];
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
#ifdef DEBUG
    newMaxLogLevel = SIALogLevels.Info;
#else
    newMaxLogLevel = SIALogLevels.Warning;
#endif
  }
  [self sharedInstance].maxLogLevel = newMaxLogLevel;
}

//Outputs

+ (NSArray<id<SIALogOutputProtocol>>*)outputs {
  return [self sharedInstance].outputs;
}

+ (void)setOutputs:(NSArray<id<SIALogOutputProtocol>>*)newOutputs {
  if (nil == newOutputs) {
    newOutputs = [NSArray array];
  }
  [self sharedInstance].outputs = newOutputs;
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

