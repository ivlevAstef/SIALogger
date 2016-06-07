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
  
  [SIALogConfig setOutputs:@[ [SIALogColoredConsoleOutput new] ]];
  
  [SIALogConfig setMaxLogLevel: SIALogLevels.Info];

  SIALogTrace(@"1 trace no show");
  
  SIALogInfo(@"1 info");
  SIALogWarning(@"1 warning");
  SIALogError(@"1 error");
  
  [SIALogConfig setMaxLogLevel: SIALogLevels.Error];
  SIALogTrace(@"2 trace no show");
  SIALogInfo(@"2 info no show");
  SIALogWarning(@"2 warning no show");
  SIALogError(@"2 error");
  
  [SIALogConfig setMaxLogLevel: SIALogLevels.Trace];
  SIALogTrace(@"3 trace");
  
  SIALogTrace(@"4 trace");
  SIALogInfo(@"4 info");
  SIALogWarning(@"4 warning");
  SIALogError(@"4 error");
  
  SIALogTraceIf(true, @"Trace if");
  SIALogInfoIf(false, @"Info if no show");
  SIALogWarningIf(true, @"Warning if");
  SIALogErrorIf(false, @"Error if no show");
  
  if (SIALogTraceIf(false, @"Trace if no show")) {
    SIALogInfo(@"By trace no show");
  }
  
  if (SIALogInfoIf(true, @"Info if")) {
    SIALogInfo(@"By info");
  }
  
  if (SIALogWarningIf(false, @"Warning if no show")) {
    SIALogInfo(@"By warning no show");
  }
  
  if (SIALogErrorIf(true, @"Error if")) {
    SIALogInfo(@"By error");
  }
  
  SIALogAssertMsg(true, @"no show");
  SIALogAssertMsg(false, @"assert");
}

@end
