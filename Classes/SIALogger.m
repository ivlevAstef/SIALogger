//
//  SIALogger.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALogger.h"
#import "SIAConsoleOutput.h"

@interface SIALogger ()

@property (nonatomic, strong) NSObject* monitor;
@property (nonatomic, strong) NSArray<id<SIAILoggerOutput>>* outputArray;

@property (atomic, copy) SIALoggerFormatFunction currentFormatFunction;

@end

SIALoggerFormatFunction defaultFormatFunction() {
  return ^NSString*(NSString* const level, NSString* const file, const SIALineNumber line, NSString* const msg) {
    return [NSString stringWithFormat:@"%@ {%@:%lld}: %@", level, file, line, msg];
  };
}

@implementation SIALogger

+ (instancetype)sharedInstance {
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
    self.monitor = [[NSObject alloc] init];
    
    self.maxLogLevel = SIA_MAX_LOG_LEVEL;
    self.outputArray = @[ [[SIAConsoleOutput alloc] init] ];
    
    self.currentFormatFunction = defaultFormatFunction();
  }

  return self;
}

- (void)setOutputArray:(NSArray<id<SIAILoggerOutput>>*)outputArray {
  SIARequiresType(outputArray, NSArray);
  for (id<SIAILoggerOutput> output in outputArray) {
    SIARequiresProtocol(output, SIAILoggerOutput);
  }
  
  @synchronized(self.monitor) {
    _outputArray = outputArray;
  }
}

- (void)setFormatFunction:(SIALoggerFormatFunction)formatFunction {
  if (nil == formatFunction) {
    self.currentFormatFunction = defaultFormatFunction();
  } else {
    self.currentFormatFunction = formatFunction;
  }
}

- (void)log:(const SIALogLevel)level Line:(const SIALineNumber)line File:(NSString* const)file Msg:(NSString* const)msg {
  SIARequiresArrayInterval(0, level, SIALogLevel_End);
  SIARequiresType(file, NSString);
  SIARequiresType(msg, NSString);
  
  if (self.maxLogLevel <= level) {
    return;
  }
  
  static NSString* const logLevelsString[] = {
    @"Fatal",
    @"Error",
    @"Warning",
    @"Info",
    @"Trace",
  };

  [self executeLog:self.currentFormatFunction(logLevelsString[level], [file lastPathComponent], line, msg)];
}

- (void)executeLog:(NSString*)log {
  @synchronized(self.monitor) {
    for (id<SIAILoggerOutput> output in self.outputArray) {
      [output log:log];
    }
  }
}

@end