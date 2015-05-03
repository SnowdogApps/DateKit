//
//  NSDateHelperSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 29/04/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class NSDateHelperSharedConfiguration: QuickConfiguration {
    
    override class func configure(configuration: Configuration) {
        sharedExamples("Date helper") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]
            
            let helperString: String = configDict["helper"] as! String
            let debug: Bool? = configDict["debug"] as! Bool?
            let baseDate: NSDate = configDict["baseDate"] as! NSDate
            let referenceDate: NSDate = configDict["referenceDate"] as! NSDate
            
            var resultDate: NSDate!
            
            beforeEach { resultDate = baseDate.dateFromHelpersString(helperString) }
            
            it("should be equal to reference date") {
                expect(resultDate).to(equal(referenceDate))
            }
        }
    }
}
