//
//  NSDateComparisonSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 29/04/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class NSDateComparisonSharedConfiguration: QuickConfiguration {
    
    override class func configure(configuration: Configuration) {
        sharedExamples("Date comparison") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]
            
            var lhs: NSDate!
            var rhs: NSDate!
            
            var units = (configDict["units"] as! [UInt]).map { NSCalendarUnit($0) }
            
            let originalDate = configDict["original"] as! NSDate
            let modifiedDate = configDict["modified"] as! NSDate
            
            describe("for same dates") {
                beforeEach {
                    lhs = originalDate
                    rhs = originalDate.copy() as! NSDate
                }
                
                it("should be equal") {
                    var result = lhs.compare(toDate: rhs, byUnits: units).same
                    expect(result).to(beTrue())
                }
            }
            
            describe("for different dates") {
                beforeEach {
                    lhs = originalDate
                    rhs = modifiedDate
                }
                
                it("should not be equal") {
                    var result = lhs.compare(toDate: rhs, byUnits: units).same
                    expect(result).notTo(beTrue())
                }
            }
        }
    }
}
