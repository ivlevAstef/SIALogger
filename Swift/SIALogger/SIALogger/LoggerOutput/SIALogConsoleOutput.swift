//
//  SIALogConsoleOutput.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import Foundation

public class SIALogConsoleOutput : SIALogOutputProtocol {
  public func log(message: String) {
    print(currentTime()+message)
  }
  
  private let startDate = NSDate()
  private func currentTime() -> String {
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.dateFormat = "HH:mm:ss:SSS"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")
    
    return dateFormatter.stringFromDate(NSDate(timeInterval: 0, sinceDate: startDate))
  }
}