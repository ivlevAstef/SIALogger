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
@property (atomic, copy) SIALogFormatFunction formatFunction;

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
    self.formatFunction = [SIALogConfig defaultFormatFunction];
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

//Format Function

+ (SIALogFormatFunction)formatFunction {
  return [self sharedInstance].formatFunction;
}

+ (void)setFormatFunction:(SIALogFormatFunction)newFormatFunction {
  if (nil == newFormatFunction) {
    newFormatFunction = [self defaultFormatFunction];
  }
  [self sharedInstance].formatFunction = newFormatFunction;
}

+ (SIALogFormatFunction)defaultFormatFunction {
  return ^NSString*(SIALogLevel* const level, NSString* const file, const SIALineNumber line, NSString* const msg) {
    return [NSString stringWithFormat:@"[%@] {%@:%lld}: %@", level.name.uppercaseString, file, line, msg];
  };
}

@end

