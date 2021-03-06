//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by gjwang on 4/13/15.
//  Copyright (c) 2015 gjwang. All rights reserved.
//

import Foundation

class CalculatorBrain{
    private enum Op: Printable{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinayOperation(String, (Double, Double) -> Double)
    
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .BinayOperation(let symbol, _):
                    return symbol
                case .UnaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }

    
    
    private var opStack = [Op]()
    
    private var knownOps = [String: Op]()
    
    init(){
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinayOperation("x", *))
        knownOps["x"] = Op.BinayOperation("x", *)
        knownOps["÷"] = Op.BinayOperation("÷") {$0 / $1}
        knownOps["+"] = Op.BinayOperation("+", +)
        knownOps["-"] = Op.BinayOperation("-") {$0 - $1}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)

    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation =  evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinayOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remaider) = evaluate(opStack)
        println("\(opStack) = \(result) \(remaider) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}
