//
//  OperationHelpersForUnitSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 03/05/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class OperationHelpersForUnitExampleConfiguration : QuickConfiguration {
    
    override class func configure(configuration: Configuration) {
        sharedExamples("operation helper for unit") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]
            
            let unit = configDict["unit"] as! UInt
            let value = configDict["value"] as! Int
            let date = configDict["date"] as! NSDate
            let helperString = configDict["helper"] as! String
            
            var operation = Operation(value: value, date: date, unit: NSCalendarUnit(unit))
            var referenceDate: NSDate = date.setComponent(NSCalendarUnit(unit), value: value)
            var helperDate = operation.resultDateForHelperString(helperString)
            
            it("should not be nil") {
                expect(helperDate).notTo(beNil())
            }
            
            it("should be equal to reference date") {
                expect(helperDate == referenceDate).to(beTrue())
            }
        }
    }
}
