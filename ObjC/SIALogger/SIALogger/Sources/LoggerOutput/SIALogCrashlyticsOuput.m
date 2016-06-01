//
//  SIALogCrashlyticsOuput.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#ifdef SIA_LOGGER_CRASHLYTICS

#import "SIALogCrashlyticsOuput.h"
#import <Crashlytics/Crashlytics.h>

@implementation SIALogCrashlyticsOuput

- (void)log:(NSString*)logString {
  if (nil != logString) {
    CLSLog(@"%@", logString);
  }
}

@end

#endif