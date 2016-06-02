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
#ifdef DEBUG
    self.maxLogLevel = SIALogLevels.Info;
#else
    self.maxLogLevel = SIALogLevels.Warning;
#endif
    
    self.outputs = @[ [[SIALogConsoleOutput alloc] init] ];
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
    return [NSString stringWithFormat:@"%@ {%@:%lld}: %@", level.name, file, line, msg];
  };
}


@end

