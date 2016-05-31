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
    
    Config.maxLogLevel = Level.Info
    Log.Trace("1 trace no show")
    Log.Info("1 info")
    Log.Warning("1 warning")
    Log.Error("1 error")
    
    Config.maxLogLevel = Level.Error
    Log.Trace("2 trace no show")
    Log.Info("2 info no show")
    Log.Warning("2 warning no show")
    Log.Error("2 error")
    
    Config.maxLogLevel = Level.Trace
    Log.Trace("3 trace")
    
    Config.formatFunction = { (level, file, line, msg) in " ["+level.uppercaseString+"] {"+file+":"+String(line)+"}: "+msg }
    
    Log.Trace("4 trace")
    Log.Info("4 info")
    Log.Warning("4 warning")
    Log.Error("4 error")
    
    
    Log.TraceIf(true, msg: "Trace if")
    Log.InfoIf(false, msg: "Info if no show")
    Log.WarningIf(true, msg: "Warning if")
    Log.ErrorIf(false, msg: "Error if no show")
    
    if (Log.TraceIf(false, msg: "Trace if no show")) {
      Log.Info("By trace no show")
    }
    
    if (Log.InfoIf(true, msg: "Info if")) {
      Log.Info("By info")
    }
    
    if (Log.WarningIf(false, msg: "Warning if no show")) {
      Log.Info("By warning no show")
    }
    
    if (Log.ErrorIf(true, msg: "Error if")) {
      Log.Info("By error")
    }
    
    Log.Assert(true, msg: "no show")
    
    Log.Assert(false, msg: "assert")
    
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

