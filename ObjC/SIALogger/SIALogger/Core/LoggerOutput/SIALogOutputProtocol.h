//
//  SIALogOutputProtocol.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALogLevel.h"
#import "SIALogMessage.h"

@protocol SIALogOutputProtocol <NSObject>

- (void)log:(SIALogMessage*)msg;

@end
