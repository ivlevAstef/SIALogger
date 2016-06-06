//
//  SIALogFormatter.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

public class SIALogFormatter {
  public let format: String
  
  public required init(format: String) {
    self.format = format
    self.ranges = SIALogFormatter.parse(format)
  }
  
  public func toString(message: SIALogMessage) -> String {
    var result = self.format
    
    for (range, method) in self.ranges {
      result.replaceRange(range, with: method(msg: message))
    }
    
    return result
  }
  
  private typealias RangeData = (Range<String.Index>, (msg: SIALogMessage) -> String)
  private let ranges : [RangeData]

  private static func parse(format: String) -> [RangeData] {
    let tokenToMethod: [String : (msg: SIALogMessage) -> String] = [
      "%t" : {$0.time},
      "%L" : {$0.level.toString()},
      "%3L": {$0.level.toShortString()},
      "%UL": {$0.level.toString().uppercaseString},
      "%f" : {$0.file},
      "%l" : {String($0.line)},
      "%m" : {$0.text}
    ]
    
    var result : [RangeData] = []
    
    for (token, method) in tokenToMethod {
      var searchRange = format.startIndex..<format.endIndex
      
      while let range = format.rangeOfString(token, options: NSStringCompareOptions.LiteralSearch, range: searchRange, locale: nil) {
        result.append((range, method))
        searchRange.startIndex = range.endIndex
      }
    }
    
    return result.sort { $0.0.startIndex > $1.0.startIndex }
  }
  
}