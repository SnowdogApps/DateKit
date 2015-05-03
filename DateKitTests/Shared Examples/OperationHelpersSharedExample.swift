//
//  OperationHelpersSharedExample.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 03/05/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Nimble
import Quick

class OperationHelpersExampleConfiguration : QuickConfiguration {
    class func valueForHelper(helperString: String, unit: DateKit.Unit) -> Int {
        if helperString == "first" {
            return valueForFirstHelper(unit)
        } else if helperString == "last" {
            return valueForLastHelper(unit)
        }
        
        return 0
    }
    
    class func valueForFirstHelper(unit: DateKit.Unit) -> Int {
        switch unit {
        case .Day:      fallthrough
        case .Month:    return 1
        default:        return 0
        }
    }
    
    class func valueForLastHelper(unit: DateKit.Unit) -> Int {
        switch unit {
        case .Second:   fallthrough
        case .Minute:   return 59
        case .Hour:     return 23
        case .Day:      return NSCalendarUnit.CalendarUnitMonth.length(forDate: NSDate())
        case .Month:    return 12
        default:        return 0
        }
    }
    
    override class func configure(configuration: Configuration) {
        sharedExamples("operation helper") { (sharedExampleContext: SharedExampleContext) in
            var configuration = sharedExampleContext() as! [String: AnyObject]
            var helper = configuration["helper"] as! String
            
            describe("second") {
                var localConfiguration: [String: AnyObject] = configuration
                
                itBehavesLike("operation helper for unit") {
                    localConfiguration["unit"] = NSCalendarUnit.CalendarUnitSecond.rawValue
                    localConfiguration["value"] = self.valueForHelper(helper, unit: .Second)
                    return localConfiguration
                }
            }
            
            describe("minute") {
                var localNotification: [String: AnyObject] = configuration
                itBehavesLike("operation helper for unit") {
                    localNotification["unit"] = NSCalendarUnit.CalendarUnitMinute.rawValue
                    localNotification["value"] = self.valueForHelper(helper, unit: .Minute)
                    return localNotification
                }
            }
            
            describe("hour") {
                var localConfiguration: [String: AnyObject] = configuration
                itBehavesLike("operation helper for unit") {
                    localConfiguration["unit"] = NSCalendarUnit.CalendarUnitHour.rawValue
                    localConfiguration["value"] = self.valueForHelper(helper, unit: .Hour)
                    return localConfiguration
                }
            }
            
            describe("day") {
                var localConfiguration: [String: AnyObject] = configuration
                itBehavesLike("operation helper for unit") {
                    localConfiguration["unit"] = NSCalendarUnit.CalendarUnitDay.rawValue
                    localConfiguration["value"] = self.valueForHelper(helper, unit: .Day)
                    return localConfiguration
                }
            }
            
            describe("month") {
                var localConfiguration: [String: AnyObject] = configuration
                itBehavesLike("operation helper for unit") {
                    localConfiguration["unit"] = NSCalendarUnit.CalendarUnitMonth.rawValue
                    localConfiguration["value"] = self.valueForHelper(helper, unit: .Month)
                    return localConfiguration
                }
            }
        }
    }
}
