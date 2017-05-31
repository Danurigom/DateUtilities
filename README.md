# Swift Date Utilities
Powerful extensions for Date in Swift.
(Forked from https://github.com/chrisamanse/iOS-NSDate-Utilities)

# Server Configuration

You can use The Swift Package Manager to install SwiftyJSON by adding the proper description to your  Package.swift file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/Danurigom/DateUtilities.git", majorVersion: 1)
    ]
)
```

# Local Installation

Import only what you need:
* Date+Main.swift - *required*
* Date+Comparable.swift
* Date+Periods.swift
* Date+Periods.swift

# Usage

## TimeInterval extension:

```swift
var seconds = 2.seconds // 2 (as NSTimeInterval)
seconds = 3.minutes // 3*60 = 180
seconds = 1.hours // 1*60*60 = 3600
seconds = 1.days // 1*60*60*24 = 86400
seconds = 1.weeks // 1*60*60*24*7 = 604800

let minutesIn3600Seconds = 3600.preciseCount(.Minute) // 60.0 (as Double - since there is exactly 60 minutes in 3600 seconds)
let minutes = 30.preciseCount(.Minute) // 0.5 (Half a minute)
let hoursInWeek = 1.week.preciseCount(.Hour) // 168.0 (24 hours * 7 days)

// You can use the rest of the NSDateUnit values to count the desired unit
```

## Date+Main.swift:

### Date Creation

```swift
Date().calendar // Shortcut for Calendar.currentCalendar() - used in the extensions
Date.dateWithYear(2015, month: 6, andDay: 28) // Creates date of June 28, 2015 at 12 AM
Date.dateWithYear(2015, month: 1, day: 1, hour: 14, minute: 5, andSecond: 30) // Creates date of January 1, 2015 at 2:05:30 PM

Date.today() // Today same time
Date.tomorrow() // Tomorrow same time
Date.yeasterday() // Yesterday same time

Date.dateFromString(dateString: "03-30-2015", withFormat: "MM-dd-yyyy") // March 30, 2015 12AM

let components = DateComponents()
components.year = 2015
components.month = 3
components.day = 30

Date.dateFromComponents(components) // March 30, 2015 12AM
```

### Components and Conversion

```swift
Date.dateWithYear(2015, month: 11, andDay: 23).toStringWithFormat("MM-dd-yyyy") // "11-23-2015"

let christmas = Date.dateWithYear(2015, month: 12, andDay: 25)
christmas.getComponents(.CalendarUnitDay).day // 25
christmas.year // 2015
christmas.month // 12
christmas.day // 25
christmas.hour // 0 - since it's 12:00:00 AM
christmas.minute // 0
christmas.second // 0
```

### Check relative date

```swift
Date().isToday == true
Date.tomorrow().isTomorrow == true
Date.yesterday().isYesterday == true

Date().isWeekend // Check if date is a weekend
Date().isWeekday
```

## Date+Comparable.swift:

Compare dates using operators.

```swift
let today = Date()
today < Date.tomorrow() // True
today > Date.yesterday() // True
today == today // True
today != Date.tomorrow()
```

## Date+Periods.swift:

Get start, end, next, or previous of a unit (Year, Month, Day, Week, Hour, Minute, Second) of a date.

```swift
let date = Date.dateWithYear(2015, month: 10, day: 20, hour: 8, minute: 40, second: 9) // Oct 20, 2015 8:40:09 AM
date.startOf(.Day) // Oct 20, 2015 at 12 AM
date.startOf(.Month) // Oct 1, 2015, 12 AM
date.startOf(.Year) // Jan 1, 2015, 12 AM
// You can also use .Second, .Minute, .Hour, and .Week

date.endOf(.Day) // Oct 20, 2015 at 11:59:59 PM
date.endOf(.Month) // Oct 31, 2015, 11:59:59 PM
date.endOf(.Year) // Dec 31, 2015, 11:59:59 PM
// You can also use .Second, .Minute, .Hour, and .Week

date.next(.Day) // Oct 21, 2015 at 8:40:09 AM
date.next(.Month) // Nov 20, 2015, 8:40:09 AM
date.next(.Year) // Oct 20, 2016, 8:40:09 AM
// You can also use .Second, .Minute, .Hour, and .Week

date.previous(.Day) // Oct 19, 2015 at 8:40:09 AM
date.previous(.Month) // Sept 20, 2015, 8:40:09 AM
date.previous(.Year) // Oct 20, 2014, 8:40:09 AM
// You can also use .Second, .Minute, .Hour, and .Week
```

## Date+Count.swift

Count units from date to another date.

```swift
let today = Date()
let tomorrow = today.next(.Day)
today.count(.Day, toDate: tomorrow) // 1
today.preciseCount(.Day, toDate: tomorrow) // 1.0
today.count(.Hour, toDate: tomorrow) // 24

// Difference between count and preciseCount
let startOfDay = today.startOf(.Day)
let lunch = NSDate.dateWithYear(startOfDay.year, month: startOfMonth.month, day: startOfMonth.day, hour: 12, minute: 0, andSecond: 0)
startOfDay.count(.Day, toDate: lunch) // 0
startOfDay.preciseCount(.Day, toDate: lunch) // 0.5 (Half a day or 12 hours)
startOfDay.preciseCount(.Hour, toDate: lunch) // 12 (hours)
```

Count units from a larger unit based on a given date.

```swift
let daysInMonthToday = Date.count(.Day, inA: .Month, fromDate: Date.today()) // Count days in current month
let daysInYearToday = Date.preciseCount(.Day, inA: .Year, fromDate: Date.today()) // Count days in year precisely
```

# License
Copyright (c) 2016 Joe Christopher Paul Amanse

This software is distributed under the [MIT License](./LICENSE.md).
