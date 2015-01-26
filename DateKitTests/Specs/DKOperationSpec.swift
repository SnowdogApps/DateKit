import Quick
import Nimble

class DKOperationSpec: QuickSpec {
    override func spec() {

        describe("Operation") {
            let today: NSDate = NSDate()
            
            describe("initialized with arguments") {
                let value: Int = 5
                let unit: NSCalendarUnit = .CalendarUnitDay
                
                var operation: Operation! = Operation(value: value, date: today, unit: unit)
                
                it("should not be nil") {
                    expect(operation).notTo(beNil())
                }
                
                itBehavesLike("operation_properties_tests") {
                    [
                        "operation": operation!,
                        "value": value,
                        "date": today,
                        "unit": unit.rawValue
                    ]
                }
            }
            
            describe("mathematical operation") {
                let testDate: NSDate = (today.day(1) as Operation).date
                let operation = Operation(value: 1, date: testDate, unit: NSCalendarUnit.CalendarUnitDay)
                let sharedExampleName: String = "math_operation"
                
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
                let value: Int = 5
                let sharedExampleName: String = "operation_getters_setters"
                
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
                    let value: Int = 5
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
                let operationHelperExample = "operation_helper"
                
                describe("first") {
                    describe("year") {
                        var operation: Operation = Operation(value: 0, date: today, unit: NSCalendarUnit.CalendarUnitYear)
                        var resultDate = operation.first
                        var referenceDate: NSDate = today.setComponent(NSCalendarUnit.CalendarUnitYear, value: 0)
                        
                        it("should not be nil") {
                            expect(resultDate).notTo(beNil())
                        }
                        
                        it("should be equal to reference date") {
                            expect(resultDate == referenceDate).to(beTrue())
                        }
                    }
                }
                
                describe(operationHelperExample) {
                    itBehavesLike("operation_helper") {
                        [
                            "helper": "last",
                            "date": today
                        ]
                    }
                }
            }
            
            describe("unit length") {
                describe("seconds") {
                    itBehavesLike("unit_length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitSecond.rawValue,
                            "length": 1000
                        ]
                    }
                }
                
                describe("minutes") {
                    itBehavesLike("unit_length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitMinute.rawValue,
                            "length": 60
                        ]
                    }
                }
                
                describe("hours") {
                    itBehavesLike("unit_length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitHour.rawValue,
                            "length": 60
                        ]
                    }
                }
                
                describe("days") {
                    itBehavesLike("unit_length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitMinute.rawValue,
                            "length": NSCalendar.currentCalendar().rangeOfUnit(.CalendarUnitHour, inUnit: .CalendarUnitDay, forDate: today)
                        ]
                    }
                }
                
                describe("months") {
                    var length: Int = NSCalendar.currentCalendar().rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth , forDate: today).length
                    itBehavesLike("unit_length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitMonth.rawValue,
                            "length": length
                        ]
                    }
                }
                
                describe("years") {
                    var length: Int = NSCalendar.currentCalendar().rangeOfUnit(.CalendarUnitMonth, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: today).length
                    
                    itBehavesLike("unit_length") {
                        [
                            "date": today,
                            "unit": NSCalendarUnit.CalendarUnitYear.rawValue,
                            "length": length
                        ]
                    }
                }
            }
        }
    }
}



// MARK: Examples

class OperationPropertiesTestsExampleConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("operation_properties_tests") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as [String: AnyObject]
            
            let operation = configDict["operation"] as Operation
            let value: Int = configDict["value"] as Int
            let date: NSDate = configDict["date"] as NSDate
            let unitRawValue: UInt = configDict["unit"] as UInt
            
            it("should have exactly same value as passed in initialization") {
                expect(operation.value).to(equal(value))
            }
            
            it("should have exactly same date as passed in initialization") {
                expect(operation.date).to(equal(date))
            }
            
            it("should have exactly same unit as passed in initialization") {
                expect(operation.unit.rawValue).to(equal(unitRawValue))
            }
        }
    }
}

class OperationMathOperationExampleConfiguration : QuickConfiguration {
    
    override class func configure(configuration: Configuration) {
        sharedExamples("math_operation") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as [String: AnyObject]
            let operation: Operation = configDict["operation"] as Operation
            let mathOperator: String = configDict["operator"] as String
            let value: Int = configDict["value"] as Int
            
            var resultOperation: Operation? = operation.mathOperationByString(mathOperator, value: value)
            var resultDate: NSDate = operation.resultingDate(mathOperator, value: value)
            
            it("should return non-nil operation instance") {
                expect(resultOperation).notTo(beNil())
            }
            
            it("should return new operation instance") {
                expect(resultOperation).notTo(equal(operation))
            }
            
            itBehavesLike("operation_properties_tests") {
                [
                    "operation": resultOperation!,
                    "value": operation.resultingValue(mathOperator, value: value),
                    "date": resultDate,
                    "unit": operation.unit.rawValue
                ]
            }
        }
    }
}

class OperationGettersExampleConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("operation_getters_setters") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as [String: AnyObject]

            let operation: Operation = configDict["operation"] as Operation
            let value: Int = configDict["value"] as Int
            let getterString: String = configDict["getter"] as String
            
            var resultOperation: Operation? = operation.getterOperationByString(getterString)
            
            it("should not return nil") {
                expect(resultOperation).notTo(beNil())
            }
            
            describe("operation properties") {
                itBehavesLike("operation_properties_tests") {
                    [
                        "operation": resultOperation!,
                        "value": value,
                        "date": operation.date,
                        "unit": operation.unit.rawValue
                    ]
                }
            }
        }
    }
}

class OperationHelpersExampleConfiguration : QuickConfiguration {
    class func valueForHelper(helperString: String, unit: DateKit.Unit) -> Int {
        if helperString == "first" {
            return valueForFirstHelper(unit)
        } else if helperString == "last" {
            return valueForLastHelper(unit)
        }
        
        return 0
    }
    
    class func valueForFirstHelper(unit: DateKit.Unit) -> Int {
        switch unit {
        case .Day:      fallthrough
        case .Month:    return 1
        default:        return 0
        }
    }
    
    class func valueForLastHelper(unit: DateKit.Unit) -> Int {
        switch unit {
        case .Second:   fallthrough
        case .Minute:   return 59
        case .Hour:     return 23
        case .Day:      return NSCalendarUnit.CalendarUnitMonth.length(forDate: NSDate())
        case .Month:    return 12
        default:        return 0
        }
    }
    
    override class func configure(configuration: Configuration) {
        sharedExamples("operation_helper") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as [String: AnyObject]
            var helper: String = configDict["helper"] as String

            describe("second") {
                var cfgDict: [String: AnyObject] = configDict
                
                itBehavesLike("operation_helper_for_unit") {
                    cfgDict["unit"] = NSCalendarUnit.CalendarUnitSecond.rawValue
                    cfgDict["value"] = self.valueForHelper(helper, unit: .Second)
                    return cfgDict
                }
            }
            
            describe("minute") {
                var cfgDict: [String: AnyObject] = configDict
                itBehavesLike("operation_helper_for_unit") {
                    cfgDict["unit"] = NSCalendarUnit.CalendarUnitMinute.rawValue
                    cfgDict["value"] = self.valueForHelper(helper, unit: .Minute)
                    return cfgDict
                }
            }
            
            describe("hour") {
                var cfgDict: [String: AnyObject] = configDict
                itBehavesLike("operation_helper_for_unit") {
                    cfgDict["unit"] = NSCalendarUnit.CalendarUnitHour.rawValue
                    cfgDict["value"] = self.valueForHelper(helper, unit: .Hour)
                    return cfgDict
                }
            }
            
            describe("day") {
                var cfgDict: [String: AnyObject] = configDict
                itBehavesLike("operation_helper_for_unit") {
                    cfgDict["unit"] = NSCalendarUnit.CalendarUnitDay.rawValue
                    cfgDict["value"] = self.valueForHelper(helper, unit: .Day)
                    return cfgDict
                }
            }
            
            describe("month") {
                var cfgDict: [String: AnyObject] = configDict
                itBehavesLike("operation_helper_for_unit") {
                    cfgDict["unit"] = NSCalendarUnit.CalendarUnitMonth.rawValue
                    cfgDict["value"] = self.valueForHelper(helper, unit: .Month)
                    return cfgDict
                }
            }
        }
    }
}


class OperationHelpersForUnitExampleConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("operation_helper_for_unit") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as [String: AnyObject]

            let unit: UInt = configDict["unit"] as UInt
            let value: Int = configDict["value"] as Int
            let date: NSDate = configDict["date"] as NSDate
            let helperString: String = configDict["helper"] as String

            var operation = Operation(value: value, date: date, unit: NSCalendarUnit(unit))
            var referenceDate: NSDate = date.setComponent(NSCalendarUnit(unit), value: value)
            var helperDate = operation.resultDateForHelperString(helperString)

            it("should not be nil") {
                expect(helperDate).notTo(beNil())
            }
            
            it("should be equal to reference date") {
                expect(helperDate == referenceDate).to(beTrue())
            }
        }
    }
}

class OperationUnitLengthExampleConfiguration : QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("unit_length") { (sharedExampleContext: SharedExampleContext) in
            var configDict: [String: AnyObject] = sharedExampleContext() as [String: AnyObject]

            let date: NSDate = configDict["date"] as NSDate
            let unit: UInt = configDict["unit"] as UInt
//            let expectedLength: Int = configDict["length"] as Int
//            let operation: Operation = Operation(value: 0, date: date, unit: NSCalendarUnit(unit))
//
//            var resultLength: Int = operation.length
//            
//            it("should be non-negative") {
//                expect(resultLength).notTo(beLessThan(0))
//            }
//            
//            it("should be correct") {
//              expect(resultLength).to(equal(expectedLength))
//            }
        }
    }
}



// MARK: Spec helpers

extension Operation {
    func mathOperationByString(operation: String, value: Int) -> Operation {
        switch operation {
        case "add": return add(value)
        case "substract": return substract(value)
        default: return self
        }
    }
    
    func getterOperationByString(getter: String) -> Operation {
        switch getter {
        case "seconds": return seconds
        case "minutes": return minutes
        case "hours":   return hours
        case "days":    return days
        case "months":  return months
        case "years":   return years
        case "eras":    return eras
        default:        return self
        }
    }
    
    func resultingValue(operation: String, value: Int) -> Int {
        switch operation {
        case "add": return self.value + value
        case "substract": return self.value - value
        default: return self.value
        }
    }
    
    func resultingDate(operation: String, value: Int) -> NSDate {
        switch operation {
        case "add":     return date.setComponent(unit, value: self.value + value)
        case "substract":   return date.setComponent(unit, value: self.value - value)
        default: return self.date
        }
    }
    
    func resultDateForHelperString(helperString: String) -> NSDate {
        switch helperString {
        case "first":   return first
        case "last":    return last
        default: return date
        }
    }
}




