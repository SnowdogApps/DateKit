//
//  OperationMathOperationSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 03/05/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class OperationMathOperationExampleConfiguration : QuickConfiguration {
    
    override class func configure(configuration: Configuration) {
        sharedExamples("math operation") { (sharedExampleContext: SharedExampleContext) in
            
            var configuration = sharedExampleContext() as! [String: AnyObject]
            
            let operation = configuration["operation"] as! Operation
            let mathOperator = configuration["operator"] as! String
            let value = configuration["value"] as! Int
            
            var resultOperation = operation.mathOperationByString(mathOperator, value: value)
            var resultDate = operation.resultingDate(mathOperator, value: value)
            
            it("should return non-nil operation instance") {
                expect(resultOperation).notTo(beNil())
            }
            
            it("should return new operation instance") {
                expect(resultOperation).notTo(equal(operation))
            }
            
            itBehavesLike("operation properties tests") {
                [
                    "operation": resultOperation,
                    "value": operation.resultingValue(mathOperator, value: value),
                    "date": resultDate,
                    "unit": operation.unit.rawValue
                ]
            }
        }
    }
}
