//
//  SIALogConfig.h
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogLevels.h"
#import "SIALoggerOutputProtocol.h"

typedef unsigned long long int SIALineNumber;
typedef NSString* (^SIALoggerFormatFunction)(NSString* const level, NSString* const file, const SIALineNumber line, NSString* const msg);

@interface SIALogConfig : NSObject

+ (instancetype)sharedInstance;

@property (atomic, assign) SIALogLevel maxLogLevel;
@property (atomic, copy) NSArray<id<SIALoggerOutputProtocol>>* outputArray;
@property (atomic, copy) SIALoggerFormatFunction formatFunction;

@property (nonatomic, readonly) SIALoggerFormatFunction defaultFormatFunction;

@end
