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
  
  public func log(message: String) {
    print(currentTime()+" "+message)
  }
  
  private let startDate = NSDate()
  private let dateFormatter = { () -> NSDateFormatter in
    let result = NSDateFormatter()
    
    result.dateFormat = "HH:mm:ss:SSS"
    result.timeZone = NSTimeZone(name: "UTC")
    return result
  }()
  
  private func currentTime() -> String {
    return dateFormatter.stringFromDate(NSDate(timeInterval: 0, sinceDate: startDate))
  }
}