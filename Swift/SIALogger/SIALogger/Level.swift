//
//  Level.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

public enum Level : Int {
  case Fatal = 0
  case Error
  case Warning
  case Info
  case Trace
  
  internal func toString() -> String {
    switch self {
    case .Fatal:
      return "Fatal"
    case .Error:
      return "Error"
    case .Warning:
      return "Warning"
    case .Info:
      return "Info"
    case .Trace:
      return "Trace"
    }
  }
}