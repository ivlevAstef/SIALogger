//
//  SIALogCrashlyticsOuput.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALogCrashlyticsOuput.h"
#import <Crashlytics/Crashlytics.h>

@implementation SIALogCrashlyticsOuput

- (void)log:(SIALogMessage*)msg {
  CLSLog(@"%@ [%@] {%@:%@}: %@", msg.time, msg.level.name.uppercaseString, msg.file, msg.line, msg.text);
}

@end