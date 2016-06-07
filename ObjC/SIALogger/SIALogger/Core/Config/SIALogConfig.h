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

@interface SIALogConfig : NSObject

+ (SIALogLevel*)maxLogLevel;
+ (void)setMaxLogLevel:(SIALogLevel*)newMaxLogLevel;

+ (NSArray<id<SIALogOutputProtocol>>*)outputs;
+ (void)setOutputs:(NSArray<id<SIALogOutputProtocol>>*)newOutputs;

+ (NSString*)formatTime;
+ (void)setFormatTime:(NSString*)formatTime;

@end
