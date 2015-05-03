//
//  OperationSpecExtensions.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 29/04/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Foundation

internal extension Operation {
    
    func mathOperationByString(operation: String, value: Int) -> Operation {
        switch operation {
        case "add": return add(value)
        case "substract": return substract(value)
        default: return self
        }
    }
    
    func getterOperationByString(getter: String) -> Operation {
        switch getter {
        case "seconds": return seconds
        case "minutes": return minutes
        case "hours":   return hours
        case "days":    return days
        case "months":  return months
        case "years":   return years
        case "eras":    return eras
        default:        return self
        }
    }
    
    func resultingValue(operation: String, value: Int) -> Int {
        switch operation {
        case "add": return self.value + value
        case "substract": return self.value - value
        default: return self.value
        }
    }
    
    func resultingDate(operation: String, value: Int) -> NSDate {
        switch operation {
        case "add":     return date.setComponent(unit, value: self.value + value)
        case "substract":   return date.setComponent(unit, value: self.value - value)
        default: return self.date
        }
    }
    
    func resultDateForHelperString(helperString: String) -> NSDate {
        switch helperString {
        case "first":   return first
        case "last":    return last
        default: return date
        }
    }
}
