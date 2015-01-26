// Playground - noun: a place where people can play

import Foundation
import DateKit



let today = NSDate()
let otherToday = today
var tomorrow = today.dateByAddingTimeInterval(24*60*60)

/*
 *  Basic date components chaining
 */

// seperate
today.year(1989).date
today.month(12).date
today.day(30).date

// chained
today.year(1989).date.month(12).date.day(30).date


/*
 *  Dates comparing -> Bool result
 */
today < tomorrow
today <= tomorrow

today < otherToday
today <= otherToday

tomorrow > today
tomorrow >= today

today > otherToday
today >= otherToday

// Exactly equal
today == tomorrow
today == otherToday

/*
 *  Dates comparing by defined components
 */

// Day, Month and Year is a default
today.compare(toDate: tomorrow).same
today.compare(toDate: otherToday).same

// Only by Month and Year
today.compare(toDate: tomorrow, byUnits: [.CalendarUnitMonth, .CalendarUnitYear]).same
today.compare(toDate: tomorrow, byUnits: [.CalendarUnitMonth, .CalendarUnitYear]).ascending

// Only by Hour, Minutes and Seconds
today.compare(toDate: tomorrow, byUnits: [.CalendarUnitHour, .CalendarUnitMinute, .CalendarUnitSecond]).same

// Check the day only
today.compare(toDate: tomorrow, byUnits: [.CalendarUnitDay]).same
today.compare(toDate: tomorrow, byUnits: [.CalendarUnitDay]).descending
today.compare(toDate: tomorrow, byUnits: [.CalendarUnitDay]).ascending


/*
 *  Operations on NSDate components and comparing components
 */
today

today.minutes + 13
today.minutes - 4

today.hours + 1
today.hours - 1

today.minutes == otherToday.minutes

let localDate = today.minute(5).date
localDate.minutes == 5

/*
 *  Operating on integers values of components (obvious)
 *  Pay attention: integer components doesn't have 's' at the end
 *  date.seconds (returns Operation) while date.second (returns Int)
 */

today.minute
today.minute + 20

today.hour
today.hour - 2

/*
 *  Advanced chaining operations
 */

today.days.add(1).months.substract(1).hour(12).minute(30).date

/*
 *  Helpers
 */

today.midnight
today.noon

today.tomorrow
today.yesterday

today.months.first
today.months.last

today.minutes.length
today.days.length
today.months.length
today.years.length
