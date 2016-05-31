//
//  Config.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

public struct Config {
  public static var maxLogLevel = Level.Info
  public static var outputs : [SIALoggerOutputProtocol] = [SIAConsoleOutput()]
  public static var formatFunction = { (level: String, file: String, line: UInt, msg: String) in " "+level+" {"+file+":"+String(line)+"}: "+msg }
}