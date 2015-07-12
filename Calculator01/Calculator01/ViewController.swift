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
  
  var doubleValue: Double {
    if let number = NSNumberFormatter().numberFromString(self) {
      return number.doubleValue
    }
    return 0
  }
}

class ViewController: UIViewController {
  
  
  @IBOutlet weak var display: UILabel!
  
  @IBOutlet weak var historyText: UITextView!
  
  
  var userIsInTheMiddleOfTypingANumber = false
  var brain = CalculatorBrain()
  var history = ""
  
  var displayValue: Double {
    get {
      
      println("display text: \(display.text)")
      var returnValue = 0.0
      
      if let displayValue = display.text {
        var checkValue = displayValue
        if checkValue == "π" { checkValue = "\(M_PI)"  }
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
          nonInitialValue = nonInitialValue.substring(fromPos: 0, withLength: count(nonInitialValue) - 2)
          enter()
          userIsInTheMiddleOfTypingANumber = true
          nonInitialValue = "\(M_PI)"
        }
        display.text = nonInitialValue
      }
    } else {
      var initialValue = digit
      if initialValue == "." { initialValue = "0.0" }
      if initialValue == "π" { initialValue = "\(M_PI)" }
      display.text = initialValue
      userIsInTheMiddleOfTypingANumber = true
    }
  }
  

  @IBAction func deleteLastInput(sender: UIButton) {
    if let displayTypedValue = display.text
    {
      if (count(displayTypedValue) > 0 && (!(count(displayTypedValue) == 1 && displayTypedValue == "0")))
      {
        display.text = dropLast(displayTypedValue)
        if let changedValue = display.text
        {
          
        if (changedValue.rangeOfString(".") != nil)
        {
          display.text = dropLast(changedValue)
        }
        }
      }
    }
    
  }
  
  @IBAction func operate(sender: UIButton) {
    
    // TODO ugly check
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
      addToHistory(brain.history())
    }
  }
  
  
  @IBAction func changeAlgebraicSign(sender: UIButton) {
    if (userIsInTheMiddleOfTypingANumber)
    {
      if let changedValue = brain.changeAlgebraicSign(displayValue)
      {
        displayValue = changedValue
      }
    }
  }
  
  
  @IBAction func reset(sender: UIButton) {
    brain.reset()
    displayValue = 0
  }
  
  @IBAction func enter() {
    userIsInTheMiddleOfTypingANumber = false
    if let result = brain.pushOperand(displayValue) {
      displayValue = result
    } else {
      displayValue = 0
    }
    // addToHistory("\(displayValue)")
  }
  
  func addToHistory(input: String)
  {
    if(!input.isEmpty)
    {
      if (!history.isEmpty) {
        history += "\n"
      }
      history += input
    }
    
    historyText.text = history
    
  }
  
}