//
//  SIALogConfig.h
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogLevels.h"
#import "SIALogOutputProtocol.h"

typedef unsigned long long int SIALineNumber;
typedef NSString* (^SIALogFormatFunction)(NSString* const level, NSString* const file, const SIALineNumber line, NSString* const msg);

@interface SIALogConfig : NSObject

+ (instancetype)sharedInstance;

@property (atomic, assign) SIALogLevel maxLogLevel;
@property (atomic, copy) NSArray<id<SIALogOutputProtocol>>* outputs;
@property (atomic, copy) SIALogFormatFunction formatFunction;

@property (nonatomic, readonly) SIALogFormatFunction defaultFormatFunction;

@end
