//
//  SIADocumentsFileOutput.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIAILoggerOutput.h"

@interface SIADocumentsFileOutput : NSObject <SIAILoggerOutput>

- (id)init __attribute__((unavailable("Used initWithFileName:joinDate: instead.")));
- (instancetype)initWithFileName:(NSString*)fileName joinDate:(BOOL)join;

@end
