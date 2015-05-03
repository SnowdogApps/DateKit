//
//  NSDateSpecExtensions.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 29/04/15.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Foundation
import DateKit

internal extension NSDate {
    
    func setRawComponent(component: UInt!, value: Int!) -> NSDate? {
        var unit: DateKit.Unit = NSCalendarUnit(component).dateKitUnit()
        
        switch unit {
        case .Second:       return (second(value) as Operation).date
        case .Minute:       return (minute(value) as Operation).date
        case .Hour:         return (hour(value) as Operation).date
        case .Day:          return (day(value) as Operation).date
        case .Month:        return (month(value) as Operation).date
        case .Year:         return (year(value) as Operation).date
        case .Era:          return (era(DateKit.Era(integerLiteral: value)) as Operation).date
        default: return self
        }
    }
    
    func component(component: UInt!) -> Int {
        var unit: DateKit.Unit = NSCalendarUnit(component).dateKitUnit()
        
        switch unit {
        case .Second:       return second
        case .Minute:       return minute
        case .Hour:         return hour
        case .Day:          return day
        case .Month:        return month
        case .Year:         return year
        case .Era:          return era
        default: return -1
        }
    }
}

internal extension NSDate {
    
    func mock_referenceDate(unit: NSCalendarUnit, value: Int) -> NSDate? {
        var components = self.components
        
        if unit == .CalendarUnitYear || unit == .CalendarUnitYearForWeekOfYear {
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYear.string())
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYearForWeekOfYear.string())
        } else {
            components.setValue(value, forKey: unit.string())
        }
        
        return DateKit.calendar.dateFromComponents(components)
    }
}

internal extension NSDate {
    func dateFromHelpersString(helperString: String) -> NSDate {
        switch helperString {
        case "midnight":    return midnight
        case "noon":        return noon
        case "yesterday":   return yesterday
        case "tomorrow":    return tomorrow
        default:            return self
        }
    }
}
