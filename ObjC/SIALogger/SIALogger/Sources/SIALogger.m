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
@property (nonatomic, strong) NSArray<id<SIALoggerOutputProtocol>>* outputArray;

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

- (void)setOutputArray:(NSArray<id<SIALoggerOutputProtocol>>*)outputArray {
  SIARequiresType(outputArray, NSArray);
  for (id<SIALoggerOutputProtocol> output in outputArray) {
    SIARequiresProtocol(output, SIALoggerOutputProtocol);
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
#define SIA_LOG_LEVEL_COUNTER(NAME) 1 +
  static size_t const logLevelsCount = SIA_LOG_LEVELS(SIA_LOG_LEVEL_COUNTER) 0;
#undef SIA_LOG_LEVEL_COUNTER
  
  SIARequiresArrayInterval(0, level, logLevelsCount);
  SIARequiresType(file, NSString);
  SIARequiresType(msg, NSString);
  
  if (self.maxLogLevel <= level) {
    return;
  }
  
#define SIA_LOG_LEVEL_STRING(NAME) @#NAME,
  static NSString* const logLevelsString[logLevelsCount] = {
    SIA_LOG_LEVELS(SIA_LOG_LEVEL_STRING)
  };
#undef SIA_LOG_LEVEL_STRING  

  [self executeLog:self.currentFormatFunction(logLevelsString[level], [file lastPathComponent], line, msg)];
}

- (void)executeLog:(NSString*)log {
  @synchronized(self.monitor) {
    for (id<SIALoggerOutputProtocol> output in self.outputArray) {
      [output log:log];
    }
  }
}

@end