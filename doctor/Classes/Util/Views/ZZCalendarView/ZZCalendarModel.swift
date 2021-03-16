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
}

struct DayModel {
    var year: Int
    var month: Int
    var day: Int
    var weekday: Int
    var weekOfMonth: Int
    var date: Date
    
    var state: DayState
    
    var isToday: Bool {
        date.zz_isToday
    }
}

enum DayState {
    case normal
    case start
    case end
    case select
}
