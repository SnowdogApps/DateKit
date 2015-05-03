//
//  OperationGettersSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 03/05/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class OperationGettersExampleConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("operation getters setters") { (sharedExampleContext: SharedExampleContext) in
            var configDict = sharedExampleContext() as! [String: AnyObject]
            
            let operation = configDict["operation"] as! Operation
            let value = configDict["value"] as! Int
            let getterString = configDict["getter"] as! String
            
            var resultOperation: Operation? = operation.getterOperationByString(getterString)
            
            it("should not return nil") {
                expect(resultOperation).notTo(beNil())
            }
            
            describe("operation properties") {
                itBehavesLike("operation properties tests") {
                    [
                        "operation": resultOperation!,
                        "value": value,
                        "date": operation.date,
                        "unit": operation.unit.rawValue
                    ]
                }
            }
        }
    }
}
