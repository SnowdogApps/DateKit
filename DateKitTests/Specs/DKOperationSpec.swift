import Quick
import Nimble

class DKOperationSpec: QuickSpec {
    override func spec() {

        describe("Operation") {
            let today = NSDate()
            
            describe("initialized with arguments") {
                let value = 5
                let unit = NSCalendarUnit.CalendarUnitDay
                
                var operation: Operation! = Operation(value: value, date: today, unit: unit)
                
                it("should not be nil") {
                    expect(operation).notTo(beNil())
                }
                
                itBehavesLike("operation properties tests") {
                    [
                        "operation": operation!,
                        "value": value,
                        "date": today,
                        "unit": unit.rawValue
                    ]
                }
            }
            
            describe("mathematical operation") {
                let testDate = (today.day(1) as Operation).date
                let operation = Operation(value: 1, date: testDate, unit: .CalendarUnitDay)
                let sharedExampleName = "math operation"
                
                describe("addition") {
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "operator": "add",
                            "value": 5
                        ]
                    }
                }
                
                describe("substraction") {
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "operator": "substract",
                            "value": 5
                        ]
                    }
                }
            }
            
            describe("getter and setter") {
                let value = 5
                let sharedExampleName = "operation getters setters"
                
                describe("seconds") {
                    let operation: Operation = today.second(value)
                    
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "value": value,
                            "getter": "seconds"
                        ]
                    }
                }
                
                describe("minutes") {
                    let value = 5
                    let operation: Operation = today.minute(value)
                    
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "value": value,
                            "getter": "minutes"
                        ]
                    }
                }
                
                describe("hours") {
                    let operation: Operation = today.hour(value)
                    
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "value": value,
                            "getter": "hours"
                        ]
                    }
                }
                
                describe("days") {
                    let operation: Operation = today.day(value)
                    
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "value": value,
                            "getter": "days"
                        ]
                    }
                }
                
                describe("months") {
                    let operation: Operation = today.month(value)
                    
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "value": value,
                            "getter": "months"
                        ]
                    }
                }
                
                describe("years") {
                    let operation: Operation = today.year(value)
                    
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "value": value,
                            "getter": "years"
                        ]
                    }
                }
                
                describe("eras") {
                    let operation: Operation = today.era(.BC)
                    
                    itBehavesLike(sharedExampleName) {
                        [
                            "operation": operation,
                            "value": 0,
                            "getter": "eras"
                        ]
                    }
                }
            }
            
            describe("helper") {
                let operationHelperExample = "operation helper"
                
                describe("first") {
                    describe("year") {
                        var operation = Operation(value: 0, date: today, unit: .CalendarUnitYear)
                        var resultDate = operation.first
                        var referenceDate: NSDate = today.setComponent(.CalendarUnitYear, value: 0)
                        
                        it("should not be nil") {
                            expect(resultDate).notTo(beNil())
                        }
                        
                        it("should be equal to reference date") {
                            expect(resultDate == referenceDate).to(beTrue())
                        }
                    }
                }
                
                describe(operationHelperExample) {
                    itBehavesLike("operation helper") {
                        [
                            "helper": "last",
                            "date": today
                        ]
                    }
                }
            }
            
            describe("unit length") {
                describe("seconds") {
                    itBehavesLike("unit length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitSecond.rawValue,
                            "length": NSNumber(integer: 1000)
                        ]
                    }
                }
                
                describe("minutes") {
                    itBehavesLike("unit length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitMinute.rawValue,
                            "length": NSNumber(integer: 60)
                        ]
                    }
                }
                
                describe("hours") {
                    itBehavesLike("unit length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitHour.rawValue,
                            "length": NSNumber(integer: 60)
                        ]
                    }
                }
                
                describe("days") {
                    var length = NSCalendar.currentCalendar().rangeOfUnit(.CalendarUnitHour, inUnit: .CalendarUnitDay, forDate: today).length
                    itBehavesLike("unit length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitDay.rawValue,
                            "length": NSNumber(integer: length)
                        ]
                    }
                }
                
                describe("months") {
                    var length: Int = NSCalendar.currentCalendar().rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth , forDate: today).length
                    itBehavesLike("unit length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitMonth.rawValue,
                            "length": NSNumber(integer: length)
                        ]
                    }
                }
                
                describe("years") {
                    var length: Int = NSCalendar.currentCalendar().rangeOfUnit(.CalendarUnitMonth, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: today).length
                    
                    itBehavesLike("unit length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitYear.rawValue,
                            "length": NSNumber(integer: length)
                        ]
                    }
                }
            }
        }
    }
}
