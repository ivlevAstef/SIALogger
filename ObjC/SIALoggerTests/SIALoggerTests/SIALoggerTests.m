//
//  SIALoggerTests.m
//  SIALoggerTests
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SIALogger/SIALogger.h>
//#include <signal.h>

//Support
NSString* loggerFormatFunction(SIALogLevel* level, NSString* msg) {
  return [NSString stringWithFormat:@"[%@]%@", level.name.uppercaseString, msg];
}

@interface SIALogTestOutput : NSObject<SIALogOutputProtocol>

- (void)logWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Msg:(NSString*)msg; /*overrride*/

@property (nonatomic, strong) NSString* lastLog;

@end

@implementation SIALogTestOutput

- (void)logWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Msg:(NSString*)msg {
  assert(nil != time && nil != level && nil != file && nil != line && nil != msg);
  self.lastLog = loggerFormatFunction(level, msg);
}

@end

@interface SIALoggerTests : XCTestCase

@property (nonatomic, strong) SIALogTestOutput* logOutput;

@end

@implementation SIALoggerTests

// no worked... I can't catch signal.
//- (void)test_01_Fatal {
//  dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGABRT, 0, dispatch_get_global_queue(0, 0));
//  dispatch_source_set_event_handler(source, ^{
//    NSLog(@"SIGABRT");
//  });
//  dispatch_resume(source);
//  
//  struct sigaction action = { 0 };
//  action.sa_handler = SIG_IGN;
//  sigaction(SIGABRT, &action, NULL);
//  
//  SIALogFatal(@"description");
//  
//  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Fatal, @"description"), self.logOutput.lastLog);
//}

- (void)test_02_Error {
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description %d", 2);
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"description 2"), self.logOutput.lastLog);
}

- (void)test_03_Warning {
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Warning, @"description"), self.logOutput.lastLog);
  
  SIALogWarning(@"description %d", 3);
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Warning, @"description 3"), self.logOutput.lastLog);
}

- (void)test_04_Info {
  SIALogInfo(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Info, @"description"), self.logOutput.lastLog);
  
  SIALogInfo(@"description %d", 4);
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Info, @"description 4"), self.logOutput.lastLog);
}

- (void)test_05_Trace {
  SIALogTrace(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Trace, @"description"), self.logOutput.lastLog);
  
  SIALogTrace(@"description %d", 5);
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Trace, @"description 5"), self.logOutput.lastLog);
}

- (void)test_06_LogIf_NoShow {
  self.logOutput.lastLog = nil;
  SIALogFatalIf(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogErrorIf(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogWarningIf(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogInfoIf(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogTraceIf(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
}

- (void)test_07_LogIf_Show {
  SIALogErrorIf(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"log if true"), self.logOutput.lastLog);
  
  SIALogWarningIf(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Warning, @"log if true"), self.logOutput.lastLog);
  
  SIALogInfoIf(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Info, @"log if true"), self.logOutput.lastLog);
  
  SIALogTraceIf(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Trace, @"log if true"), self.logOutput.lastLog);
}

- (void)test_08_LogIfRet_NoShow {
  self.logOutput.lastLog = nil;
  if (SIALogErrorIf(false, @"no show")) {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  if (SIALogWarningIf(false, @"no show")) {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  if (SIALogInfoIf(false, @"no show")) {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  if (SIALogTraceIf(false, @"no show")) {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
}

- (void)test_09_LogIfRet_Show {
  if (SIALogErrorIf(true, @"log if true")) { } else {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"log if true"), self.logOutput.lastLog);
  
  if (SIALogWarningIf(true, @"log if true")) { } else {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Warning, @"log if true"), self.logOutput.lastLog);
  
  if (SIALogInfoIf(true, @"log if true")) { } else {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Info, @"log if true"), self.logOutput.lastLog);
  
  if (SIALogTraceIf(true, @"log if true")) { } else {
    XCTAssertTrue(false);
  }
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Trace, @"log if true"), self.logOutput.lastLog);
}

- (void)test_10_AbortMethods {
  SIALogAssert(true);
  SIALogAssertMsg(true, @"no show");
  
  SIALogCheck(false);
  
  SIARequires(nil != self);
  
  SIARequiresType(self, SIALoggerTests);
  SIARequiresProtocol(self.logOutput, SIALogOutputProtocol);
  SIARequiresSelector(self, @selector(test_10_AbortMethods));
  SIARequiresNotNil(self);
  
  SIARequiresArrayInterval(0, 5, 10);
  SIARequiresArrayInterval(0, 0, 10);
  SIARequiresArrayInterval(0, 9, 10);
}

- (void)test_11_Config_MaxLogLevel_Trace {
  [SIALogConfig setMaxLogLevel: SIALogLevels.Trace];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Trace, @"description"), self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Info, @"description"), self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Warning, @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"description"), self.logOutput.lastLog);
}

- (void)test_12_Config_MaxLogLevel_Info {
  [SIALogConfig setMaxLogLevel: SIALogLevels.Info];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Info, @"description"), self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Warning, @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"description"), self.logOutput.lastLog);
}

- (void)test_13_Config_MaxLogLevel_Warning {
  [SIALogConfig setMaxLogLevel: SIALogLevels.Warning];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Warning, @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"description"), self.logOutput.lastLog);
}

- (void)test_14_Config_MaxLogLevel_Error {
  [SIALogConfig setMaxLogLevel: SIALogLevels.Error];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(SIALogLevels.Error, @"description"), self.logOutput.lastLog);
}

- (void)test_15_Config_MaxLogLevel_Fatal {
  [SIALogConfig setMaxLogLevel: SIALogLevels.Fatal];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
}

#define TEST_PERFORMANCE_OPERATION_COUNT 100000
- (void)test_99_Performance_Enable_Log {
 [self measureBlock:^{
   for(size_t i =0; i < TEST_PERFORMANCE_OPERATION_COUNT; i++) {
     SIALogInfo(@"message");
   }
 }];
}

- (void)test_99_Performance_Disable_Log {
  [SIALogConfig setMaxLogLevel: SIALogLevels.Fatal];
  
  [self measureBlock:^{
    for(size_t i =0; i < TEST_PERFORMANCE_OPERATION_COUNT; i++) {
      SIALogInfo(@"message");
    }
  }];
}

#define TEST_PERFORMANCE_CONSOLE_DOCUMENTS_COUNT 20000
- (void)test_99_Performance_Document {
  [SIALogConfig setOutputs: @[ [[SIALogDocumentsFileOutput alloc] initWithFileName:@"TEST" joinDate:YES] ]];
  
  [self measureBlock:^{
    for(size_t i =0; i < TEST_PERFORMANCE_CONSOLE_DOCUMENTS_COUNT; i++) {
      SIALogInfo(@"message");
    }
  }];
}

#define TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT 2500
- (void)test_99_Performance_Console {
  [SIALogConfig setOutputs: @[ [[SIALogConsoleOutput alloc] init] ]];
  
  [self measureBlock:^{
    for(size_t i =0; i < TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT; i++) {
      SIALogInfo(@"message");
    }
  }];
}


#define TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT 2500
- (void)test_99_Performance_ColorConsole {
  [SIALogConfig setOutputs: @[ [[SIALogColoredConsoleOutput alloc] init] ]];
  
  [self measureBlock:^{
    for(size_t i =0; i < TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT; i++) {
      SIALogInfo(@"message");
    }
  }];
}

- (void)setUp {
  [super setUp];
  
  self.logOutput = [SIALogTestOutput new];
  [SIALogConfig setOutputs: @[self.logOutput]];  
  [SIALogConfig setMaxLogLevel: SIALogLevels.Trace];
}

@end
