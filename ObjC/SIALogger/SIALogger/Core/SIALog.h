//
//  SIALog.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogLevel.h"
#import "SIALogConfig.h"

@interface SIALog : NSObject

+ (void)log:(SIALogLevel*)level Line:(NSNumber*)line File:(NSString*)file Msg:(NSString*)msg;
+ (BOOL)logIf:(BOOL)condition Level:(SIALogLevel*)level Line:(NSNumber*)line File:(NSString*)file Msg:(NSString*)msg;

@end