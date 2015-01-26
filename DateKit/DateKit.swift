//
//  DateKit.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 10.12.2014.
//  Copyright (c) 2014 Radosław Szeja. All rights reserved.
//

import Foundation

internal var _calendar: NSCalendar = NSCalendar.currentCalendar()

public class DateKit {
    public class var calendar: NSCalendar {
        get { return _calendar }
        set { _calendar = newValue }
    }
}

extension DateKit {
    public enum Era: Int, IntegerLiteralConvertible {
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

extension DateKit.Unit {
    internal func calendarUnit() -> NSCalendarUnit {
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
    
    internal func string() -> String {
        return calendarUnit().string()
    }
}


// MARK: NSCalendar Extensions
extension NSCalendar {
    internal func components(fromDate: NSDate) -> NSDateComponents {
        return self.components(NSCalendarUnit(UInt.max), fromDate: fromDate);
    }
}


// MARK: NSCalendarUnit Extensions
extension NSCalendarUnit {
    internal func dateKitUnit() -> DateKit.Unit {
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

extension NSCalendarUnit {
    internal var nextUnit: NSCalendarUnit {
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
    
    internal func length(forDate date: NSDate) -> Int {
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


// MARK: String Extensions
extension String {
    internal func dateKitUnit() -> DateKit.Unit? {
        return DateKit.Unit(rawValue: self)
    }
}


// MARK: NSComparisonResult Extensions
extension NSComparisonResult {
    public var same:       Bool { get { return self == NSComparisonResult.OrderedSame } }
    public var ascending:  Bool { get { return self == NSComparisonResult.OrderedAscending } }
    public var descending: Bool { get { return self == NSComparisonResult.OrderedDescending } }
    public var notSame:       Bool { get { return self != NSComparisonResult.OrderedSame } }
    public var notAscending:  Bool { get { return self != NSComparisonResult.OrderedAscending } }
    public var notDescending: Bool { get { return self != NSComparisonResult.OrderedDescending } }
}