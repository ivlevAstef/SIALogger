//
//  SIALogLevels.h
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogLevel.h"

@interface SIALogLevels : NSObject

+ (SIALogLevel*)Fatal;
+ (SIALogLevel*)Error;
+ (SIALogLevel*)Warning;
+ (SIALogLevel*)Info;
+ (SIALogLevel*)Trace;

@end
