//
//  SIALogDocumentsFileOutput.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import Foundation

public class SIALogDocumentsFileOutput : SIALogOutputProtocol {
  public required init?(fileName: String, joinDate: Bool = true) {
    guard let filePath = SIALogDocumentsFileOutput.createFilePath(fileName, joinDate: joinDate) else {
      return nil
    }
    
    NSFileManager.defaultManager().createFileAtPath(filePath, contents: nil, attributes: nil)
    
    guard let outputHandle = NSFileHandle(forWritingAtPath: filePath) else {
      return nil
    }
    self.outputHandle = outputHandle
  }
  
  public func log(message: String) {
    if let data = (currentTime()+message).dataUsingEncoding(NSUTF8StringEncoding) {
      self.outputHandle.writeData(data)
    }
  }
  
  
  private let outputHandle : NSFileHandle
  private let startDate = NSDate()
  
  private func currentTime() -> String {
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.dateFormat = "HH:mm:ss:SSS"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")
    
    return dateFormatter.stringFromDate(NSDate(timeInterval: 0, sinceDate: startDate))
  }
  
  private static func createFilePath(fileName: String, joinDate: Bool) -> String? {
    guard let documentDirectory = SIALogDocumentsFileOutput.documentsDirectory() else {
      return nil
    }
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd_HHmmss";
    dateFormatter.timeZone = NSTimeZone(name: "UTC")
    
    return documentDirectory+"/"+fileName+"_"+dateFormatter.stringFromDate(NSDate())+".log"
  }
  
  private static func documentsDirectory() -> String? {
    let directory = NSSearchPathDirectory.DocumentDirectory;
    let domainMask = NSSearchPathDomainMask.AllDomainsMask;
    
    guard let dir = NSSearchPathForDirectoriesInDomains(directory, domainMask, true).first else {
      return nil
    }
    return dir
  }
}