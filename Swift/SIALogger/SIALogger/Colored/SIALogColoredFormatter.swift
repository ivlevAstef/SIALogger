//
//  SIALogColoredFormatter.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

public class SIALogColoredFormatter {
  public let format: String
  
  public required init(format: String) {
    self.format = format
    self.formatters = SIALogColoredFormatter.parse(format)
  }
  
  public func toString(message: SIALogMessage, coloredMethod: (String) -> String) -> String {
    var result = ""
    
    var index = 0
    for formatter in self.formatters {
      if 0 == index%2 {
        result += formatter.toString(message)
      } else {
        result += coloredMethod(formatter.toString(message))
      }
      
      index += 1
    }
    
    return result
  }
  
  private let formatters : [SIALogFormatter]
  
  private static func parse(format: String) -> [SIALogFormatter] {
    var result : [SIALogFormatter] = []

    var formatIter = format
    
    while let range = formatIter.rangeOfString("%c") {
      result.append(SIALogFormatter(format: formatIter.substringToIndex(range.startIndex)))
      
      formatIter = formatIter.substringFromIndex(range.endIndex);
    }
    
    if !formatIter.isEmpty {
      result.append(SIALogFormatter(format: formatIter))
    }
    
    return result
  }
  
}
