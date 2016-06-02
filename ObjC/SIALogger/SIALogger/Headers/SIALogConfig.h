//
//  SIALogConfig.h
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogLevel.h"
#import "SIALogOutputProtocol.h"

typedef unsigned long long int SIALineNumber;
typedef NSString* (^SIALogFormatFunction)(SIALogLevel* level, NSString* file, SIALineNumber line, NSString* msg);

@interface SIALogConfig : NSObject

+ (SIALogLevel*)maxLogLevel;
+ (void)setMaxLogLevel:(SIALogLevel*)newMaxLogLevel;

+ (NSArray<id<SIALogOutputProtocol>>*)outputs;
+ (void)setOutputs:(NSArray<id<SIALogOutputProtocol>>*)newOutputs;

+ (SIALogFormatFunction)formatFunction;
+ (void)setFormatFunction:(SIALogFormatFunction)newFormatFunction;

@end
