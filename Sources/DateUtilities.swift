//
//  DateUtilities.swift
//  Date_Extensions
//
//  Created by Chris Amanse on 5/12/15.
//  Copyright (c) 2015 Joe Christopher Paul Amanse. All rights reserved.
//
//  This code is licensed under the MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

// MARK: - NSDate Units

public enum DateUnit: Int {
    case second = 1
    case minute
    case hour
    case day
    case week
    case month
    case year
}

// MARK: - NSTimeInterval Utilities
extension TimeInterval {
    var seconds: TimeInterval {
        return self
    }
    var minutes: TimeInterval {
        return self * 60
    }
    var hours: TimeInterval {
        return self.minutes * 60
    }
    var days: TimeInterval {
        return self.hours * 24
    }
    var weeks: TimeInterval {
        return self.days * 7
    }
    
    func count(_ unit: DateUnit) -> Double {
        switch unit {
        case .second:
            return self
        case .minute:
            return self / 1.minutes
        case .hour:
            return self / 1.hours
        case .day:
            return self / 1.days
        case .week:
            return self / 1.weeks
        case .month:
            return self / 31.days // Inaccurate - not all months have 31 days, maybe modify to get days in current month?
        case .year:
            return self / 365.days // Inaccurate - not all years have 365 days
        }
    }
}

// MARK: - NSDate Utilities

extension Date {
    // For shorter call of current calendar within NSDate instance
    var calendar: Calendar {
        return Calendar.current
    }
    
    // MARK: - Date Creation
    static func dateWithYear(_ year: Int, month: Int, andDay day: Int) -> Date? {
        var components = DateComponents()
        components.month = month
        components.day = day
        components.year = year
        
        return Calendar.current.date(from: components)
    }
    static func dateWithYear(_ year: Int, month: Int, day: Int, hour: Int, minute: Int, andSecond second: Int) -> Date? {
        var components = DateComponents()
        components.month = month
        components.day = day
        components.year = year
        components.hour = hour
        components.minute = minute
        components.second = second
        
        return Calendar.current.date(from: components)
    }
    
    static func dateFromString(_ dateString: String, withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    static func dateFromComponents(_ components: DateComponents) -> Date? {
        return Calendar.current.date(from: components)
    }
    
    static func today() -> Date {
        return Date()
    }
    static func yesterday() -> Date {
        return Date().addingTimeInterval(-1.days)
    }
    static func tomorrow() -> Date {
        return Date().addingTimeInterval(1.days)
    }
    
    // MARK: - Conversion
    func toStringWithFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    // MARK: - Components using Units
    func getComponents(_ unitFlags: NSCalendar.Unit) -> DateComponents {
        return (calendar as NSCalendar).components(unitFlags, from: self)
    }
    
    // MARK: Calendar Units
    var era: Int {
        return calendar.component(.era, from: self)
    }
    var year: Int {
        return calendar.component(.year, from: self)
    }
    var month: Int {
        return calendar.component(.month, from: self)
    }
    var day: Int {
        return calendar.component(.day, from: self)
    }
    var hour: Int {
        return calendar.component(.hour, from: self)
    }
    var minute: Int {
        return calendar.component(.minute, from: self)
    }
    var second: Int {
        return calendar.component(.second, from: self)
    }
    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }
    var weekdayOrdinal: Int {
        return calendar.component(.weekdayOrdinal, from: self)
    }
    var quarter: Int {
        return calendar.component(.quarter, from: self)
    }
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    var nanosecond: Int {
        return calendar.component(.nanosecond, from: self)
    }
    
    var isToday: Bool {
        return calendar.isDateInToday(self)
    }
    var isTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }
    var isYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    var isWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }
    var isWeekday: Bool {
        return !isWeekend
    }
}
