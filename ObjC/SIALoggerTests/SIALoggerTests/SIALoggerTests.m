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

@interface SIALoggerTestOutput : NSObject<SIALoggerOutputProtocol>

- (void)log:(NSString*)logString; /*overrride*/

@property (nonatomic, strong) NSString* lastLog;

@end

@implementation SIALoggerTestOutput

- (void)log:(NSString*)logString {
  self.lastLog = logString;
}

@end

@interface SIALoggerTests : XCTestCase

@property (nonatomic, strong) SIALoggerTestOutput* logOutput;

@end

@implementation SIALoggerTests

- (void)test_00_Config_FormatOutput {
  [[SIALogConfig sharedInstance] setFormatFunction:^NSString *(NSString *const level, NSString *const file, const SIALineNumber line, NSString *const msg) {
    return level;
  }];
  
  SIALogInfo(@"test");
  XCTAssertEqualObjects(@"Info", self.logOutput.lastLog);

  
  [[SIALogConfig sharedInstance] setFormatFunction:^NSString *(NSString *const level, NSString *const file, const SIALineNumber line, NSString *const msg) {
    return msg;
  }];
  
  SIALogInfo(@"test");
  XCTAssertEqualObjects(@"test", self.logOutput.lastLog);
  
  
  [[SIALogConfig sharedInstance] setFormatFunction:^NSString *(NSString *const level, NSString *const file, const SIALineNumber line, NSString *const msg) {
    return file;
  }];
  
  SIALogInfo(@"test"); NSString* file = [@__FILE__ lastPathComponent];
  XCTAssertEqualObjects(file, self.logOutput.lastLog);
  
  
  [[SIALogConfig sharedInstance] setFormatFunction:^NSString *(NSString *const level, NSString *const file, const SIALineNumber line, NSString *const msg) {
    return [@(line) stringValue];
  }];
  
  SIALogInfo(@"test"); NSString* line = [@(__LINE__) stringValue];
  XCTAssertEqualObjects(line, self.logOutput.lastLog);
}


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
//  XCTAssertEqualObjects(loggerFormatFunction(@"Fatal", @"description"), self.logOutput.lastLog);
//}

- (void)test_02_Error {
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description %d", 2);
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"description 2"), self.logOutput.lastLog);
}

- (void)test_03_Warning {
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Warning", @"description"), self.logOutput.lastLog);
  
  SIALogWarning(@"description %d", 3);
  XCTAssertEqualObjects(loggerFormatFunction(@"Warning", @"description 3"), self.logOutput.lastLog);
}

- (void)test_04_Info {
  SIALogInfo(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Info", @"description"), self.logOutput.lastLog);
  
  SIALogInfo(@"description %d", 4);
  XCTAssertEqualObjects(loggerFormatFunction(@"Info", @"description 4"), self.logOutput.lastLog);
}

- (void)test_05_Trace {
  SIALogTrace(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Trace", @"description"), self.logOutput.lastLog);
  
  SIALogTrace(@"description %d", 5);
  XCTAssertEqualObjects(loggerFormatFunction(@"Trace", @"description 5"), self.logOutput.lastLog);
}

- (void)test_06_LogIf_NoShow {
  self.logOutput.lastLog = nil;
  SIALogIfFatal(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogIfError(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogIfWarning(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogIfInfo(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  SIALogIfTrace(false, @"no show");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
}

- (void)test_07_LogIf_Show {
  SIALogIfError(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"log if true"), self.logOutput.lastLog);
  
  SIALogIfWarning(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(@"Warning", @"log if true"), self.logOutput.lastLog);
  
  SIALogIfInfo(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(@"Info", @"log if true"), self.logOutput.lastLog);
  
  SIALogIfTrace(true, @"log if true");
  XCTAssertEqualObjects(loggerFormatFunction(@"Trace", @"log if true"), self.logOutput.lastLog);
}

- (void)test_08_LogIfRet_NoShow {
  __block BOOL status = false;
  
  self.logOutput.lastLog = nil;
  status = false;
  ^{
    SIALogRetIfError(false, , @"no return");
    status = true;
  }();
  XCTAssertTrue(status);
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  status = false;
  ^{
    SIALogRetIfWarning(false, , @"no return");
    status = true;
  }();
  XCTAssertTrue(status);
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  status = false;
  ^{
    SIALogRetIfInfo(false, , @"no return");
    status = true;
  }();
  XCTAssertTrue(status);
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  self.logOutput.lastLog = nil;
  status = false;
  ^{
    SIALogRetIfTrace(false, , @"no return");
    status = true;
  }();
  XCTAssertTrue(status);
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
}

- (void)test_09_LogIfRet_Show {
  int code = 0;
  
  code = ^int{
    SIALogRetIfError(true, 1, @"log if true");
    return 0;
  }();
  XCTAssertEqual(code, 1);
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"log if true"), self.logOutput.lastLog);
  
  code = ^int{
    SIALogRetIfWarning(true, 2, @"log if true");
    return 0;
  }();
  XCTAssertEqual(code, 2);
  XCTAssertEqualObjects(loggerFormatFunction(@"Warning", @"log if true"), self.logOutput.lastLog);
  
  code = ^int{
    SIALogRetIfInfo(true, 3, @"log if true");
    return 0;
  }();
  XCTAssertEqual(code, 3);
  XCTAssertEqualObjects(loggerFormatFunction(@"Info", @"log if true"), self.logOutput.lastLog);
  
  code = ^int{
    SIALogRetIfTrace(true, 4, @"log if true");
    return 0;
  }();
  XCTAssertEqual(code, 4);
  XCTAssertEqualObjects(loggerFormatFunction(@"Trace", @"log if true"), self.logOutput.lastLog);
}

- (void)test_10_AbortMethods {
  SIALogAssert(true);
  SIALogAssertMsg(true, @"no show");
  
  SIALogCheck(false);
  
  SIARequires(nil != self);
  
  SIARequiresType(self, SIALoggerTests);
  SIARequiresProtocol(self.logOutput, SIALoggerOutputProtocol);
  SIARequiresSelector(self, @selector(test_10_AbortMethods));
  SIARequiresNotNil(self);
  
  SIARequiresArrayInterval(0, 5, 10);
  SIARequiresArrayInterval(0, 0, 10);
  SIARequiresArrayInterval(0, 9, 10);
}

- (void)test_11_Config_MaxLogLevel_Trace {
  [[SIALogConfig sharedInstance] setMaxLogLevel:SIALogLevel_Trace];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Trace", @"description"), self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Info", @"description"), self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Warning", @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"description"), self.logOutput.lastLog);
}

- (void)test_12_Config_MaxLogLevel_Info {
  [[SIALogConfig sharedInstance] setMaxLogLevel:SIALogLevel_Info];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Info", @"description"), self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Warning", @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"description"), self.logOutput.lastLog);
}

- (void)test_13_Config_MaxLogLevel_Warning {
  [[SIALogConfig sharedInstance] setMaxLogLevel:SIALogLevel_Warning];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Warning", @"description"), self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"description"), self.logOutput.lastLog);
}

- (void)test_14_Config_MaxLogLevel_Error {
  [[SIALogConfig sharedInstance] setMaxLogLevel:SIALogLevel_Error];
  self.logOutput.lastLog = nil;
  
  SIALogTrace(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogInfo(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogWarning(@"description");
  XCTAssertEqualObjects(nil, self.logOutput.lastLog);
  
  SIALogError(@"description");
  XCTAssertEqualObjects(loggerFormatFunction(@"Error", @"description"), self.logOutput.lastLog);
}

- (void)test_15_Config_MaxLogLevel_Fatal {
  [[SIALogConfig sharedInstance] setMaxLogLevel:SIALogLevel_Fatal];
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
  [[SIALogConfig sharedInstance] setMaxLogLevel:SIALogLevel_Fatal];
  
  [self measureBlock:^{
    for(size_t i =0; i < TEST_PERFORMANCE_OPERATION_COUNT; i++) {
      SIALogInfo(@"message");
    }
  }];
}

#define TEST_PERFORMANCE_CONSOLE_DOCUMENTS_COUNT 20000
- (void)test_99_Performance_Document {
  [[SIALogConfig sharedInstance] setOutputArray: @[ [[SIADocumentsFileOutput alloc] initWithFileName:@"TEST" joinDate:YES] ]];
  
  [self measureBlock:^{
    for(size_t i =0; i < TEST_PERFORMANCE_CONSOLE_DOCUMENTS_COUNT; i++) {
      SIALogInfo(@"message");
    }
  }];
}

#define TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT 2500
- (void)test_99_Performance_Console {
  [[SIALogConfig sharedInstance] setOutputArray: @[ [[SIAConsoleOutput alloc] init] ]];
  
  [self measureBlock:^{
    for(size_t i =0; i < TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT; i++) {
      SIALogInfo(@"message");
    }
  }];
}


- (void)setUp {
  [super setUp];
  
  self.logOutput = [SIALoggerTestOutput new];
  [[SIALogConfig sharedInstance] setOutputArray: @[self.logOutput]];
  
  [[SIALogConfig sharedInstance] setFormatFunction:^NSString*(NSString* const level, NSString* const file, const SIALineNumber line, NSString* const msg) {
    return loggerFormatFunction(level, msg);
  }];
  
  [[SIALogConfig sharedInstance] setMaxLogLevel:SIALogLevel_Trace];
}

//Support
NSString* loggerFormatFunction(NSString* const level, NSString* const msg) {
  return [NSString stringWithFormat:@"[%@]%@", level.uppercaseString, msg];
}

@end
