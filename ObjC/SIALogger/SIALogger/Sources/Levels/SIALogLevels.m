//
//  SIALogLevels.m
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogLevels.h"

@implementation SIALogLevels

#define CREATE_LEVEL(PRIORITY, NAME, SHORT_NAME) \
  static SIALogLevel* level = nil; \
  static dispatch_once_t onceToken; \
  dispatch_once(&onceToken, ^{ \
    level = [[SIALogLevel alloc] initWithPriority:PRIORITY Name:NAME ShortName:SHORT_NAME]; \
  })

+ (SIALogLevel*)Fatal {
  CREATE_LEVEL(0, @"Fatal", @"FTL");
  return level;
}

+ (SIALogLevel*)Error {
  CREATE_LEVEL(1, @"Error", @"ERR");
  return level;
}

+ (SIALogLevel*)Warning {
  CREATE_LEVEL(2, @"Warning", @"WRN");
  return level;
}

+ (SIALogLevel*)Info {
  CREATE_LEVEL(3, @"Info", @"INF");
  return level;
}

+ (SIALogLevel*)Trace {
  CREATE_LEVEL(4, @"Trace", @"TRC");
  return level;
}

@end
