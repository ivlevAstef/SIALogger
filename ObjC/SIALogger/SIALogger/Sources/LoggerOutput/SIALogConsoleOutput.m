//
//  SIALogConsoleOutput.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALogConsoleOutput.h"

@implementation SIALogConsoleOutput

- (void)logWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Msg:(NSString*)msg {
  assert(nil != time && nil != level && nil != file && nil != line && nil != msg);
  
  //for faster
  printf("%s [%s] {%s:%lld} %s\r\n", [time UTF8String], [level.name.uppercaseString UTF8String], [file UTF8String], [line unsignedLongLongValue], [msg UTF8String]);
}

@end
