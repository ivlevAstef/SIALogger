//
//  SIALogLevels.m
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogLevels.h"

@implementation SIALogLevels

#define CREATE_LEVEL(PRIORITY, NAME) \
  static SIALogLevel* level = nil; \
  static dispatch_once_t onceToken; \
  dispatch_once(&onceToken, ^{ \
    level = [[SIALogLevel alloc] initWithPriority:PRIORITY AndName:NAME]; \
  }); \
  \
  return level

+ (SIALogLevel*)Fatal {
  CREATE_LEVEL(0, @"Fatal");
}

+ (SIALogLevel*)Error {
  CREATE_LEVEL(1, @"Error");
}

+ (SIALogLevel*)Warning {
  CREATE_LEVEL(2, @"Warning");
}

+ (SIALogLevel*)Info {
  CREATE_LEVEL(3, @"Info");
}

+ (SIALogLevel*)Trace {
  CREATE_LEVEL(4, @"Trace");
}

@end
