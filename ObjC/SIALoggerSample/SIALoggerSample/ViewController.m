//
//  ViewController.m
//  SIALoggerSample
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "ViewController.h"
#import <SIALogger/SIALogger.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [SIALogConfig sharedInstance].maxLogLevel = SIALogLevel_Info;

  SIALogTrace(@"1 trace no show");
  
  SIALogInfo(@"1 info");
  SIALogWarning(@"1 warning");
  SIALogError(@"1 error");
  
  [SIALogConfig sharedInstance].maxLogLevel = SIALogLevel_Error;
  SIALogTrace(@"2 trace no show");
  SIALogInfo(@"2 info no show");
  SIALogWarning(@"2 warning no show");
  SIALogError(@"2 error");
  
  [SIALogConfig sharedInstance].maxLogLevel = SIALogLevel_Trace;
  SIALogTrace(@"3 trace");
  
  [SIALogConfig sharedInstance].formatFunction = ^NSString *(NSString *const level, NSString *const file, const SIALineNumber line, NSString *const msg) {
    return [NSString stringWithFormat:@"[%@] {%@:%lld}: %@", level.uppercaseString, file, line, msg];
  };
  
  SIALogTrace(@"4 trace");
  SIALogInfo(@"4 info");
  SIALogWarning(@"4 warning");
  SIALogError(@"4 error");
  
  SIALogTraceIf(true, @"Trace if");
  SIALogInfoIf(false, @"Info if no show");
  SIALogWarningIf(true, @"Warning if");
  SIALogErrorIf(false, @"Error if no show");
  
  ^{
    SIALogRetTraceIf(false, ,@"Trace if no show");
    SIALogInfo(@"It's show");
  }();
  
  ^{
    SIALogRetInfoIf(true, ,@"Info if");
    SIALogInfo(@"no show");
  }();
  
  ^{
    SIALogRetWarningIf(false, ,@"Warning if no show");
    SIALogInfo(@"It's show");
  }();
  
  ^{
    SIALogRetErrorIf(true, ,@"Error if");
    SIALogInfo(@"no show");
  }();
  
  SIALogAssertMsg(true, @"no show");
  SIALogAssertMsg(false, @"assert");
}

@end
