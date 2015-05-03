//
//  NSDateComponentSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 29/04/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class NSDateComponentSharedConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("component") { (sharedExampleContext: SharedExampleContext) in
            var configurationDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]
            
            var referenceDate: NSDate!
            var testDate: NSDate!
            
            let unit = configurationDict["unit"] as! UInt
            let value = configurationDict["value"] as! Int
            
            beforeEach {
                let originDate = NSDate(timeIntervalSince1970: 0)
                referenceDate = originDate.mock_referenceDate(NSCalendarUnit(unit), value: value)
                testDate = originDate.setRawComponent(unit, value: value)
            }
            
            it("should not be nil") {
                expect(testDate).notTo(beNil())
            }
            
            it("should have correct \(NSCalendarUnit(unit).string())") {
                var result = referenceDate.compare(testDate).same
                expect(result).to(beTrue())
            }
            
            it("should get correct seconds") {
                var result = testDate.component(unit)
                expect(result).to(equal(value))
            }
        }
    }
}
