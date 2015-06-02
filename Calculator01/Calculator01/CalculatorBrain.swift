//
//  CalculatorBrain.swift
//  Calculator01
//
//  Created by Karsten Gresch on 02.06.15.
//  Copyright (c) 2015 Closure One. All rights reserved.
//

import Foundation

class CalculatorBrain
{
  
  enum Op {
   case Operand(Double)
   case UnaryOperation(String, Double -> Double)
    case BinaryOperation(String, (Double, Double) -> Double)
  }
  
  var opStack = [Op]()
  
  init() {
    knownOps["×"] = Op.BinaryOperation("×", *)
    knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
    knownOps["+"] = Op.BinaryOperation("+", +)
    knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
    knownOps["√"] = Op.UnaryOperation("√", sqrt)
  }
  
  
  func pushOperand(operand: Double) {
    opStack.append(Op.Operand(operand))
  }
  
  var knownOps = [String:Op]()
  
  func performOperation(symbol: String) {
    if let operation = knownOps[symbol] {
      opStack.append(operation)
    }
    
  }
  
  
}