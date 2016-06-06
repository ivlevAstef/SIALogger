//
//  SIALogColoredConsoleOutput.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 03/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import Foundation

public class SIALogColoredConsoleOutput : SIALogOutputProtocol {
  public static let defaultLogFormat = "%t %c[%UL]%c {%f:%l}: %m"
  
  public convenience init() {
    self.init(logFormat: SIALogColoredConsoleOutput.defaultLogFormat)
  }
  
  public required init(logFormat: String) {
    formatter = SIALogColoredFormatter(format: logFormat)
    setDefaultColors()
  }
  
  public func log(msg: SIALogMessage) {
    print(formatter.toString(msg, coloredMethod: {self.colored($0, level: msg.level)}))
  }
  
  public func setForegroundColor(color : SIALogColor, level: SIALogLevel) {
    colorForegroundMap[level] = color
  }
  public func setBackgroundColor(color : SIALogColor, level: SIALogLevel) {
    colorBackgroundMap[level] = color
  }
  public func setDefaultColors() {
    setForegroundColor(SIALogColor(255,255,255), level: SIALogLevel.Fatal)
    setBackgroundColor(SIALogColor(255,0  ,0  ), level: SIALogLevel.Fatal)
    
    setForegroundColor(SIALogColor(255,0  ,0  ), level: SIALogLevel.Error)
    setForegroundColor(SIALogColor(255,128,0  ), level: SIALogLevel.Warning)
    setForegroundColor(SIALogColor(64 ,64 ,255), level: SIALogLevel.Info)
    setForegroundColor(SIALogColor(128,128,128), level: SIALogLevel.Trace)
  }
  
  public func colored(text : String, level: SIALogLevel) -> String {
    var fgColorStrOptional : String?
    if let fgColor = colorForegroundMap[level] {
      fgColorStrOptional = SIALogColoredConsoleOutput.ESCAPE+"fg"+fgColor.xcodeColor
    }
    
    var bgColorStrOptional : String?
    if let bgColor = colorBackgroundMap[level] {
      bgColorStrOptional = SIALogColoredConsoleOutput.ESCAPE+"bg"+bgColor.xcodeColor
    }
    
    if nil == fgColorStrOptional && nil == bgColorStrOptional {
      return text
    }
    
    let fgColorStr = fgColorStrOptional ?? ""
    let bgColorStr = bgColorStrOptional ?? ""
    
    return bgColorStr+fgColorStr+text+SIALogColoredConsoleOutput.RESET
  }
  
  private let formatter: SIALogColoredFormatter
  
  private static let ESCAPE = "\u{001b}["
  private static let RESET = "\u{001b}[" + ";"
  
  private var colorForegroundMap : [SIALogLevel:SIALogColor] = [:]
  private var colorBackgroundMap : [SIALogLevel:SIALogColor] = [:]
}