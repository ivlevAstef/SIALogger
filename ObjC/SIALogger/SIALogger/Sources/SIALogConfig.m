//
//  SIALogConfig.m
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogConfig.h"
#import "SIAConsoleOutput.h"

@implementation SIALogConfig

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
#ifdef DEBUG
    self.maxLogLevel = SIALogLevel_Info;
#else
    self.maxLogLevel = SIALogLevel_Warning;
#endif
    
    self.outputArray = @[ [[SIAConsoleOutput alloc] init] ];
    self.formatFunction = self.defaultFormatFunction;
  }
  
  return self;
}

- (SIALoggerFormatFunction)defaultFormatFunction {
  return ^NSString*(NSString* const level, NSString* const file, const SIALineNumber line, NSString* const msg) {
    return [NSString stringWithFormat:@"%@ {%@:%lld}: %@", level, file, line, msg];
  };
}


@end

