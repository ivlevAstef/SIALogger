//
//  SIACrashlyticsLoggerOuput.m
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//

#ifdef SIA_LOGGER_CRASHLYTICS

#import "SIACrashlyticsLoggerOuput.h"
#import <Crashlytics/Crashlytics.h>

@implementation CrashlyticsLoggerOuput

- (void)log:(NSString*)logString {
  if (nil != logString) {
    CLSLog(@"%@", logString);
  }
}

@end

#endif