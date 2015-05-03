import Quick
import Nimble

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
                    ["unit": NSCalendarUnit.CalendarUnitEra.rawValue, "value": 0]
                }
                
                itBehavesLike("component") {
                    ["unit": NSCalendarUnit.CalendarUnitEra.rawValue, "value": 1]
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

            let baseDate = NSDate()
            var modifiedDate = NSDate()
            
            describe("default") {
                
                var lhs: NSDate!
                var rhs: NSDate!

                describe("for same time") {
                    
                    beforeEach {
                        lhs = baseDate
                        rhs = baseDate.copy() as! NSDate
                        
                    }
                    
                    it("should be equal") {
                        expect(lhs.compare(toDate: rhs).same).to(beTrue())
                    }
                    
                    it("should not be equal") {
                        rhs = (lhs.year(1989) as Operation).date
                        expect(lhs.compare(toDate: rhs).same).notTo(beTrue())
                    }
                }
                
                describe("for different time") {

                    beforeEach {
                        lhs = baseDate
                        rhs = baseDate.dateByAddingTimeInterval(60*30)
                    }

                    it("should be equal") {
                        expect(lhs.compare(toDate: rhs).same).to(beTrue())
                    }
                    
                    it("should not be equal") {
                        rhs = (lhs.year(1989) as Operation).date
                        expect(lhs.compare(toDate: rhs).same).notTo(beTrue())
                    }
                }
            }
            
            describe("second") {
                
                modifiedDate = (baseDate.second(60 - baseDate.second) as Operation).date
                
                itBehavesLike("Date comparison") {[
                    "original": baseDate,
                    "modified": modifiedDate,
                    "units": [NSCalendarUnit.CalendarUnitSecond.rawValue]
                ]}
            }
            
            describe("minute") {
                
                modifiedDate = (baseDate.minute(60 - baseDate.minute) as Operation).date
                
                itBehavesLike("Date comparison") {[
                    "original": baseDate,
                    "modified": modifiedDate,
                    "units": [NSCalendarUnit.CalendarUnitMinute.rawValue]
                ]}
            }
            
            describe("hour") {
                
                modifiedDate = (baseDate.hour(24 - baseDate.hour) as Operation).date
                
                itBehavesLike("Date comparison") {[
                    "original": baseDate,
                    "modified": modifiedDate,
                    "units": [NSCalendarUnit.CalendarUnitHour.rawValue]
                ]}
            }

            describe("day") {
                
                modifiedDate = (baseDate.day(1) as Operation).date
                
                itBehavesLike("Date comparison") {[
                    "original": baseDate,
                    "modified": modifiedDate,
                    "units": [NSCalendarUnit.CalendarUnitDay.rawValue]
                ]}
            }
            
            describe("month") {
                
                modifiedDate = (baseDate.month(12 - baseDate.month)as Operation).date
                
                itBehavesLike("Date comparison") {[
                    "original": baseDate,
                    "modified": modifiedDate,
                    "units": [NSCalendarUnit.CalendarUnitMonth.rawValue]
                ]}
            }
            
            describe("year") {
                
                modifiedDate = (baseDate.year(1989) as Operation).date
                
                itBehavesLike("Date comparison") {[
                    "original": baseDate,
                    "modified": modifiedDate,
                    "units": [NSCalendarUnit.CalendarUnitYear.rawValue]
                ]}
            }
        }
    
        describe("Date helpers") {
            let baseDate = NSDate()
            
            var referenceDate: NSDate! = nil
            var helperString: String! = nil
            
            var configDict = [String: AnyObject]()
            
            let configuration: (NSDate, String) -> [String: AnyObject] = { referenceDate, helperString in
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
                
                itBehavesLike("Date helper") { configuration(referenceDate!, helperString!) }
            }
            
            describe("noon helper") {
                var components = DateKit.calendar.components(baseDate)
                components.hour = 12
                components.minute = 0
                components.second = 0
                components.calendar = DateKit.calendar
                
                referenceDate = components.date
                helperString = "noon"
                
                itBehavesLike("Date helper") { configuration(referenceDate!, helperString!) }
            }

            describe("yesterday helper") {
                var components = DateKit.calendar.components(baseDate)
                components.day -= 1
                components.calendar = DateKit.calendar
                
                referenceDate = components.date
                helperString = "yesterday"
                
                itBehavesLike("Date helper") { configuration(referenceDate!, helperString!) }
            }

            describe("tomorrow helper") {
                var components = DateKit.calendar.components(baseDate)
                components.day += 1
                components.calendar = DateKit.calendar
                
                referenceDate = components.date
                helperString = "tomorrow"
                
                itBehavesLike("Date helper") { configuration(referenceDate!, helperString!) }
            }
            
            describe("between helper") {
                let firstDate = NSDate()
                let secondDate = (firstDate.days as Operation) + 1
                let testDate = (firstDate.hours as Operation) + 1

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
