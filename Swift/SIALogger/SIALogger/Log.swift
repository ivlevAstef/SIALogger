//
//  SIALogger.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 30/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

//Log Levels
public extension Log {
  public static func Fatal(msg: String, file: String = #file, line: Int = #line) {
    log(Level.Fatal, msg: msg, file: file, line: line)
    abort()
  }
  
  public static func Error(msg: String, file: String = #file, line: Int = #line) {
    log(Level.Error, msg: msg, file: file, line: line)
  }
  
  public static func Warning(msg: String, file: String = #file, line: Int = #line) {
    log(Level.Warning, msg: msg, file: file, line: line)
  }
  
  public static func Info(msg: String, file: String = #file, line: Int = #line) {
    log(Level.Info, msg: msg, file: file, line: line)
  }
  
  public static func Trace(msg: String, file: String = #file, line: Int = #line) {
    log(Level.Trace, msg: msg, file: file, line: line)
  }
}

//Assertions
public extension Log {
  public static func Assert(condition: Bool, msg: String = "", file: String = #file, line: Int = #line) {
    guard condition else {
      let message = "Activate assert with message: " + msg
      log(Level.Fatal, msg: message, file: file, line: line)
      assert(condition, message)
      return
    }
  }
  
  public static func Check(condition: Bool, file: String = #file, line: Int = #line) {
    if condition {
      Fatal("Check failed", file: file, line: line)
    }
  }
  
  public static func NotImplemented(file: String = #file, line: Int = #line, method: String = #function) {
    Assert(false, msg: ("Not Implemented: " + method), file: file, line: line)
  }
}

//Log if
public extension Log {
  public static func FatalIf(condition: Bool, msg: String, file: String = #file, line: Int = #line) -> Bool {
    return If(condition, method: Fatal, msg: msg, file: file, line: line)
  }
  
  public static func ErrorIf(condition: Bool, msg: String, file: String = #file, line: Int = #line) -> Bool {
    return If(condition, method: Error, msg: msg, file: file, line: line)
  }
  
  public static func WarningIf(condition: Bool, msg: String, file: String = #file, line: Int = #line) -> Bool {
    return If(condition, method: Warning, msg: msg, file: file, line: line)
  }
  
  public static func InfoIf(condition: Bool, msg: String, file: String = #file, line: Int = #line) -> Bool {
    return If(condition, method: Info, msg: msg, file: file, line: line)
  }
  
  public static func TraceIf(condition: Bool, msg: String, file: String = #file, line: Int = #line) -> Bool {
    return If(condition, method: Trace, msg: msg, file: file, line: line)
  }
  
  private static func If(condition: Bool, method: (String,String, Int) -> (), msg: String, file: String = #file, line: Int = #line) -> Bool {
    if condition {
      method(msg, file, line)
    }
    return condition
  }
}

public final class Log {
  private static func log(level: Level, msg: String, file: String = #file, line: Int = #line) {
    guard level.rawValue <= Config.maxLogLevel.rawValue else {
      return
    }
    
    let message = Config.formatFunction(level.toString(), (file as NSString).lastPathComponent, line, msg)
    for output in Config.outputs {
      output.log(message)
    }
  }
}