//
//  SIALog.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogLevels.h"
#import "SIALogConfig.h"

@interface SIALog : NSObject

+ (void)log:(const SIALogLevel)level Line:(const SIALineNumber)line File:(NSString* const)file Msg:(NSString* const)msg;
+ (BOOL)logIf:(const BOOL)condition Level:(const SIALogLevel)level Line:(const SIALineNumber)line File:(NSString* const)file Msg:(NSString* const)msg;

@end