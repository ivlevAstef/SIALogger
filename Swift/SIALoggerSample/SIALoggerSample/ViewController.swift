//
//  ViewController.swift
//  SIALoggerSample
//
//  Created by Alexander Ivlev on 31/05/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import UIKit
import SIALogger

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    SIALogConfig.maxLogLevel = SIALogLevel.Info
    SIALog.Trace("1 trace no show")
    SIALog.Info("1 info")
    SIALog.Warning("1 warning")
    SIALog.Error("1 error")
    
    SIALogConfig.maxLogLevel = SIALogLevel.Error
    SIALog.Trace("2 trace no show")
    SIALog.Info("2 info no show")
    SIALog.Warning("2 warning no show")
    SIALog.Error("2 error")
    
    SIALogConfig.maxLogLevel = SIALogLevel.Trace
    SIALog.Trace("3 trace")
    
    SIALog.Trace("4 trace")
    SIALog.Info("4 info")
    SIALog.Warning("4 warning")
    SIALog.Error("4 error")
    
    
    SIALog.TraceIf(true, msg: "Trace if")
    SIALog.InfoIf(false, msg: "Info if no show")
    SIALog.WarningIf(true, msg: "Warning if")
    SIALog.ErrorIf(false, msg: "Error if no show")
    
    if (SIALog.TraceIf(false, msg: "Trace if no show")) {
      SIALog.Info("By trace no show")
    }
    
    if (SIALog.InfoIf(true, msg: "Info if")) {
      SIALog.Info("By info")
    }
    
    if (SIALog.WarningIf(false, msg: "Warning if no show")) {
      SIALog.Info("By warning no show")
    }
    
    if (SIALog.ErrorIf(true, msg: "Error if")) {
      SIALog.Info("By error")
    }
    
    SIALog.Assert(true, msg: "no show")
    SIALog.Assert(false, msg: "assert")
  }
}

