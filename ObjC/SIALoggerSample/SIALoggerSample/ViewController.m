//
//  ViewController.m
//  SIALoggerSample
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "ViewController.h"
#import "SIALogger/SIALogger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [SIALogger sharedInstance].maxLogLevel = SIALogLevel_Info;

  SIALogTrace(@"1 trace no show");
  
  SIALogInfo(@"1 info");
  SIALogWarning(@"1 warning");
  SIALogError(@"1 error");
  
  [SIALogger sharedInstance].maxLogLevel = SIALogLevel_Error;
  SIALogTrace(@"2 trace no show");
  SIALogInfo(@"2 info no show");
  SIALogWarning(@"2 warning no show");
  SIALogError(@"2 error");
  
  [SIALogger sharedInstance].maxLogLevel = SIALogLevel_Trace;
  SIALogTrace(@"3 trace");
  
  [[SIALogger sharedInstance] setFormatFunction:^NSString *(NSString *const level, NSString *const file, const SIALineNumber line, NSString *const msg) {
    return [NSString stringWithFormat:@"[%@] {%@:%lld}: %@", level.uppercaseString, file, line, msg];
  }];
  
  SIALogTrace(@"4 trace");
  SIALogInfo(@"4 info");
  SIALogWarning(@"4 warning");
  SIALogError(@"4 error");
  
  SIALogIfTrace(true, @"Trace if");
  SIALogIfInfo(false, @"Info if no show");
  SIALogIfWarning(true, @"Warning if");
  SIALogIfError(false, @"Error if no show");
  
  SIALogAssertMsg(true, @"no show");
  SIALogAssertMsg(false, @"assert");
}

@end
