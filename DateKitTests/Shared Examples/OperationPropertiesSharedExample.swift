//
//  OperationPropertiesSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 03/05/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class OperationPropertiesExampleConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("operation properties tests") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]
            
            let operation = configDict["operation"] as! Operation
            let value = configDict["value"] as! Int
            let date = configDict["date"] as! NSDate
            let unitRawValue = configDict["unit"] as! UInt
            
            it("should have exactly same value as passed in initialization") {
                expect(operation.value).to(equal(value))
            }
            
            it("should have exactly same date as passed in initialization") {
                expect(operation.date).to(equal(date))
            }
            
            it("should have exactly same unit as passed in initialization") {
                expect(operation.unit.rawValue).to(equal(unitRawValue))
            }
        }
    }
}
