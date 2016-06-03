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

- (void)logWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Msg:(NSString*)msg {
  assert(nil != time && nil != level && nil != file && nil != line && nil != msg);
  
  CLSLog(@"%@ [%@] {%@:%@}: %@", time, level.name.uppercaseString, file, line, msg);
}

@end

#endif