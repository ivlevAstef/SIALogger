//
//  SIALogColor.swift
//  SIALogger
//
//  Created by Alexander Ivlev on 03/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import Foundation

public class SIALogColor {
  public let xcodeColor : String
  
  public required init(_ red : UInt8, _ green : UInt8, _ blue: UInt8) {
    xcodeColor = String(red)+","+String(green)+","+String(blue)+";";
  }
}