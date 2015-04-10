import Quick
import Nimble
import Foundation
import DateKit

class NSDateExtensionsSpec: QuickSpec {
    override func spec() {
        describe("Date single component") {
            describe("second") {
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitSecond.rawValue, "value": 5]
                }
            }
            
            describe("minute") {
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitMinute.rawValue, "value": 13]
                }
            }
            
            describe("hour") {
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitHour.rawValue, "value": 5]
                }
            }
            
            describe("day") {
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitDay.rawValue, "value": 2]
                }
            }
            
            describe("month") {
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitMonth.rawValue, "value": 7]
                }            }
            
            describe("year") {
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitYear.rawValue, "value": 1989]
                }
            }
            
            describe("era") {
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitEra.rawValue, "value": 0, "debug": true]
                }
                
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitEra.rawValue, "value": 1, "debug": true]
                }
            }
        }
        
        describe("Date components") {
            let today = NSDate()
            let components: NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(UInt.max), fromDate: today)
            var resultComponents: NSDateComponents? = nil
            
            beforeEach { resultComponents = today.components }
            afterEach { resultComponents = nil }

            it("should not be nil") {
                expect(resultComponents).notTo(beNil())
            }
            
            it("should be correct") {
                expect(resultComponents).to(equal(components))
            }
        }
        
        describe("Date operator") {
            let left: NSDate = NSDate()
            let equal = left
            let earlier = left.dateByAddingTimeInterval(-10)
            let later = left.dateByAddingTimeInterval(10)
            
            describe("less than") {
                it("should be less") {
                    expect(left < later).to(beTrue())
                    expect(left < earlier).to(beFalse())
                    expect(left < equal).to(beFalse())
                }
            }
            
            describe("less than and equal") {
                it("should be less or equal") {
                    expect(left <= later).to(beTrue())
                    expect(left <= earlier).to(beFalse())
                    expect(left <= equal).to(beTrue())
                }
            }
            
            describe("greater than") {
                it("should be greater") {
                    expect(left > later).to(beFalse())
                    expect(left > earlier).to(beTrue())
                    expect(left > equal).to(beFalse())
                }
            }
            
            describe("greater than and equal") {
                it("should be greater than or equal") {
                    expect(left >= later).to(beFalse())
                    expect(left >= earlier).to(beTrue())
                    expect(left >= equal).to(beTrue())
                }
            }
        }
        
        describe("Date comparison for units") {
            let lhs = NSDate()
            var rhs: NSDate? = nil
            var units: [NSCalendarUnit] = []
            
            afterEach {
                units.removeAll(keepCapacity: false)
                rhs = nil
            }
            
            describe("default") {
                describe("for same time") {
                    beforeEach { rhs = lhs }
                    
                    it("should be equal") {
                        expect(lhs.compare(toDate: rhs!).rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                    
                    it("should not be equal") {
                        rhs = (lhs.year(1989) as Operation).date
                        expect(lhs.compare(toDate: rhs!).rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
                
                describe("for different time") {
                    beforeEach { rhs = lhs.dateByAddingTimeInterval(60*30) }

                    it("should be equal") {
                        expect(lhs.compare(toDate: rhs!).rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                    
                    it("should not be equal") {
                        rhs = (lhs.year(1989) as Operation).date
                        expect(lhs.compare(toDate: rhs!).rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
            }

            describe("second") {
                beforeEach { units = [.CalendarUnitSecond] }
                
                describe("for same dates") {
                    beforeEach { rhs = lhs }
                    
                    it("should be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
                
                describe("for different dates") {
                    beforeEach {
                        rhs = (lhs.second(60 - lhs.second) as Operation).date
                    }
                    
                    it("should not be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
            }
            
            describe("minute") {
                beforeEach { units = [.CalendarUnitMinute] }
                
                describe("for same dates") {
                    beforeEach { rhs = lhs }
                    
                    it("should be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
                
                describe("for different dates") {
                    beforeEach { rhs = (lhs.minute(60 - lhs.minute) as Operation).date }
                    
                    it("should not be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
            }
            
            describe("hour") {
                beforeEach { units = [.CalendarUnitHour] }
                
                describe("for same dates") {
                    beforeEach { rhs = lhs }
                    
                    it("should be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
                
                describe("for different dates") {
                    beforeEach { rhs = (lhs.hour(24 - lhs.hour) as Operation).date }
                    
                    it("should not be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }

            }

            describe("day") {
                beforeEach { units = [.CalendarUnitDay] }
                
                describe("for same dates") {
                    beforeEach { rhs = lhs }
                    
                    it("should be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
                
                describe("for different dates") {
                    beforeEach { rhs = (lhs.day(1) as Operation).date }
                    
                    it("should not be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
            }
            
            describe("month") {
                beforeEach { units = [.CalendarUnitMonth] }
        
                describe("for same dates") {
                    beforeEach { rhs = lhs }
                    
                    it("should be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
                
                describe("for different dates") {
                    beforeEach { rhs = (lhs.month(12 - lhs.month)as Operation).date }
                    
                    it("should not be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
            }
            
            describe("year") {
                beforeEach { units = [.CalendarUnitYear] }
                
                describe("for same dates") {
                    beforeEach { rhs = lhs }
                    
                    it("should be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
                
                describe("for different dates") {
                    beforeEach { rhs = (lhs.year(1989) as Operation).date }
                    
                    it("should not be equal") {
                        var result: NSComparisonResult = lhs.compare(toDate: rhs!, byUnits: units)
                        expect(result.rawValue).notTo(equal(NSComparisonResult.OrderedSame.rawValue))
                    }
                }
            }
        }
    
        describe("Date helpers") {
            let baseDate: NSDate = NSDate()
            
            var referenceDate: NSDate? = nil
            var helperString: String? = nil
            
            var configDict: [String: AnyObject]? = Dictionary()
            
            let configurationDict: (NSDate, String) -> [String: AnyObject] = { (referenceDate: NSDate, helperString: String) in
                [
                    "baseDate": baseDate,
                    "referenceDate": referenceDate,
                    "helper": helperString
                ]
            }
            
            afterEach {
                referenceDate = nil
                helperString = nil
            }
            
            describe("midnight helper") {
                var components = DateKit.calendar.components(baseDate)
                components.hour = 0
                components.minute = 0
                components.second = 0
                components.calendar = DateKit.calendar
                
                referenceDate = components.date
                helperString = "midnight"
                
                itBehavesLike("Date helper") { configurationDict(referenceDate!, helperString!) }
            }
            
            describe("noon helper") {
                var components = DateKit.calendar.components(baseDate)
                components.hour = 12
                components.minute = 0
                components.second = 0
                components.calendar = DateKit.calendar
                
                referenceDate = components.date
                helperString = "noon"
                
                itBehavesLike("Date helper") { configurationDict(referenceDate!, helperString!) }
            }

            describe("yesterday helper") {
                var components = DateKit.calendar.components(baseDate)
                components.day -= 1
                components.calendar = DateKit.calendar
                
                referenceDate = components.date
                helperString = "yesterday"
                
                itBehavesLike("Date helper") { configurationDict(referenceDate!, helperString!) }
            }

            describe("tomorrow helper") {
                var components = DateKit.calendar.components(baseDate)
                components.day += 1
                components.calendar = DateKit.calendar
                
                referenceDate = components.date
                helperString = "tomorrow"
                
                itBehavesLike("Date helper") { configurationDict(referenceDate!, helperString!) }
            }
            
            describe("between helper") {
                let firstDate: NSDate = NSDate()
                let secondDate: NSDate = (firstDate.days as Operation) + 1
                let testDate: NSDate = (firstDate.hours as Operation) + 1

                it("should return true") {
                    var result = testDate.between(earlier: firstDate, later: secondDate)
                    expect(result).to(beTrue())
                }
                
                it("should return false") {
                    var firstResult = firstDate.between(earlier: testDate, later: secondDate)
                    var secondResult = secondDate.between(earlier: firstDate, later: testDate)
                    var thirdResult = testDate.between(earlier: secondDate, later: firstDate)
                    
                    expect(firstResult).notTo(beTrue())
                    expect(secondResult).notTo(beTrue())
                    expect(thirdResult).notTo(beTrue())
                }
            }
        }
    }
}

class NSDateComponentSharedConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("component") { (sharedExampleContext: SharedExampleContext) in
            var configurationDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]
            
            var referenceDate: NSDate? = nil
            var testDate: NSDate! = nil
            
            let unit: UInt = configurationDict["unit"] as! UInt!
            let value: Int = configurationDict["value"] as! Int!
            
            let debug: Bool? = configurationDict["debug"] as! Bool?
            
            beforeEach {
                let originDate = NSDate(timeIntervalSince1970: 0)
                referenceDate = originDate.mock_referenceDate(NSCalendarUnit(unit), value: value)
                testDate = originDate.setComponent(unit, value: value)
            }
            
            afterEach {
                referenceDate = nil
                testDate = nil
            }
            it("should not be nil") {
                expect(testDate).notTo(beNil())
            }
            
            it("should have correct \(NSCalendarUnit(unit).string())") {
                var comparisonResult: NSComparisonResult? = referenceDate?.compare(testDate)
                if debug != nil {
                    println("\ndebugging component \(NSCalendarUnit(unit).string())")
                    println("\t referenceDate \(referenceDate)")
                    println("\t testDate \(testDate)")
                    println("\t comparisonResult \(comparisonResult?.rawValue)")
                }
                expect(comparisonResult!.rawValue).to(equal(NSComparisonResult.OrderedSame.rawValue))
            }
            
            it("should get correct seconds") {
                var result = testDate.component(unit)
                if debug != nil {
                    println("\ndebugging component \(NSCalendarUnit(unit).string())")
                    println("\t referenceDate \(referenceDate)")
                    println("\t testDate \(testDate)")
                    println("\t result \(result)")
                }
                expect(result).to(equal(value))
            }
        }
    }
}

class NSDateHelperSharedConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("Date helper") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as! [String: AnyObject]

            let helperString: String = configDict["helper"] as! String
            let debug: Bool? = configDict["debug"] as! Bool?
            let baseDate: NSDate = configDict["baseDate"] as! NSDate
            let referenceDate: NSDate = configDict["referenceDate"] as! NSDate

            var resultDate: NSDate? = nil
            
            beforeEach { resultDate = baseDate.dateFromHelpersString(helperString) }
            afterEach { resultDate = nil }
            
            it("should be equal to reference date") {
                expect(resultDate).to(equal(referenceDate))
            }
        }
    }
}


// MARK: Spec helpers

extension NSDate {
    internal func mock_referenceDate(unit: NSCalendarUnit, value: Int) -> NSDate? {
        var components: NSDateComponents = self.components
        
        if unit == .CalendarUnitYear || unit == .CalendarUnitYearForWeekOfYear {
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYear.string())
            components.setValue(value, forKey: NSCalendarUnit.CalendarUnitYearForWeekOfYear.string())
        } else {
            components.setValue(value, forKey: unit.string())
        }
        
        return DateKit.calendar.dateFromComponents(components)
    }
}

extension NSDate {
    internal func setComponent(component: UInt!, value: Int!) -> NSDate? {
        var unit: DateKit.Unit = NSCalendarUnit(component).dateKitUnit()
        
        switch unit {
        case .Second:       return (self.second(value) as Operation).date
        case .Minute:       return (self.minute(value) as Operation).date
        case .Hour:         return (self.hour(value) as Operation).date
        case .Day:          return (self.day(value) as Operation).date
        case .Month:        return (self.month(value) as Operation).date
        case .Year:         return (self.year(value) as Operation).date
        case .Era:          return (self.era(DateKit.Era(integerLiteral: value)) as Operation).date
        default: return self
        }
    }
    
    internal func component(component: UInt!) -> Int {
        var unit: DateKit.Unit = NSCalendarUnit(component).dateKitUnit()
        
        switch unit {
        case .Second:       return self.second
        case .Minute:       return self.minute
        case .Hour:         return self.hour
        case .Day:          return self.day
        case .Month:        return self.month
        case .Year:         return self.year
        case .Era:          return self.era
        default: return -1
        }
    }
}

extension NSDate {
    func dateFromHelpersString(helperString: String) -> NSDate {
        switch helperString {
        case "midnight":    return self.midnight
        case "noon":        return self.noon
        case "yesterday":   return self.yesterday
        case "tomorrow":    return self.tomorrow
        default:            return self
        }
    }
}