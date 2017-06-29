//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jonathan Deng on 6/28/17.
//  Copyright © 2017 Jonathan Deng. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    // read-only property
    var result: Double? {
        get {
            return accumulator
        }
    }

    private var accumulator: Double?
    private enum Operation {
        // enum case with associated value
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    private var operations: Dictionary<String, Operation> = [
      "pi": Operation.constant(Double.pi),
      "e": Operation.constant(M_E),
      "sqrt": Operation.unaryOperation(sqrt),
      "cos": Operation.unaryOperation(cos),
      "change-sign": Operation.unaryOperation({ -$0 }),
      // swift's closure/ a lambda function that multiplies first 2 arguments
      "x": Operation.binaryOperation({ $0 * $1 }),
      "-": Operation.binaryOperation({ $0 - $1 }),
      "=": Operation.equals
    ]
    private var pendingBinaryOperation: PendingBinaryOperation?

    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let operation):
                if let const = accumulator {
                   accumulator = operation(const)
                }
            case .binaryOperation(let operation):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: operation, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }

}
