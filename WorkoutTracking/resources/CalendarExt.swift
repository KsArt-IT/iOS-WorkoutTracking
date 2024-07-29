//
//  CalendarExt.swift
//  WorkoutTracking
//
//  Created by KsArT on 28.06.2024.
//

import Foundation

/// A utility class for calendar-related functionalities.
final class CalendarExt {

    /// A tuple representing a day of the week and the day of the month.
    typealias WeekDaysShort = (week: String, day: Int, isSelected: Bool) // day of the week and day of the month

    typealias MonthsShort = (month: String, isSelected: Bool) //

    /// A calendar instance with Monday as the first day of the week.
    private static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2  // 2 means Monday is the first day of the week
        calendar.locale = Locale.autoupdatingCurrent
        return calendar
    }()

    /// An array of abbreviated weekday symbols, starting with Monday.
    private static let weekDaysShort: [String] = {
        var weekdays = calendar.shortStandaloneWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday - 1
        return Array(weekdays[firstWeekdayIndex..<weekdays.count] + weekdays[0..<firstWeekdayIndex])
    }()

    private static let monthsShort: [String] = calendar.shortStandaloneMonthSymbols

    /// Returns an array of tuples representing the abbreviated weekday symbols and corresponding day numbers for the current week.
    ///
    /// - Returns: An array of tuples where each tuple contains an abbreviated weekday symbol and the corresponding day number.
    public static func getWeekDaysShort(fromDate: Date = Date()) -> [WeekDaysShort] {
        // Determine the start of the current week
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: fromDate)?.start else {
            return []
        }

        // Create an array of tuples (weekday, date)
        return (0..<7).compactMap { i in
            guard let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) else {
                return nil
            }
            let dayComponent = calendar.component(.day, from: date)
            // isDate сравнение дат без учета времени
            return (weekDaysShort[i], dayComponent, calendar.isDate(date, inSameDayAs: fromDate))
        }
    }

    public static func getThreeDaysOfWeek(fromDate: Date = Date()) -> (first: Date, second: Date, third: Date)? {
        var components = calendar.dateComponents([.year, .month, .day, .weekday], from: fromDate)
        
        guard let todayWeekday = components.weekday else { return nil }
        
        // определить день - понедельник
        let daysToMonday = (9 - todayWeekday) % 7
        // определить день - среда
        let daysToWednesday = (11 - todayWeekday) % 7
        // определить день - пятница
        let daysToFriday = (13 - todayWeekday) % 7
        
        guard let monday = calendar.date(byAdding: .day, value: daysToMonday, to: fromDate),
              let wednesday = calendar.date(byAdding: .day, value: daysToWednesday, to: fromDate),
              let friday = calendar.date(byAdding: .day, value: daysToFriday, to: fromDate) else { return nil }
        
        return (monday, wednesday, friday)
    }

    public static func isDateTodayOrPast(fromDate: Date) -> Bool {
        let today = calendar.startOfDay(for: Date())
        let dateToCheck = calendar.startOfDay(for: fromDate)

        return dateToCheck <= today
    }

    public static func getMonthsShort(fromDate: Date = Date()) -> [MonthsShort] {
        let month = calendar.component(.month, from: fromDate) - 1
        // Create an array of tuples (weekday, date)
        return (0..<10).reversed().compactMap { i in
            var index = month - i
            if index < 0 {
                index += 12
            }
            return (monthsShort[index], false)
        }
    }
}
