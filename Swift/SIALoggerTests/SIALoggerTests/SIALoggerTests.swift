//
//  SIALoggerTests.swift
//  SIALoggerTests
//
//  Created by Alexander Ivlev on 01/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import XCTest
import SIALogger

func formatFunction(level level: SIALogLevel, msg: String) -> String {
  return "["+level.toString().uppercaseString+"]"+msg
}

class SIALogTestOutput: SIALogOutputProtocol {
  var lastLog: String? = nil
  var formatter: SIALogFormatter? = nil
  
  func log(msg: SIALogMessage) {
    if let formatter = self.formatter {
      lastLog = formatter.toString(msg)
    } else {
      lastLog = formatFunction(level: msg.level, msg: msg.text)
    }
  }
}

class SIALoggerTests: XCTestCase {
  var logOutput : SIALogTestOutput = SIALogTestOutput()
  
  func test_01_Formatter() {
    logOutput.lastLog = nil
    logOutput.formatter = SIALogFormatter(format: "%t")
    SIALog.Info("message")
    XCTAssertNotEqual(nil, logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%L")
    SIALog.Info("message")
    XCTAssertEqual(SIALogLevel.Info.toString(), logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%3")
    SIALog.Info("message")
    XCTAssertEqual(SIALogLevel.Info.toShortString(), logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%U")
    SIALog.Info("message")
    XCTAssertEqual(SIALogLevel.Info.toString().uppercaseString, logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%f")
    SIALog.Info("message"); let file = (#file as NSString).lastPathComponent
    XCTAssertEqual(file, logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%l")
    SIALog.Info("message"); let line = String(#line)
    XCTAssertEqual(line, logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%m")
    SIALog.Info("message")
    XCTAssertEqual("message", logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "")
    SIALog.Info("message")
    XCTAssertEqual("", logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%%%%")
    SIALog.Info("message")
    XCTAssertEqual("%%%%", logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%%m%%m%%")
    SIALog.Info("message")
    XCTAssertEqual("%message%message%%", logOutput.lastLog)
    
    logOutput.formatter = SIALogFormatter(format: "%mU%m3%mf%ml%mL")
    SIALog.Info("message")
    XCTAssertEqual("messageUmessage3messagefmessagelmessageL", logOutput.lastLog)
  }
  
  func test_02_Error() {
    SIALog.Error("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "description"), logOutput.lastLog)
    
    SIALog.Error("description "+String(2))
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "description 2"), logOutput.lastLog)
  }
  
  func test_03_Warning() {
    SIALog.Warning("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Warning, msg: "description"), logOutput.lastLog)
    
    SIALog.Warning("description "+String(3))
    XCTAssertEqual(formatFunction(level: SIALogLevel.Warning, msg: "description 3"), logOutput.lastLog)
  }
  
  func test_04_Info() {
    SIALog.Info("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Info, msg: "description"), logOutput.lastLog)
    
    SIALog.Info("description "+String(4))
    XCTAssertEqual(formatFunction(level: SIALogLevel.Info, msg: "description 4"), logOutput.lastLog)
  }
  
  func test_05_Trace() {
    SIALog.Trace("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Trace, msg: "description"), logOutput.lastLog)
    
    SIALog.Trace("description "+String(5))
    XCTAssertEqual(formatFunction(level: SIALogLevel.Trace, msg: "description 5"), logOutput.lastLog)
  }
  
  func test_06_LogIf_NoShow() {
    logOutput.lastLog = nil
    SIALog.FatalIf(false, msg: "no show")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    logOutput.lastLog = nil
    SIALog.ErrorIf(false, msg: "no show")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    logOutput.lastLog = nil
    SIALog.WarningIf(false, msg: "no show")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    logOutput.lastLog = nil
    SIALog.InfoIf(false, msg: "no show")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    logOutput.lastLog = nil
    SIALog.TraceIf(false, msg: "no show")
    XCTAssertEqual(nil, logOutput.lastLog)
  }
  
  func test_07_LogIf_Show() {
    SIALog.ErrorIf(true, msg: "log if true")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "log if true"), logOutput.lastLog)
    
    SIALog.WarningIf(true, msg: "log if true")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Warning, msg: "log if true"), logOutput.lastLog)
    
    SIALog.InfoIf(true, msg: "log if true")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Info, msg: "log if true"), logOutput.lastLog)
    
    SIALog.TraceIf(true, msg: "log if true")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Trace, msg: "log if true"), logOutput.lastLog)
  }
  
  func test_07_LogIfRet_NoShow() {
    logOutput.lastLog = nil
    if (SIALog.ErrorIf(false, msg: "no show")) {
      XCTAssertTrue(false)
    }
    XCTAssertEqual(nil, logOutput.lastLog)
    
    logOutput.lastLog = nil
    if (SIALog.WarningIf(false, msg: "no show")) {
      XCTAssertTrue(false)
    }
    XCTAssertEqual(nil, logOutput.lastLog)
    
    logOutput.lastLog = nil
    if (SIALog.InfoIf(false, msg: "no show")) {
      XCTAssertTrue(false)
    }
    XCTAssertEqual(nil, logOutput.lastLog)
    
    logOutput.lastLog = nil
    if (SIALog.TraceIf(false, msg: "no show")) {
      XCTAssertTrue(false)
    }
    XCTAssertEqual(nil, logOutput.lastLog)

  }
  
  func test_09_LogIfRet_Show() {
    repeat {
      guard SIALog.ErrorIf(true, msg: "log if true") else {
        XCTAssertTrue(false)
        break
      }
    }while(false)
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "log if true"), logOutput.lastLog)
    
    repeat {
      guard SIALog.WarningIf(true, msg: "log if true") else {
        XCTAssertTrue(false)
        break
      }
    }while(false)
    XCTAssertEqual(formatFunction(level: SIALogLevel.Warning, msg: "log if true"), logOutput.lastLog)
    
    repeat {
      guard SIALog.InfoIf(true, msg: "log if true") else {
        XCTAssertTrue(false)
        break
      }
    }while(false)
    XCTAssertEqual(formatFunction(level: SIALogLevel.Info, msg: "log if true"), logOutput.lastLog)
    
    repeat {
      guard SIALog.TraceIf(true, msg: "log if true") else {
        XCTAssertTrue(false)
        break
      }
    }while(false)
    XCTAssertEqual(formatFunction(level: SIALogLevel.Trace, msg: "log if true"), logOutput.lastLog)
  }
  
  func test_10_AbortMethods() {
    SIALog.Assert(true)
    SIALog.Assert(true, msg: "no show")
    
    SIALog.Check(false)
    
    //required only Obj-C
  }
  
  func test_11_Config_MaxLogLevel_Trace() {
    SIALogConfig.maxLogLevel = SIALogLevel.Trace
    logOutput.lastLog = nil
    
    SIALog.Trace("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Trace, msg: "description"), logOutput.lastLog)
    
    SIALog.Info("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Info, msg: "description"), logOutput.lastLog)
    
    SIALog.Warning("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Warning, msg: "description"), logOutput.lastLog)
    
    SIALog.Error("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "description"), logOutput.lastLog)
  }
  
  func test_12_Config_MaxLogLevel_Info() {
    SIALogConfig.maxLogLevel = SIALogLevel.Info
    logOutput.lastLog = nil
    
    SIALog.Trace("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Info("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Info, msg: "description"), logOutput.lastLog)
    
    SIALog.Warning("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Warning, msg: "description"), logOutput.lastLog)
    
    SIALog.Error("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "description"), logOutput.lastLog)
  }
  
  func test_13_Config_MaxLogLevel_Warning() {
    SIALogConfig.maxLogLevel = SIALogLevel.Warning
    logOutput.lastLog = nil
    
    SIALog.Trace("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Info("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Warning("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Warning, msg: "description"), logOutput.lastLog)
    
    SIALog.Error("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "description"), logOutput.lastLog)
  }
  
  func test_14_Config_MaxLogLevel_Error() {
    SIALogConfig.maxLogLevel = SIALogLevel.Error
    logOutput.lastLog = nil
    
    SIALog.Trace("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Info("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Warning("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Error("description")
    XCTAssertEqual(formatFunction(level: SIALogLevel.Error, msg: "description"), logOutput.lastLog)
  }
  
  func test_15_Config_MaxLogLevel_Fatal() {
    SIALogConfig.maxLogLevel = SIALogLevel.Fatal
    logOutput.lastLog = nil
    
    SIALog.Trace("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Info("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Warning("description")
    XCTAssertEqual(nil, logOutput.lastLog)
    
    SIALog.Error("description")
    XCTAssertEqual(nil, logOutput.lastLog)
  }
  
  let TEST_PERFORMANCE_OPERATION_COUNT = 100000
  func test_99_Performance_Enable_Log() {
    self.measureBlock {
      for _ in 0..<self.TEST_PERFORMANCE_OPERATION_COUNT {
        SIALog.Info("message")
      }
    }
  }
  
  func test_99_Performance_Disable_Log() {
    SIALogConfig.maxLogLevel = SIALogLevel.Fatal
    
    self.measureBlock {
      for _ in 0..<self.TEST_PERFORMANCE_OPERATION_COUNT {
        SIALog.Info("message")
      }
    }
  }
  
  let TEST_PERFORMANCE_DOCUMENTS_OPERATION_COUNT = 20000
  func test_99_Performance_Document() {
    guard let docOutput = SIALogDocumentsFileOutput(fileName: "TEST", joinDate: true) else {
      XCTAssertTrue(false)
      return
    }
    SIALogConfig.outputs = [docOutput]
    
    self.measureBlock {
      for _ in 0..<self.TEST_PERFORMANCE_DOCUMENTS_OPERATION_COUNT {
        SIALog.Info("message")
      }
    }
  }
  
  let TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT = 2500
  func test_99_Performance_Console() {
    SIALogConfig.outputs = [SIALogConsoleOutput()]
    
    self.measureBlock {
      for _ in 0..<self.TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT {
        SIALog.Info("message")
      }
    }
  }
  
  func test_99_Performance_ColorConsole() {
    SIALogConfig.outputs = [SIALogColoredConsoleOutput()]
    
    self.measureBlock {
      for _ in 0..<self.TEST_PERFORMANCE_CONSOLE_OPERATION_COUNT {
        SIALog.Info("message")
      }
    }
  }
  
  override func setUp() {
    super.setUp()
    
    logOutput = SIALogTestOutput()
    SIALogConfig.outputs = [logOutput]
    SIALogConfig.maxLogLevel = SIALogLevel.Trace
  }
}
