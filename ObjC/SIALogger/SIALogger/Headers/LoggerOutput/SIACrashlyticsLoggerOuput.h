//
//  SIACrashlyticsLoggerOuput.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#ifdef SIA_LOGGER_CRASHLYTICS

#import <Foundation/Foundation.h>
#import "SIALoggerOutputProtocol.h"

@interface SIACrashlyticsLoggerOuput : NSObject <SIALoggerOutputProtocol>

@end

#endif
