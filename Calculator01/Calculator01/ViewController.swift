//
//  ViewController.swift
//  Calculator01
//
//  Created by Karsten Gresch on 27.05.15.
//  Copyright (c) 2015 Closure One. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


  @IBOutlet weak var display: UILabel!
  
  var userIsInTheMiddleOfTypingANumber = false
  
  

  @IBAction func appendDigit(sender: UIButton) {
//    if let digit = sender.currentTitle
//    {
//      if let displayValue = display.text
//      {
//          if displayValue == "0"
//          {
//              display.text = digit
//          }
//          else
//          {
//              display.text = displayValue + digit
//        }
//      }
//      else
//      {
//        display.text = digit
//      }
//    } else
//    {
//      println("no value for digit!")
//    }
    
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTypingANumber {
      display.text = display.text! + digit
    } else {
      display.text = digit
      userIsInTheMiddleOfTypingANumber = true
    }
  
}
  
  var operandStack = Array<Double>()
  

  @IBAction func enter() {
    userIsInTheMiddleOfTypingANumber = false
    
  }
  
  
}