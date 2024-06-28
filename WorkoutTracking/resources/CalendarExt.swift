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

    /// A calendar instance with Monday as the first day of the week.
    private static let calendar: Calendar = {
        var calendar = Calendar.current
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
            return (weekDaysShort[i], dayComponent, isDatesEqual(date, fromDate))
        }
    }

    /// Сравнивает две даты без учета времени.
    ///
    /// - Parameters:
    ///   - date1: Первая дата для сравнения.
    ///   - date2: Вторая дата для сравнения.
    /// - Returns: `true`, если даты равны без учета времени; `false` в противном случае.
    static func isDatesEqual(_ date1: Date, _ date2: Date) -> Bool {
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        return components1 == components2
    }
}
