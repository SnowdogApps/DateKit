//
//  NSDateInternalHelpers.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 18.01.2015.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Foundation

internal extension NSDate {
    
    func calendarUnit(unitsArray: [NSCalendarUnit]) -> NSCalendarUnit {
        if unitsArray.count <= 0 { return nil }
        var units: UInt = (unitsArray.first as NSCalendarUnit!).rawValue
        
        var count = unitsArray.count
        var shorterUnitsArray: [NSCalendarUnit] = Array(unitsArray[1..<count])
        
        for unit: NSCalendarUnit in shorterUnitsArray {
            units |= unit.rawValue
        }
        
        return NSCalendarUnit(units)
    }
}

internal extension NSDate {
    
    func setComponent(component: NSCalendarUnit, value: Int!) -> NSDate {
        var components = self.components(NSCalendarUnit(UInt.max))
        components.calendar = DateKit.calendar
        
        if component == .CalendarUnitYearForWeekOfYear || component == .CalendarUnitYear {
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYearForWeekOfYear.string())
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYear.string())
        } else {
            components.setValue(value, forKey: component.string())
        }
        
        if let date = DateKit.calendar.dateFromComponents(components) {
            return date
        } else {
            return NSDate()
        }
    }
}


internal extension NSDate {
    
    func dateOperation(unit: NSCalendarUnit) -> Operation {
        return Operation(value: self.components.valueForKey(unit.string()) as! Int, date: self, unit: unit)
    }
    
    func setDateOperation(unit: NSCalendarUnit, value: Int) -> Operation {
        var resultDate: NSDate = setComponent(unit, value: value)
        return Operation(value: value, date: resultDate, unit: unit)
    }
}
