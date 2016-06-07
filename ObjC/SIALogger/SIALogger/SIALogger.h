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
#import "SIALogFormatter.h"
#import "SIALogMessage.h"
#import "SIALog.h"
#import "SIALogConfig.h"

#import "SIALogMessages.h"
#import "SIALogChecks.h"
#import "SIALogContracts.h"

#import "SIALogConsoleOutput.h"
#import "SIALogDocumentsFileOutput.h"

#ifdef __SIA_LOG_COLORFUL__
  #import "SIALogColor.h"
  #import "SIALogColoredConsoleOutput.h"
  #import "SIALogColoredFormatter.h"
#endif

#endif /* __SIA_LOG_LOGGER_H__ */
