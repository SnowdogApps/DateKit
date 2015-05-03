//
//  DateKit.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 10.12.2014.
//  Copyright (c) 2014 Radosław Szeja. All rights reserved.
//

import Foundation

public class DateKit {
    
    private struct Calendar {
        static var current = NSCalendar.currentCalendar()
    }
    
    public class var calendar: NSCalendar {
        get { return Calendar.current }
        set { Calendar.current = newValue }
    }
}

public extension DateKit {
    enum Era: Int, IntegerLiteralConvertible {
        public init(integerLiteral: Int) {
            self = .AC
            if integerLiteral == 0 {
                self = .BC
            }
        }
            
        case BC = 0
        case AC = 1
    }
}

extension DateKit {
    internal enum Unit: String {
        case Nanosecond = "nanosecond"
        case Second     = "second"
        case Minute     = "minute"
        case Hour       = "hour"
        case Day        = "day"
        case Month      = "month"
        case Year       = "year"
        case Era        = "era"
        case Weekday    = "weekday"
        case WeekdayOrdinal = "weekdayOrdinal"
        case Quarter    = "quarter"
        case WeekOfMonth = "weekOfMonth"
        case WeekOfYear = "weekOfYear"
        case YearForWeekOfYear = "yearForWeekOfYear"
        case NoUnit     = ""
    }
}

internal extension DateKit.Unit {
    func calendarUnit() -> NSCalendarUnit {
        switch self {
        case .Nanosecond:       return .CalendarUnitNanosecond
        case .Second:           return .CalendarUnitSecond
        case .Minute:           return .CalendarUnitMinute
        case .Hour:             return .CalendarUnitHour
        case .Day:              return .CalendarUnitDay
        case .Month:            return .CalendarUnitMonth
        case .Year:             return .CalendarUnitYear
        case .Era:              return .CalendarUnitEra
        case .Weekday:          return .CalendarUnitWeekday
        case .WeekdayOrdinal:   return .CalendarUnitWeekdayOrdinal
        case .Quarter:          return .CalendarUnitQuarter
        case .WeekOfMonth:      return .CalendarUnitWeekOfMonth
        case .WeekOfYear:       return .CalendarUnitWeekOfYear
        case .YearForWeekOfYear: return .CalendarUnitYearForWeekOfYear
        default:                return NSCalendarUnit(UInt.max)
        }
    }
    
    func string() -> String {
        return calendarUnit().string()
    }
}


// MARK: NSCalendar Extensions
internal extension NSCalendar {
    func components(fromDate: NSDate) -> NSDateComponents {
        return self.components(NSCalendarUnit(UInt.max), fromDate: fromDate);
    }
}


// MARK: NSCalendarUnit Extensions
internal extension NSCalendarUnit {
    func dateKitUnit() -> DateKit.Unit {
        switch self {
        case NSCalendarUnit.CalendarUnitNanosecond:     return .Nanosecond
        case NSCalendarUnit.CalendarUnitSecond:         return .Second
        case NSCalendarUnit.CalendarUnitMinute:         return .Minute
        case NSCalendarUnit.CalendarUnitHour:           return .Hour
        case NSCalendarUnit.CalendarUnitDay:            return .Day
        case NSCalendarUnit.CalendarUnitMonth:          return .Month
        case NSCalendarUnit.CalendarUnitYear:           return .Year
        case NSCalendarUnit.CalendarUnitEra:            return .Era
        case NSCalendarUnit.CalendarUnitWeekday:        return .Weekday
        case NSCalendarUnit.CalendarUnitWeekdayOrdinal: return .WeekdayOrdinal
        case NSCalendarUnit.CalendarUnitQuarter:        return .Quarter
        case NSCalendarUnit.CalendarUnitWeekOfMonth:    return .WeekOfMonth
        case NSCalendarUnit.CalendarUnitWeekOfYear:     return .WeekOfYear
        case NSCalendarUnit.CalendarUnitYearForWeekOfYear: return .YearForWeekOfYear
        default: return .NoUnit
        }
    }
    
    internal func string() -> String {
        return self.dateKitUnit().rawValue
    }
}

internal extension NSCalendarUnit {
    var nextUnit: NSCalendarUnit {
        get {
            switch self {
            case NSCalendarUnit.CalendarUnitMinute:
                return .CalendarUnitSecond
            case NSCalendarUnit.CalendarUnitHour:
                return .CalendarUnitMinute
            case NSCalendarUnit.CalendarUnitDay:
                return .CalendarUnitHour
            case NSCalendarUnit.CalendarUnitMonth:
                return .CalendarUnitDay
            case NSCalendarUnit.CalendarUnitYear:
                return .CalendarUnitMonth
            default: return NSCalendarUnit(UInt.max)
            }
        }
    }
    
    func length(forDate date: NSDate) -> Int {
        switch self {
        case NSCalendarUnit.CalendarUnitSecond: return 1000
        case NSCalendarUnit.CalendarUnitMinute: return 60
        case NSCalendarUnit.CalendarUnitHour:   return 60
        case NSCalendarUnit.CalendarUnitDay:
            return DateKit.calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitHour, inUnit: NSCalendarUnit.CalendarUnitDay, forDate: date).length
        case NSCalendarUnit.CalendarUnitMonth:
            return DateKit.calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: date).length
        case NSCalendarUnit.CalendarUnitYear:
            return DateKit.calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitMonth, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: date).length
        default: return Int.max
        }
    }
}

// MARK: NSComparisonResult Extensions
public extension NSComparisonResult {
    var same:       Bool { get { return self == NSComparisonResult.OrderedSame } }
    var ascending:  Bool { get { return self == NSComparisonResult.OrderedAscending } }
    var descending: Bool { get { return self == NSComparisonResult.OrderedDescending } }
    var notSame:       Bool { get { return self != NSComparisonResult.OrderedSame } }
    var notAscending:  Bool { get { return self != .OrderedAscending } }
    var notDescending: Bool { get { return self != .OrderedDescending } }
}

// MARK: String Extensions
internal extension String {
    func dateKitUnit() -> DateKit.Unit? {
        return DateKit.Unit(rawValue: self)
    }
}
