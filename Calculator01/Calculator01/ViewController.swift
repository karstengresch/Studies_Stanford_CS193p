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
  
  @IBAction func operate(sender: UIButton) {
    
    let operation = sender.currentTitle!

    if userIsInTheMiddleOfTypingANumber
    {
      enter()
    }
    
    switch operation
    {
      case "×":
      if operandStack.count >= 2
      {
        displayValue = operandStack.removeLast() * operandStack.removeLast()
        enter()
      }
      
      
//      case "÷":
//      case "+":
//      case "−":
    default: break
    }
  
  
  }
  
  var operandStack = Array<Double>()
  

  @IBAction func enter() {
    userIsInTheMiddleOfTypingANumber = false
    operandStack.append(displayValue)
    println("operandStack = \(operandStack)")
  }
  
  var displayValue: Double {
    get {
      return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
    }
    
    set {
      display.text = "\(newValue)"
      userIsInTheMiddleOfTypingANumber = false
    }
    
    
  }
  
  
}