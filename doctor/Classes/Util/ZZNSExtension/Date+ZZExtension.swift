//
//  Date+ZZExtension.swift
//  ZZLib
//
//  Created by lixiangzhou on 2017/3/10.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

public extension Date {
    
    /// 返回指定格式的时间字符串
    ///
    /// - parameter format: 时间格式
    ///
    /// 常用格式：
    /// G:          公元时代，例如AD公元
    ///
    /// yy:         年的后2位
    ///
    /// yyyy:       完整年
    ///
    /// MM:         月，显示为1-12,带前置0
    ///
    /// MMM:        月，显示为英文月份简写,如 Jan
    ///
    /// MMMM:       月，显示为英文月份全称，如 Janualy
    ///
    /// dd:         日，2位数表示，如02
    ///
    /// d:          日，1-2位显示，如2，无前置0
    ///
    /// EEE:        简写星期几，如Sun
    ///
    /// EEEE:       全写星期几，如Sunday
    ///
    /// aa:         上下午，AM/PM
    ///
    /// H:          时，24小时制，0-23
    ///
    /// HH:         时，24小时制，带前置0
    ///
    /// h:          时，12小时制，无前置0
    ///
    /// hh:         时，12小时制，带前置0
    ///
    /// m:          分，1-2位
    ///
    /// mm:         分，2位，带前置0
    ///
    /// s:          秒，1-2位
    ///
    /// ss:         秒，2位，带前置0
    ///
    /// S:          毫秒
    ///
    /// Z：          GMT（时区）
    /// - returns: 指定格式的时间字符串
    func zz_string(withDateFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        zz_dateFormatter.dateFormat = format
        return zz_dateFormatter.string(from: self)
    }
}


// MARK: - 获取时间信息
public extension Date {
    
    /// 获取年份
    var zz_year: Int {
        return zz_calendar.component(.year, from: self)
    }
    
    /// 获取月份
    var zz_month: Int {
        return zz_calendar.component(.month, from: self)
    }
    
    /// 获取天
    var zz_day: Int {
        return zz_calendar.component(.day, from: self)
    }
    
    /// 获取小时
    var zz_hour: Int {
        return zz_calendar.component(.hour, from: self)
    }
    
    /// 获取分钟
    var zz_minute: Int {
        return zz_calendar.component(.minute, from: self)
    }
    
    /// 获取秒
    var zz_second: Int {
        return zz_calendar.component(.second, from: self)
    }
    
    /// 获取纳秒
    var zz_nanosecond: Int {
        return zz_calendar.component(.nanosecond, from: self)
    }
    
    /// 获取一周第几天，周日为0
    var zz_weekday: Int {
        return zz_calendar.component(.weekday, from: self)
    }
    
    /// 获取一个月第几周，不包括不完整的第一周在这个月
    var zz_weekdayOrdinal: Int {
        return zz_calendar.component(.weekdayOrdinal, from: self)
    }
    
    /// 获取一个月第几周，包括不完整的第一周在这个月
    var zz_weekOfMonth: Int {
        return zz_calendar.component(.weekOfMonth, from: self)
    }
    
    /// 一年的第几周
    var zz_weekOfYear: Int {
        return zz_calendar.component(.weekOfYear, from: self)
    }
    
    /// 当年有几天
    var zz_daysInYear: Int {
        return zz_calendar.range(of: .day, in: .year, for: self)!.count
    }
    
    /// 当月有几天
    var zz_daysInMonth: Int {
        return zz_calendar.range(of: .day, in: .year, for: self)!.count
    }
    
    /// 是否是同一周
    var zz_isThisWeek: Bool {
        zz_isSameWeek(asDate: Date())
    }
    
    /// 是否是上一周
    var zz_isLastWeek: Bool {
        let newDate = Date(timeIntervalSinceReferenceDate: Date.timeIntervalSinceReferenceDate - Date.WeakSeconds)
        return zz_isSameWeek(asDate: newDate)
    }
    
    /// 是否是下一周
    var zz_isNextWeek: Bool {
        let newDate = Date(timeIntervalSinceReferenceDate: Date.timeIntervalSinceReferenceDate + Date.WeakSeconds)
        return zz_isSameWeek(asDate: newDate)
    }
    
    /// 是否是当月
    var zz_isThisMonth: Bool {
        zz_isThisYear && zz_month == Date().zz_month
    }
    
    /// 是否是上个月
    var zz_isLastMonth: Bool {
        let newDate = zz_date(byAdding: .month, value: 1)!
        return newDate.zz_isThisMonth
    }
    
    /// 是否是下个月
    var zz_isNextMonth: Bool {
        let newDate = zz_date(byAdding: .month, value: -1)!
        return newDate.zz_isThisMonth
    }
    
    /// 是否是当年
    var zz_isThisYear: Bool {
        zz_year == Date().zz_year
    }
    
    /// 是否是明年
    var zz_isNextYear: Bool {
        zz_year == Date().zz_year + 1
    }
    
    /// 是否是去年
    var zz_isLastYear: Bool {
        zz_year == Date().zz_year - 1
    }
    
    /// 是否今天
    var zz_isToday: Bool {
        return zz_calendar.isDateInToday(self)
    }
    
    /// 是否昨天
    var zz_isYestoday: Bool {
        return zz_calendar.isDateInYesterday(self)
    }
    
    /// 是否明天
    var zz_isTomorrow: Bool {
        return zz_calendar.isDateInTomorrow(self)
    }
    
    var zz_isWeekend: Bool {
        return zz_calendar.isDateInWeekend(self)
    }
    
    /// 是否闰年
    var zz_isLeapYear: Bool {
        let year = self.zz_year
        return (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0)
    }
    
    /// 是否是未来
    var zz_isInFuture: Bool {
        zz_isLater(than: Date())
    }
    
    /// 是否是过去
    var zz_isInPast: Bool {
        zz_isEarlier(than: Date())
    }
}


// MARK: - 设置时间
public extension Date {
    fileprivate static let WeakSeconds: Double = 604800
    
    init?(year: Int, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        let components = DateComponents(calendar: Calendar.current, timeZone: .current, year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        if let date = components.date {
            self.init(timeIntervalSince1970: date.timeIntervalSince1970)
        } else {
            return nil
        }
    }
    
    /// 在当前时间基础上添加一定时间
    ///
    /// - parameter component: 时间组件
    /// - parameter value:     时间值
    ///
    /// - returns: 一个新的时间，无法计算时返回 nil
    func zz_date(byAdding component: Calendar.Component, value: Int) -> Date? {
        
        return zz_calendar.date(byAdding: component, value: value, to: self)
    }
    
    
    /// 添加时间
    ///
    /// - parameter components: 时间组件
    ///
    /// - returns: 一个新的时间，无法计算时返回 nil
    func zz_date(byAdding components: DateComponents) -> Date? {
        
        return zz_calendar.date(byAdding: components, to: self)
    }
    
    /// 指定时分秒
    ///
    /// - parameter hour:   hour
    /// - parameter minute: minute
    /// - parameter second: second
    ///
    /// - returns: 一个新的时间，无法计算时返回 nil
    func zz_date(bySetting hour: Int, minute: Int, second: Int) -> Date? {
        return zz_calendar.date(bySettingHour: hour, minute: minute, second: second, of: self)
    }
    
    /// 是否同一天
    ///
    /// - parameter date: 要比较的Date对象
    ///
    /// - returns: 是否同一天
    func zz_isSameDay(asDate date: Date) -> Bool {
        return zz_calendar.isDate(self, inSameDayAs: date)
    }
    
    /// 是否同一周
    ///
    /// - parameter date: 要比较的Date对象
    ///
    /// - returns: 是否同一周
    func zz_isSameWeek(asDate date: Date) -> Bool {
        if zz_weekOfMonth != date.zz_weekOfMonth {
            return false
        }
        
        return abs(timeIntervalSince(date)) < Date.WeakSeconds
    }
    
    /// 是否比指定日期更早
    func zz_isEarlier(than date: Date) -> Bool {
        compare(date) == .orderedAscending
    }
    
    /// 是否比指定日期更晚
    func zz_isLater(than date: Date) -> Bool {
        compare(date) == .orderedDescending
    }
}


// MARK: - 获取月份和星期
public extension Date {
    /// 获取月份
    /// 中文 zh： ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
    /// 英语 en： ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    /// - parameter locale: Locale信息
    ///
    /// - returns: 月份描述
    func zz_monthSymbol(inLocale locale: Locale = Locale.current) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        return calendar.monthSymbols[self.zz_month - 1]
    }
    
    /// 获取月份
    /// 中文 zh： ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
    /// 英文 en： ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    /// - parameter locale: Locale信息
    ///
    /// - returns: 月份描述
    func zz_shortMonthSymbol(inLocale locale: Locale = Locale.current) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        return calendar.shortMonthSymbols[self.zz_month - 1]
    }
    
    /// 获取月份
    /// 中文 zh： ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    /// 英文 en： ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"]
    /// - parameter locale: Locale信息
    ///
    /// - returns: 月份描述
    func zz_veryShortMonthSymbol(inLocale locale: Locale = Locale.current) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        return calendar.veryShortMonthSymbols[self.zz_month - 1]
    }

    
    /// 获取周几
    /// 中文 zh：["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    /// 英文 en：["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    /// - parameter locale: Locale信息
    ///
    /// - returns: 周几描述
    func zz_weekdaySymbol(inLocale locale: Locale = Locale.current) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        return calendar.weekdaySymbols[self.zz_weekday - 1]
    }


    /// 获取周几
    /// 中国 zh：["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    /// 英文 en：["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    /// - parameter locale: Locale信息
    ///
    /// - returns: 周几描述
    func zz_shortWeekdaySymbol(inLocale locale: Locale = Locale.current) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        return calendar.shortWeekdaySymbols[self.zz_weekday - 1]
    }
    
    /// 获取周几
    /// 中文 zh：["日", "一", "二", "三", "四", "五", "六"]
    /// 英文 en：["S", "M", "T", "W", "T", "F", "S"]
    /// - parameter locale: Locale信息
    ///
    /// - returns: 周几描述
    func zz_veryShortWeekdaySymbol(inLocale locale: Locale = Locale.current) -> String {
        var calendar = Calendar.current
        calendar.locale = locale
        return calendar.veryShortWeekdaySymbols[self.zz_weekday - 1]
    }
}

extension Date {
    var zz_tomorrow: Date? {
        zz_date(byAdding: .day, value: 1)
    }
    
    var zz_yesterday: Date? {
        zz_date(byAdding: .day, value: -1)
    }
    
    func zz_dayAfterNow(_ days: Int) -> Date? {
        zz_date(byAdding: .day, value: days)
    }
    
    func zz_dayBeforeNow(_ days: Int) -> Date? {
        zz_date(byAdding: .day, value: -days)
    }
    
    func zz_hourAfterNow(_ hours: Int) -> Date? {
        zz_date(byAdding: .hour, value: hours)
    }
    
    func zz_hourBeforeNow(_ hours: Int) -> Date? {
        zz_date(byAdding: .hour, value: -hours)
    }
    
    func zz_minuteAfterNow(_ minutes: Int) -> Date? {
        zz_date(byAdding: .minute, value: minutes)
    }
    
    func zz_minuteBeforeNow(_ minutes: Int) -> Date? {
        zz_date(byAdding: .minute, value: -minutes)
    }
}

extension Date {
    func zz_string(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let df = DateFormatter()
        df.dateStyle = dateStyle
        df.timeStyle = timeStyle
        return df.string(from: self)
    }
    
    var zz_shortString: String {
        zz_string(dateStyle: .short, timeStyle: .short)
    }
    
    var zz_shortDateString: String {
        zz_string(dateStyle: .short, timeStyle: .none)
    }
    
    var zz_shortTimeString: String {
        zz_string(dateStyle: .none, timeStyle: .short)
    }
    
    var zz_mediumString: String {
        zz_string(dateStyle: .medium, timeStyle: .medium)
    }
    
    var zz_mediumDateString: String {
        zz_string(dateStyle: .medium, timeStyle: .none)
    }
    
    var zz_mediumTimeString: String {
        zz_string(dateStyle: .none, timeStyle: .medium)
    }
    
    var zz_longString: String {
        zz_string(dateStyle: .long, timeStyle: .long)
    }
    
    var zz_longDateString: String {
        zz_string(dateStyle: .long, timeStyle: .none)
    }
    
    var zz_longTimeString: String {
        zz_string(dateStyle: .none, timeStyle: .long)
    }
}
