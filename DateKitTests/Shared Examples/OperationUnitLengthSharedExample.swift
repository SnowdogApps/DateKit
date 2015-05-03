//
//  OperationUnitLengthSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 03/05/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class OperationUnitLengthExampleConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("unit length") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]
            
            let date = configDict["date"] as! NSDate
            let unit = configDict["unit"] as! UInt
            let expectedLength = (configDict["length"] as! NSNumber).integerValue
            let operation: Operation = Operation(value: 0, date: date, unit: NSCalendarUnit(unit))
            
            var resultLength = operation.length
            
            it("should be non-negative") {
                expect(resultLength).notTo(beLessThan(0))
            }
            
            it("should be correct") {
                expect(resultLength).to(equal(expectedLength))
            }
        }
    }
}
