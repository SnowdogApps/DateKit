//
//  NSDateExtensions.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 11.12.2014.
//  Copyright (c) 2014 Radosław Szeja. All rights reserved.
//

import Foundation


// MARK: NSDate Literal Getters
extension NSDate: DateKitLiteralGetters {
    public var second       : Int { get { return components.second } }
    public var minute       : Int { get { return components.minute } }
    public var hour         : Int { get { return components.hour } }
    public var day          : Int { get { return components.day } }
    public var weekday      : Int { get { return components.weekday } }
    public var month        : Int { get { return components.month } }
    public var year         : Int { get { return components.year } }
    public var era          : Int { get { return components.era } }
}



// MARK: NSDate Operation Getters
extension NSDate: DateKitOperationGetters {
    public var seconds:  Operation { get { return dateOperation(.CalendarUnitSecond) } }
    public var minutes:  Operation { get { return dateOperation(.CalendarUnitMinute) } }
    public var hours:    Operation { get { return dateOperation(.CalendarUnitHour) } }
    public var days:     Operation { get { return dateOperation(.CalendarUnitDay) } }
    public var months:   Operation { get { return dateOperation(.CalendarUnitMonth) } }
    public var years:    Operation { get { return dateOperation(.CalendarUnitYear) } }
    public var eras:     Operation { get { return dateOperation(.CalendarUnitEra) } }
}



// MARK: NSDate Operation Setters
extension NSDate: DateKitOperationSetters {
    public func second(value: Int)  -> Operation { return setDateOperation(.CalendarUnitSecond, value: value) }
    public func minute(value: Int)  -> Operation { return setDateOperation(.CalendarUnitMinute, value: value) }
    public func hour(value: Int)    -> Operation { return setDateOperation(.CalendarUnitHour, value: value) }
    public func day(value: Int)     -> Operation { return setDateOperation(.CalendarUnitDay, value: value) }
    public func month(value: Int)   -> Operation { return setDateOperation(.CalendarUnitMonth, value: value) }
    public func year(value: Int)    -> Operation { return setDateOperation(.CalendarUnitYear, value: value) }
    public func era(value: DateKit.Era)     -> Operation { return setDateOperation(.CalendarUnitEra, value: value.rawValue) }
}


extension NSDate {
    public func compare(toDate date: NSDate, byUnits units: [NSCalendarUnit] = [.CalendarUnitDay, .CalendarUnitMonth, .CalendarUnitYear]) -> NSComparisonResult {
        
        var comparisonResult: NSComparisonResult
        var calendarUnit: NSCalendarUnit = self.calendarUnit(units)
        var firstComponents = DateKit.calendar.components(calendarUnit, fromDate: self)
        var secondComponents = DateKit.calendar.components(calendarUnit, fromDate: date)
    
        for unit: NSCalendarUnit in units {
            let unitString = unit.string()
            var firstComponentValue: Int = firstComponents.valueForKey(unitString) as Int!
            var secondComponentValue: Int = secondComponents.valueForKey(unitString) as Int!
            
            if firstComponentValue != secondComponentValue {
                return self.compare(date)
            }
        }
        
        return .OrderedSame
    }

//    private func calendarUnit(unitsArray: [NSCalendarUnit]) -> NSCalendarUnit {
//        if unitsArray.count <= 0 { return nil }
//        var units: UInt = (unitsArray.first as NSCalendarUnit!).rawValue
//        
//        var count = unitsArray.count
//        var shorterUnitsArray: [NSCalendarUnit] = Array(unitsArray[1..<count])
//        
//        for unit: NSCalendarUnit in shorterUnitsArray {
//            units |= unit.rawValue
//        }
//        
//        return NSCalendarUnit(units)
//    }
}

extension NSDate {
    public var components: NSDateComponents { get { return DateKit.calendar.components(self) } }
    
    public func components(component: NSCalendarUnit) -> NSDateComponents {
        return DateKit.calendar.components(component, fromDate: self)
    }
    
    internal func setComponent(component: NSCalendarUnit, value: Int!) -> NSDate? {
        var components = self.components(NSCalendarUnit(UInt.max))
        components.calendar = DateKit.calendar
        
        if component == .CalendarUnitYearForWeekOfYear || component == .CalendarUnitYear {
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYearForWeekOfYear.string())
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYear.string())
        } else {
            components.setValue(value, forKey: component.string())
        }
        
        var date = DateKit.calendar.dateFromComponents(components)
        var componentString = component.string()
        
        return date
    }
}

//enum DateKitUnit: String {
//    case Nanosecond = "nanosecond"
//    case Second = "second"
//    case Minute = "minute"
//    case Hour = "hour"
//    case Day = "day"
//    case Month = "month"
//    case Year = "year"
//    case Era = "era"
//    case Weekday = "weekday"
//    case WeekdayOrdinal = "weekdayOrdinal"
//    case Quarter = "quarter"
//    case WeekOfMonth = "weekOfMonth"
//    case WeekOfYear = "weekOfYear"
//    case YearForWeekOfYear = "yearForWeekOfYear"
//    case NoUnit = ""
//}
//
//extension NSCalendarUnit {
//    internal func dateKitUnit() -> DateKitUnit {
//        switch self {
//        case NSCalendarUnit.CalendarUnitNanosecond:     return .Nanosecond
//        case NSCalendarUnit.CalendarUnitSecond:         return .Second
//        case NSCalendarUnit.CalendarUnitMinute:         return .Minute
//        case NSCalendarUnit.CalendarUnitHour:           return .Hour
//        case NSCalendarUnit.CalendarUnitDay:            return .Day
//        case NSCalendarUnit.CalendarUnitMonth:          return .Month
//        case NSCalendarUnit.CalendarUnitYear:           return .Year
//        case NSCalendarUnit.CalendarUnitEra:            return .Era
//        case NSCalendarUnit.CalendarUnitWeekday:        return .Weekday
//        case NSCalendarUnit.CalendarUnitWeekdayOrdinal: return .WeekdayOrdinal
//        case NSCalendarUnit.CalendarUnitQuarter:        return .Quarter
//        case NSCalendarUnit.CalendarUnitWeekOfMonth:    return .WeekOfMonth
//        case NSCalendarUnit.CalendarUnitWeekOfYear:     return .WeekOfYear
//        case NSCalendarUnit.CalendarUnitYearForWeekOfYear: return .YearForWeekOfYear
//        default: return .NoUnit
//        }
//    }
//    
//    func string() -> String {
//        return self.dateKitUnit().rawValue
//    }
//}

//extension DateKitUnit {
//    internal func calendarUnit() -> NSCalendarUnit {
//        switch self {
//        case .Nanosecond:       return .CalendarUnitNanosecond
//        case .Second:           return .CalendarUnitSecond
//        case .Minute:           return .CalendarUnitMinute
//        case .Hour:             return .CalendarUnitHour
//        case .Day:              return .CalendarUnitDay
//        case .Month:            return .CalendarUnitMonth
//        case .Year:             return .CalendarUnitYear
//        case .Era:              return .CalendarUnitEra
//        case .Weekday:          return .CalendarUnitWeekday
//        case .WeekdayOrdinal:   return .CalendarUnitWeekdayOrdinal
//        case .Quarter:          return .CalendarUnitQuarter
//        case .WeekOfMonth:      return .CalendarUnitWeekOfMonth
//        case .WeekOfYear:       return .CalendarUnitWeekOfYear
//        case .YearForWeekOfYear: return .CalendarUnitYearForWeekOfYear
//        default:            return NSCalendarUnit(UInt.max)
//        }
//    }
//}

//extension String {
//    internal func dateKitUnit() -> DateKitUnit? {
//        return DateKitUnit(rawValue: self)
//    }
//}

extension NSDate {
//    public func nanoseconds()  -> Int { return self.components().nanosecond }
//    public func seconds()      -> Int { return self.components().second }
//    public func minutes()      -> Int { return self.components().minute }
//    public func hours()        -> Int { return self.components().hour }
//    public func day()          -> Int { return self.components().day }
//    public func month()        -> Int { return self.components().month }
//    public func year()         -> Int { return self.components().year }
//    public func era()          -> Int { return self.components().era }
//    public func weekday()      -> Int { return self.components().weekday }
//    public func weekdayOrdinal() -> Int { return self.components().weekdayOrdinal }
//    public func quarter()      -> Int { return self.components().quarter }
//    public func weekOfMonth()  -> Int { return self.components().weekOfMonth }
//    public func weekOfYear()   -> Int { return self.components().weekOfYear }
//    public func yearForWeekOfYear() -> Int { return self.components().yearForWeekOfYear }
    
    public func nanoseconds(nns: Int!)  -> NSDate? { return self.setComponent(.CalendarUnitNanosecond, value: nns) }
    public func seconds(sec: Int!)      -> NSDate? { return self.setComponent(.CalendarUnitSecond, value: sec) }
    public func minutes(min: Int!)      -> NSDate? { return self.setComponent(.CalendarUnitMinute, value: min) }
    public func hours(hrs: Int!)        -> NSDate? { return self.setComponent(.CalendarUnitHour, value: hrs) }
    public func day(dd: Int!)           -> NSDate? { return self.setComponent(.CalendarUnitDay, value: dd) }
    public func month(mm: Int!)         -> NSDate? { return self.setComponent(.CalendarUnitMonth, value: mm) }
    public func year(yy: Int!)          -> NSDate? { return self.setComponent(.CalendarUnitYear, value: yy) }
    public func era(ee: Int!)           -> NSDate? { return self.setComponent(.CalendarUnitEra, value: ee) }
    public func weekday(wd: Int!)       -> NSDate? { return self.setComponent(.CalendarUnitWeekday, value: wd) }
    public func weekdayOrdinal(wdo: Int!) -> NSDate? { return self.setComponent(.CalendarUnitWeekdayOrdinal, value: wdo) }
    public func quarter(q: Int!)        -> NSDate? { return self.setComponent(.CalendarUnitQuarter, value: q) }
    public func weekOfMonth(wom: Int!)  -> NSDate? { return self.setComponent(.CalendarUnitWeekOfMonth, value: wom) }
    public func weekOfYear(woy: Int!)   -> NSDate? { return self.setComponent(.CalendarUnitWeekOfYear, value: woy) }
    public func yearForWeekOfYear(yy: Int!) -> NSDate? { return self.setComponent(.CalendarUnitYearForWeekOfYear, value: yy) }
}

// MARK: Day helpers
extension NSDate {
    public var midnight: NSDate {
        get { return (self.hour(0).minute(0).second(0) as Operation).date }
    }
    
    public var noon: NSDate {
        get { return (self.hour(12) as Operation).minute(0).second(0).date }
    }
    
    public var yesterday:   NSDate { get { return self.days - 1 } }
    public var tomorrow:    NSDate { get { return self.days + 1 } }
}

extension NSDate {
    public func between(#earlier: NSDate, later: NSDate) -> Bool {
        var descendingResult = self.compare(earlier).notAscending
        var ascendingResult = self.compare(later).notDescending
        return (ascendingResult && descendingResult)
    }
}


// MARK: NSDate Operators
extension NSDate: Comparable, Equatable {}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}
public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}

public func <= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) != NSComparisonResult.OrderedDescending
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
}

public func >= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) != NSComparisonResult.OrderedAscending
}
