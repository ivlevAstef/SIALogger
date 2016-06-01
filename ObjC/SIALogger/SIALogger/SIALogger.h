//
//  SIALogger.h
//  SIALogger
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#ifndef __SIA_LOG_LOGGER_H__
#define __SIA_LOG_LOGGER_H__

#import <Foundation/Foundation.h>

#import "SIALogLevels.h"
#import "SIALog.h"
#import "SIALogConfig.h"

#import "SIALogMessages.h"
#import "SIALogChecks.h"
#import "SIALogContracts.h"

#import "SIALogConsoleOutput.h"
#import "SIALogDocumentsFileOutput.h"
#import "SIALogCrashlyticsOuput.h"

//! Project version number for SIALogger.
FOUNDATION_EXPORT double SIALoggerVersionNumber;

//! Project version string for SIALogger.
FOUNDATION_EXPORT const unsigned char SIALoggerVersionString[];

#endif /* __SIA_LOG_LOGGER_H__ */
