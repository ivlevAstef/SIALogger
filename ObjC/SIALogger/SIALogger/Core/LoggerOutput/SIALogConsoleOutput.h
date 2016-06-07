//
//  SIALogConsoleOutput.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogOutputProtocol.h"

@interface SIALogConsoleOutput : NSObject <SIALogOutputProtocol>

- (instancetype)init;
- (instancetype)initWithFormat:(NSString*)format;

@end
