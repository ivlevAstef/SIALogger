//
//  SIALogConsoleOutput.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import Foundation

public class SIALogConsoleOutput : SIALogOutputProtocol {
  public init() {
  }
  
  public func log(time time: String, level: SIALogLevel, file: String, line: UInt, msg: String) {
    print(time+" ["+level.toString().uppercaseString+"] {"+file+":"+String(line)+"}: "+msg)
  }
}