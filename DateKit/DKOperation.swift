//
//  DKOperation.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 18.01.2015.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Foundation

// MARK: Operations on NSDate components and comparing components
public class Operation: Comparable, Equatable {
    init(value v: Int, date d: NSDate, unit u: NSCalendarUnit) {
        value = v
        date = d
        unit = u
    }
    
    internal let value: Int
    public var date: NSDate
    internal let unit: NSCalendarUnit
}

extension Operation {
    public func add(value: Int) -> Operation {
        let newValue = self.value + value
        return Operation(value: newValue, date: self.date.setComponent(self.unit, value: newValue), unit: self.unit)
    }
    
    public func substract(value: Int) -> Operation {
        let newValue = self.value - value
        return Operation(value: newValue, date: self.date.setComponent(self.unit, value: newValue), unit: self.unit)
    }
}


// MARK: Operation getters
extension Operation: DateKitOperationGetters {
    public var seconds: Operation { get { return Operation(value: value, date: date, unit: .CalendarUnitSecond) } }
    public var minutes: Operation { get { return Operation(value: value, date: date, unit: .CalendarUnitMinute) } }
    public var hours:   Operation { get { return Operation(value: value, date: date, unit: .CalendarUnitHour) } }
    public var days:    Operation { get { return Operation(value: value, date: date, unit: .CalendarUnitDay) } }
    public var months:  Operation { get { return Operation(value: value, date: date, unit: .CalendarUnitMonth) } }
    public var years:   Operation { get { return Operation(value: value, date: date, unit: .CalendarUnitYear) } }
    public var eras:    Operation { get { return Operation(value: value, date: date, unit: .CalendarUnitEra) } }
}


// MARK: Operation Setters
extension Operation: DateKitOperationSetters {
    public func second(value: Int)  -> Operation { return date.setDateOperation(.CalendarUnitSecond, value: value) }
    public func minute(value: Int)  -> Operation { return date.setDateOperation(.CalendarUnitMinute, value: value) }
    public func hour(value: Int)    -> Operation { return date.setDateOperation(.CalendarUnitHour, value: value) }
    public func day(value: Int)     -> Operation { return date.setDateOperation(.CalendarUnitDay, value: value) }
    public func month(value: Int)   -> Operation { return date.setDateOperation(.CalendarUnitMonth, value: value) }
    public func year(value: Int)    -> Operation { return date.setDateOperation(.CalendarUnitYear, value: value) }
    public func era(value: DateKit.Era)     -> Operation { return date.setDateOperation(.CalendarUnitEra, value: value.rawValue) }
}


// MARK: Operation helpers
extension Operation {
    public var first: NSDate {
        get {
            switch unit.dateKitUnit() as DateKit.Unit {
            case .Second:   return (date.second(0)  as Operation).date
            case .Minute:   return (date.minute(0)  as Operation).date
            case .Hour:     return (date.hour(0)    as Operation).date
            case .Day:      return (date.day(1)     as Operation).date
            case .Month:    return (date.month(1)   as Operation).date
            case .Year:     return (date.year(0)    as Operation).date
            default:        return date
            }
        }
    }
    
    public var last: NSDate {
        get {
            switch unit.dateKitUnit() {
            case .Second:   return (date.second(59) as Operation).date
            case .Minute:   return (date.minute(59) as Operation).date
            case .Hour:     return (date.hour(23)   as Operation).date
            case .Day:
                return (date.day((date.months as Operation).length) as Operation).date
            case .Month:    return (date.month(12) as Operation).date
            default:        return date
            }
        }
    }
}

// MARK: Length by unit
extension Operation {
    public var length: Int { get { return unit.length(forDate: date) } }
    
    // FIXME: Calculated length is wrong
    private func findLength(inUnit component: NSCalendarUnit) -> Int {
        var checkUnit = unit
        var result: Int = value
        
        while unit != checkUnit {
            var newValue = checkUnit.length(forDate: date)
            result = result * newValue
            checkUnit = checkUnit.nextUnit
        }
        
        return result
    }
    
    
    // TODO: Check if absoluteLength() method necessary
    private func absoluteLength() -> Operation? {
        switch unit {
        case NSCalendarUnit.CalendarUnitMinute:
            return Operation(value: self.length, date: date, unit: .CalendarUnitSecond)
        case NSCalendarUnit.CalendarUnitHour:
            return Operation(value: self.length, date: date, unit: .CalendarUnitMinute)
        case NSCalendarUnit.CalendarUnitDay:
            return Operation(value: self.length, date: date, unit: .CalendarUnitHour)
        case NSCalendarUnit.CalendarUnitMonth:
            return Operation(value: self.length, date: date, unit: .CalendarUnitDay)
        case NSCalendarUnit.CalendarUnitYear:
            return Operation(value: self.length, date: date, unit: .CalendarUnitMonth)
        default: return nil
        }
    }
}



// MARK: Operation operators
public func + (lhs: Operation, rhs: Int) -> NSDate {
    return lhs.add(rhs).date
}

public func - (lhs: Operation, rhs: Int) -> NSDate {
    return lhs.substract(rhs).date
}

// MARK: Date components comparison operators
public func == (lhs: Operation, rhs: Operation) -> Bool {
    return (lhs.value == rhs.value) && (lhs.unit == rhs.unit)
}

public func == (lhs: Operation, rhs: Int) -> Bool {
    return lhs.value == rhs
}

public func < (lhs: Operation, rhs: Operation) -> Bool {
    return (lhs.value < rhs.value) && (lhs.unit == rhs.unit)
}

public func <= (lhs: Operation, rhs: Operation) -> Bool {
    return (lhs.value <= rhs.value) && (lhs.unit == rhs.unit)
}

public func > (lhs: Operation, rhs: Operation) -> Bool {
    return (lhs.value > rhs.value) && (lhs.unit == rhs.unit)
}

public func >= (lhs: Operation, rhs: Operation) -> Bool {
    return (lhs.value >= rhs.value) && (lhs.unit == rhs.unit)
}

