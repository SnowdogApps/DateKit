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
    public var second   : Int { get { return components.second } }
    public var minute   : Int { get { return components.minute } }
    public var hour     : Int { get { return components.hour } }
    public var day      : Int { get { return components.day } }
    public var weekday  : Int { get { return components.weekday } }
    public var month    : Int { get { return components.month } }
    public var year     : Int { get { return components.year } }
    public var era      : Int { get { return components.era } }
}



// MARK: NSDate Operation Getters
extension NSDate: DateKitOperationGetters {
    public var seconds  : Operation { get { return dateOperation(.CalendarUnitSecond) } }
    public var minutes  : Operation { get { return dateOperation(.CalendarUnitMinute) } }
    public var hours    : Operation { get { return dateOperation(.CalendarUnitHour) } }
    public var days     : Operation { get { return dateOperation(.CalendarUnitDay) } }
    public var months   : Operation { get { return dateOperation(.CalendarUnitMonth) } }
    public var years    : Operation { get { return dateOperation(.CalendarUnitYear) } }
    public var eras     : Operation { get { return dateOperation(.CalendarUnitEra) } }
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
        var unit = calendarUnit(units)
        var firstComponents = DateKit.calendar.components(unit, fromDate: self)
        var secondComponents = DateKit.calendar.components(unit, fromDate: date)
    
        for unit in units {
            let unitString = unit.string()
            var firstComponentValue: Int = firstComponents.valueForKey(unitString) as! Int!
            var secondComponentValue: Int = secondComponents.valueForKey(unitString) as! Int!
            
            if firstComponentValue != secondComponentValue {
                return compare(date)
            }
        }
        
        return .OrderedSame
    }
}

public extension NSDate {
    
    var components: NSDateComponents { get { return DateKit.calendar.components(self) } }
    
    func components(component: NSCalendarUnit) -> NSDateComponents {
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

public extension NSDate {
    
    func nanoseconds(nns: Int)  -> NSDate? { return setComponent(.CalendarUnitNanosecond, value: nns) }
    func seconds(sec: Int)      -> NSDate? { return setComponent(.CalendarUnitSecond, value: sec) }
    func minutes(min: Int)      -> NSDate? { return setComponent(.CalendarUnitMinute, value: min) }
    func hours(hrs: Int)        -> NSDate? { return setComponent(.CalendarUnitHour, value: hrs) }
    func day(dd: Int)           -> NSDate? { return setComponent(.CalendarUnitDay, value: dd) }
    func month(mm: Int)         -> NSDate? { return setComponent(.CalendarUnitMonth, value: mm) }
    func year(yy: Int)          -> NSDate? { return setComponent(.CalendarUnitYear, value: yy) }
    func era(ee: Int)           -> NSDate? { return setComponent(.CalendarUnitEra, value: ee) }
    func weekday(wd: Int)       -> NSDate? { return setComponent(.CalendarUnitWeekday, value: wd) }
    func weekdayOrdinal(wdo: Int) -> NSDate? { return setComponent(.CalendarUnitWeekdayOrdinal, value: wdo) }
    func quarter(q: Int)        -> NSDate? { return setComponent(.CalendarUnitQuarter, value: q) }
    func weekOfMonth(wom: Int)  -> NSDate? { return setComponent(.CalendarUnitWeekOfMonth, value: wom) }
    func weekOfYear(woy: Int)   -> NSDate? { return setComponent(.CalendarUnitWeekOfYear, value: woy) }
    func yearForWeekOfYear(yy: Int) -> NSDate? { return setComponent(.CalendarUnitYearForWeekOfYear, value: yy) }
}

// MARK: Day helpers
public extension NSDate {
    
    var midnight: NSDate {
        get { return (hour(0).minute(0).second(0) as Operation).date }
    }
    
    var noon: NSDate {
        get { return (hour(12).minute(0).second(0) as Operation).date }
    }
    
    var yesterday   : NSDate { get { return days - 1 } }
    var tomorrow    : NSDate { get { return days + 1 } }
}

extension NSDate {
    
    public func between(#earlier: NSDate, later: NSDate) -> Bool {
        var descendingResult = compare(earlier).notAscending
        var ascendingResult = compare(later).notDescending
        return (ascendingResult && descendingResult)
    }
}


// MARK: NSDate Operators
extension NSDate: Comparable, Equatable {}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
}
public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func <= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) != .OrderedDescending
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}

public func >= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) != .OrderedAscending
}
