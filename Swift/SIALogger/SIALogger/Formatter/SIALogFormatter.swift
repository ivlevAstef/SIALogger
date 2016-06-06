//
//  SIALogFormatter.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

public class SIALogFormatter {
  public required init(format: String) {
    self.methodStrings = SIALogFormatter.parse(format)
  }
  
  public func toString(message: SIALogMessage) -> String {
    var result = ""
    
    for method in self.methodStrings {
      result += method(msg:message)
    }
    
    return result
  }
  
  private typealias MessageToString = (msg: SIALogMessage) -> String
  private let methodStrings : [MessageToString]

  private typealias RangeData = (Range<String.Index>, MessageToString)
  private static func parse(format: String) -> [MessageToString] {
    var result : [MessageToString] = []
    
    var substring = ""
    
    var index = format.startIndex
    while (index < format.endIndex) {
      if "%" == format[index] {
        let token = format.substringWithRange(index..<index.advancedBy(2, limit: format.endIndex))
        if let method = methodByToken(token) {
          appendSubstringIfNeed(&substring, array: &result)
          result.append(method)
          
          index = index.advancedBy(2)
          continue
        }
      }
      
      substring.append(format[index])
      index = index.successor()
    }
    
    appendSubstringIfNeed(&substring, array: &result)
    
    return result
  }
  
  private static func appendSubstringIfNeed(inout substring: String, inout array: [MessageToString]) {
    if !substring.isEmpty {
      let str = substring
      array.append({_ in str})
      substring = ""
    }
  }
  
  private static func methodByToken(token: String) -> MessageToString? {
    let tokenToMethod: [String : (msg: SIALogMessage) -> String] = [
      "%t" : {$0.time},
      "%L" : {$0.level.toString()},
      "%3" : {$0.level.toShortString()},
      "%U" : {$0.level.toString().uppercaseString},
      "%f" : {$0.file},
      "%l" : {String($0.line)},
      "%m" : {$0.text}
    ]
    
    for (tokenVariant, method) in tokenToMethod {
      if tokenVariant == token {
        return method
      }
    }
    
    return nil
  }
  
}