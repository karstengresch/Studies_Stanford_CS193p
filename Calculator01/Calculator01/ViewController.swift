//
//  ViewController.swift
//  Calculator01
//
//  Created by Karsten Gresch on 27.05.15.
//  Copyright (c) 2015 Closure One. All rights reserved.
//

import UIKit


extension String
{
  func substring(fromPos start: Int, withLength length: Int) -> String
  {
    if length > 0
    {
      return self[advance(self.startIndex, start)..<advance(self.startIndex, start+length)]
    }
    else
    {
      return self[advance(self.startIndex, start+length)..<advance(self.startIndex, start)]
    }
  }
}





class ViewController: UIViewController {
  
  
  @IBOutlet weak var display: UILabel!
  
  var userIsInTheMiddleOfTypingANumber = false
  
  var brain = CalculatorBrain()
  
  var displayValue: Double {
    get {
      
      // println("display text: \(display.text)")
      var returnValue = 0.0
      
      if let displayValue = display.text {
        var checkValue = displayValue
        if checkValue == "π" { checkValue = "\(M_PI)"  }
      //   else if checkValue.rangeOfString("π")
        
        
        returnValue = NSNumberFormatter().numberFromString(checkValue)!.doubleValue
       }

   

    return returnValue
    }
    
    set {
      display.text = "\(newValue)"
      userIsInTheMiddleOfTypingANumber = false
    }
  }
  
  
  @IBAction func appendDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTypingANumber {
      
      if let displayTypedValue = display.text
      {
        // not so readable, but one-liner. Doesn't cover initial
        var nonInitialValue = displayTypedValue + ( (digit != ".") ? digit : ( (!(displayTypedValue.rangeOfString(".") != nil) ) ? digit : "") )
        if nonInitialValue.hasSuffix("π") {
          if userIsInTheMiddleOfTypingANumber
          {
            nonInitialValue = nonInitialValue.substring(fromPos: 0, withLength: count(nonInitialValue) - 2)
            enter()
            nonInitialValue = "\(M_PI)"
            enter()
          }
          else
          {
           nonInitialValue = "\(M_PI)"
          }
        }
        display.text = nonInitialValue
      }
    } else {
      var initialValue = digit
      if initialValue == "." { initialValue = "0." }
      if initialValue == "π" { initialValue = "\(M_PI)" }
      display.text = initialValue
      userIsInTheMiddleOfTypingANumber = true
    }
  }
  
  @IBAction func operate(sender: UIButton) {
    
    if userIsInTheMiddleOfTypingANumber
    {
      enter()
    }
    
    if let operation = sender.currentTitle {
      if let result = brain.performOperation(operation) {
        displayValue = result
      } else {
        displayValue = 0
      }
    }
  }
  
  @IBAction func enter() {
    userIsInTheMiddleOfTypingANumber = false
    if let result = brain.pushOperand(displayValue) {
      displayValue = result
    } else {
      displayValue = 0
    }
  }
}