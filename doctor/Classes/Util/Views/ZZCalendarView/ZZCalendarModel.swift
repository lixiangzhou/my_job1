//
//  ZZCalendarModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//

import Foundation

struct MonthModel {
    var year: Int
    var month: Int
    var weekday: Int
    var date: Date
    
    var days: [DayModel]
    
    var description: String {
        return "\(year)-\(month)"
    }
}

struct DayModel: CustomStringConvertible {
    var year: Int
    var month: Int
    var day: Int
    var weekday: Int
    var weekOfMonth: Int
    var date: Date
    
    var isToday: Bool {
        date.zz_isToday
    }
    
    var description: String {
        return "\(year)-\(month)-\(day)"
    }
    
    static func dayModel(year: Int, month: Int, day: Int) -> DayModel {
        let date = Date(year: year, month: month, day: day, hour: 8)!
        return DayModel(year: year, month: month, day: day, weekday: date.zz_weekday, weekOfMonth: date.zz_weekOfMonth, date: date)
    }
}

enum DayState {
    case normal
    case start
    case end
    case select
}
