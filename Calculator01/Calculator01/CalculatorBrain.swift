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
  
  private enum Op: Printable {
    case Operand(Double)
    case UnaryOperation(String, Double -> Double)
    case BinaryOperation(String, (Double, Double) -> Double)
    
    var description: String {
      
      get {
        switch self {
        case .Operand(let operand):
          return "\(operand)"
        case .UnaryOperation(let symbol, _):
          return symbol
        case .BinaryOperation(let symbol, _):
          return symbol

        }
      }
    }
    
    
  }
  
  private var opStack = [Op]()
  
  private var knownOps = [String:Op]()
  
  init() {
    knownOps["×"] = Op.BinaryOperation("×", *)
    knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
    knownOps["+"] = Op.BinaryOperation("+", +)
    knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
    knownOps["√"] = Op.UnaryOperation("√", sqrt)
    knownOps["sin"] = Op.UnaryOperation("sin", sin)
    knownOps["cos"] = Op.UnaryOperation("cos", cos)

    // knownOps["π"] = Op.UnaryOperation("π", {$0 * M_PI})
  }
  
  
  private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
    
    if !ops.isEmpty {
      var remainingOps = ops
      let op = remainingOps.removeLast()
      
      switch op {
      case .Operand(let operand):
        return (operand, remainingOps)
        
      case .UnaryOperation(_, let operation):
        let operandEvaluation = evaluate(remainingOps)
        if let operand = operandEvaluation.result
        {
          return (operation(operand), operandEvaluation.remainingOps)
        }
        
      case .BinaryOperation(_, let operation):
        let op1Evaluation = evaluate(remainingOps)
        if let operand1 = op1Evaluation.result {
          let op2Evaluation = evaluate(op1Evaluation.remainingOps)
          if let operand2 = op2Evaluation.result
          {
            return (operation(operand1, operand2), op2Evaluation.remainingOps)
          }
        }

      }
      
    }
    
    return (nil, ops)
    
  }
  
  func history() -> String
  {
    var returnValue = ""
    if opStack.count > 1
    {
      var separator = " "
      var values = [String]()
      
      for op in opStack {
        values.append(op.description)
      }
      
      let joined = separator.join(values)
      returnValue = "\(joined)"
    }
    
    return returnValue
  }
  
  func evaluate() ->Double? {
    let (result, remainder) = evaluate(opStack)
    println("\(opStack) = \(result) with \(remainder) left over")
    // if 
    if(remainder.count == 0)
    {
      
    }
    return result
  }
  
  
  func pushOperand(operand: Double) -> Double? {
    opStack.append(Op.Operand(operand))
    return evaluate()
  }
  
  // TODO return tuple
  func performOperation(symbol: String) -> Double? {
    if let operation = knownOps[symbol] {
      opStack.append(operation)
    }
    return evaluate()
  }
  
  func changeAlgebraicSign(operand: Double) ->Double?
  {
    return operand * -1
  }
  
  func reset() {
    // assumed not needed here: opStack = nil
    opStack = [Op]()
    evaluate()
  }
  
}