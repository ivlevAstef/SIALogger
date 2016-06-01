//
//  SIALogConfig.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

public struct SIALogConfig {
  public static var maxLogLevel = SIALogLevel.Info
  public static var outputs : [SIALogOutputProtocol] = [SIALogConsoleOutput()]
  public static var formatFunction = { (level: String, file: String, line: UInt, msg: String) in " "+level+" {"+file+":"+String(line)+"}: "+msg }
}