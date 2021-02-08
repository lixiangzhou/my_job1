//
//  ZZDatePicker.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/5.
//  
//

import UIKit

class ZZDatePicker: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    let pickerView = UIPickerView()
    var config: Config = Config() {
        didSet {
            reloadData()
        }
    }
    
    var selectDateClosure: ((Date) -> Void)?
    
    var viewForRowInComponentClosure: ((_ component: Int, _ row: Int, _ unit: DateStyle.Unit, _ value: Int) -> UIView)?
    
    // MARK: - Private Property
    private var years = [Int]()
    private var months = [Int]()
    private var days = [Int]()
    private var hours = [Int]()
    private var minutes = [Int]()
    private var seconds = [Int]()
    
    private var minDateMonths = [Int]()
    private var maxDateMonths = [Int]()
    
    private var minDateDays = [Int]()
    private var maxDateDays = [Int]()
    
    private var minDateHours = [Int]()
    private var maxDateHours = [Int]()
    
    private var minDateMinutes = [Int]()
    private var maxDateMinutes = [Int]()
    
    private var minDateSeconds = [Int]()
    private var maxDateSeconds = [Int]()

    private let defaultMonths = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private let defaultHours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
                                12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    private var defaultMinutes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                  10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
                                  20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
                                  30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
                                  40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
                                  50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
    private var defaultSeconds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                  10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
                                  20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
                                  30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
                                  40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
                                  50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
    
}

// MARK: - UI
extension ZZDatePicker {
    private func setUI() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = false
        pickerView.backgroundColor = .orange
        addSubview(pickerView)
        
        reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pickerView.frame = bounds
    }
}

// MARK: - Delegate
extension ZZDatePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        config.dateStyle.columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getDataSource(in: component).count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        config.rowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        refreshDataSource()
        
        let unit = unitForComponent(component)
        updateSelectDate(unit, in: row)
        
        fixSelectDate()
        
        pickerView.reloadAllComponents()
        
        showSelectDate()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let unit = unitForComponent(component)
        let dataSource = getDataSource(in: component)
        
        let value = dataSource[row]
        
        if let view = viewForRowInComponentClosure?(component, row, unit, value)  {
            return view
        }
        
        var txt = ""
        switch unit {
        case .year:
            txt = String(format: "%04d\(config.yearUnit)", value)
        case .month:
            txt = String(format: "%02d\(config.monthUnit)", value)
        case .day:
            txt = String(format: "%02d\(config.dayUnit)", value)
        case .hour:
            txt = String(format: "%02d\(config.hourUnit)", value)
        case .minute:
            txt = String(format: "%02d\(config.minuteUnit)", value)
        case .second:
            txt = String(format: "%02d\(config.secondUnit)", value)
        default:
            break
        }
        
        return UILabel(text: txt, font: config.txtFont, textColor: config.txtColor)
    }
    
    // MARK:
    private func getDataSource(in component: Int) -> [Int] {
        let unit = unitForComponent(component)
        switch unit {
        case .year:
            return years
        case .month:
            return months
        case .day:
            return days
        case .hour:
            return hours
        case .minute:
            return minutes
        case .second:
            return seconds
        default:
            return []
        }
    }
    
    private func updateSelectDate(_ unit: DateStyle.Unit, in row: Int) {
        switch unit {
        case .year:
            updateSelectDate(byAdding: .year, value: years[row] - config.selectDateYear)
        case .month:
            updateSelectDate(byAdding: .month, value: months[row] - config.selectDateMonth)
        case .day:
            updateSelectDate(byAdding: .day, value: days[row] - config.selectDateDay)
        case .hour:
            updateSelectDate(byAdding: .hour, value: hours[row] - config.selectDateHour)
        case .minute:
            updateSelectDate(byAdding: .minute, value: minutes[row] - config.selectDateMinute)
        case .second:
            updateSelectDate(byAdding: .second, value: seconds[row] - config.selectDateSecond)
        default:
            break
        }
    }
    
    private func unitForComponent(_ component: Int) -> DateStyle.Unit {
        let units = config.dateStyle.units
        var idx = -1
        if units.contains(.year) {
            idx += 1
            if idx == component {
                return .year
            }
        }
        if units.contains(.month) {
            idx += 1
            if idx == component {
                return .month
            }
        }
        if units.contains(.day) {
            idx += 1
            if idx == component {
                return .day
            }
        }
        if units.contains(.hour) {
            idx += 1
            if idx == component {
                return .hour
            }
        }
        if units.contains(.minute) {
            idx += 1
            if idx == component {
                return .minute
            }
        }
        if units.contains(.second) {
            idx += 1
            if idx == component {
                return .second
            }
        }
        return []
    }
}

// MARK: - PrepareMinMaxAndColumn
extension ZZDatePicker {
    
    /// 准备初始化最大最小值及列数
    private func prepareMinMaxAndColumn() {
        let units = config.dateStyle.units
        if units.contains(.year) {
            prepareYears()
        }
        if units.contains(.month) {
            prepareMonths()
        }
        if units.contains(.hour) {
            prepareHours()
        }
        if units.contains(.minute) {
            prepareMinutes()
        }
        if units.contains(.second) {
            prepareSeconds()
        }
    }
    
    private func prepareYears() {
        years.removeAll()
        let range = config.minDate.zz_year...config.maxDate.zz_year
        for y in range {
            years.append(y)
        }
    }
    
    private func prepareMonths() {
        minDateMonths.removeAll()
        maxDateMonths.removeAll()
        
        if config.minDateYear == config.maxDateYear {
            let range = config.minDateMonth...config.maxDateMonth
            for m in range {
                minDateMonths.append(m)
                maxDateMonths.append(m)
            }
        } else {
            let minRange = config.minDate.zz_month...12
            for m in minRange {
                minDateMonths.append(m)
            }
            
            let maxRange = 1...config.maxDate.zz_month
            for m in maxRange {
                maxDateMonths.append(m)
            }
        }
    }
    
    private func prepareHours() {
        minDateHours.removeAll()
        maxDateHours.removeAll()
        
        if config.minDateYear == config.maxDateYear &&
            config.minDateMonth == config.maxDateMonth &&
            config.minDateDay == config.maxDateDay {
            
            let range = config.minDateHour...config.maxDateHour
            for h in range {
                minDateHours.append(h)
                maxDateHours.append(h)
            }
        } else {
            let minRange = config.minDate.zz_hour...23
            for h in minRange {
                minDateHours.append(h)
            }
            
            let maxRange = 0...config.maxDate.zz_hour
            for h in maxRange {
                maxDateHours.append(h)
            }
        }
    }
    
    private func prepareMinutes() {
        minDateMinutes.removeAll()
        maxDateMinutes.removeAll()
        
        if config.minDateYear == config.maxDateYear &&
            config.minDateMonth == config.maxDateMonth &&
            config.minDateDay == config.minDateDay &&
            config.minDateHour == config.minDateHour {
            
            let range = config.minDateMinute...config.maxDateMinute
            for m in range {
                minDateMinutes.append(m)
                maxDateMinutes.append(m)
            }
        } else {
            let minRange = config.minDate.zz_minute...59
            for m in minRange {
                minDateMinutes.append(m)
            }
            
            let maxRange = 0...config.maxDate.zz_minute
            for m in maxRange {
                maxDateMinutes.append(m)
            }
        }
    }
    
    private func prepareSeconds() {
        minDateSeconds.removeAll()
        maxDateSeconds.removeAll()
        
        if config.minDateYear == config.maxDateYear &&
            config.minDateMonth == config.maxDateMonth &&
            config.minDateDay == config.minDateDay &&
            config.minDateHour == config.minDateHour {
            
            let range = config.minDateSecond...config.maxDateSecond
            for s in range {
                minDateSeconds.append(s)
                maxDateSeconds.append(s)
            }
        } else {
            let minRange = config.minDate.zz_second...59
            for s in minRange {
                minDateSeconds.append(s)
            }
            
            let maxRange = 0...config.maxDate.zz_second
            for s in maxRange {
                maxDateSeconds.append(s)
            }
        }
    }
}

// MARK: - RefreshDataSource
extension ZZDatePicker {
    private func refreshDataSource() {
        let units = config.dateStyle.units
        
        if units.contains(.month) {
            refreshMonthData()
        }
        if units.contains(.day) {
            refreshDayData()
        }
        if units.contains(.hour) {
            refreshHourData()
        }
        if units.contains(.minute) {
            refreshMinuteData()
        }
        if units.contains(.second) {
            refreshSecondData()
        }
    }
    
    private func refreshMonthData() {
        if config.selectDateYear == config.minDateYear {
            months = minDateMonths
        } else if config.selectDateYear == config.maxDateYear {
            months = maxDateMonths
        } else {
            months = defaultMonths
        }
    }
    
    private func refreshDayData() {
        days.removeAll()
        
        let boundary = getDayBoundary()
        let range = boundary.start...boundary.end
        
        for d in range {
            days.append(d)
        }
    }
    
    private func refreshHourData() {
        if config.selectDateYear == config.minDateYear &&
            config.selectDateMonth == config.minDateMonth &&
            config.selectDateDay == config.minDateDay {
            
            hours = minDateHours
        } else if config.selectDateYear == config.maxDateYear &&
                    config.selectDateMonth == config.maxDateMonth &&
                    config.selectDateDay == config.maxDateDay {
            
            hours = maxDateHours
        } else {
            hours = defaultHours
        }
    }
    
    private func refreshMinuteData() {
        if config.selectDateYear == config.minDateYear &&
            config.selectDateMonth == config.minDateMonth &&
            config.selectDateDay == config.minDateDay &&
            config.selectDateHour == config.minDateHour {
            
            minutes = minDateMinutes
        } else if config.selectDateYear == config.maxDateYear &&
                    config.selectDateMonth == config.maxDateMonth &&
                    config.selectDateDay == config.maxDateDay &&
                    config.selectDateHour == config.maxDateHour {
            
            minutes = maxDateMinutes
        } else {
            minutes = defaultMinutes
        }
    }
    
    private func refreshSecondData() {
        if config.selectDateYear == config.minDateYear &&
            config.selectDateMonth == config.minDateMonth &&
            config.selectDateDay == config.minDateDay &&
            config.selectDateHour == config.minDateHour &&
            config.selectDateMinute == config.minDateMinute {
            
            seconds = minDateSeconds
        } else if config.selectDateYear == config.maxDateYear &&
                    config.selectDateMonth == config.maxDateMonth &&
                    config.selectDateDay == config.maxDateDay &&
                    config.selectDateHour == config.maxDateHour &&
                    config.selectDateMinute == config.maxDateMinute {
            
            seconds = maxDateSeconds
        } else {
            seconds = defaultSeconds
        }
    }
}

// MARK: - ReloadData
extension ZZDatePicker {
    func reloadData() {
        processMinMaxDate()
        prepareMinMaxAndColumn()
        refreshDataSource()
        showSelectDate()
    }
    
    private func processMinMaxDate() {
        let units = config.dateStyle.units
        if units.contains(.year) {
            let minInterval = config.selectDate.timeIntervalSince1970
            let selectInterval = config.selectDate.timeIntervalSince1970
            let maxInterval = config.selectDate.timeIntervalSince1970
            
            if minInterval > selectInterval {
                config.minDate = Date(year: 1900, month: 1, day: 1, hour: 0, minute: 0, second: 0)!
            }
            
            if maxInterval < selectInterval {
                config.maxDate = Date(year: 2099, month: 12, day: 31, hour: 23, minute: 59, second: 59)!
            }
            
        } else if units.contains(.month) {
            if config.minDateYear != config.maxDateYear {
                config.minDate = Date(year: config.selectDateYear)!
                config.maxDate = Date(year: config.selectDateYear, month: 12, day: 31, hour: 23, minute: 59, second: 59)!
            }
        } else if units.contains(.day) {
            if !(config.minDateYear == config.maxDateYear && config.minDateMonth == config.maxDateMonth) {
                let day = maxDaysFor(config.selectDateYear, month: config.selectDateMonth)
                config.minDate = Date(year: config.selectDateYear, month: config.selectDateMonth)!
                config.maxDate = Date(year: config.selectDateYear, month: config.selectDateMonth, day: day, hour: 23, minute: 59, second: 59)!
            }
        } else if units.contains(.hour) {
            if !(config.minDateYear == config.maxDateYear && config.minDateMonth == config.maxDateMonth && config.minDateDay == config.maxDateDay) {
                config.minDate = Date(year: config.selectDateYear, month: config.selectDateMonth, day: config.selectDateDay)!
                config.maxDate = Date(year: config.selectDateYear, month: config.selectDateMonth, day: config.selectDateDay, hour: 23, minute: 59, second: 59)!
            }
        } else if units.contains(.minute) {
            if !(config.minDateYear == config.maxDateYear && config.minDateMonth == config.maxDateMonth && config.minDateDay == config.maxDateDay && config.minDateHour == config.maxDateHour) {
                config.minDate = Date(year: config.selectDateYear, month: config.selectDateMonth, day: config.selectDateDay, hour: config.selectDateHour)!
                config.maxDate = Date(year: config.selectDateYear, month: config.selectDateMonth, day: config.selectDateDay, hour: config.selectDateHour, minute: 59, second: 59)!
            }
        } else if units.contains(.second) {
            if !(config.minDateYear == config.maxDateYear && config.minDateMonth == config.maxDateMonth && config.minDateDay == config.maxDateDay && config.minDateHour == config.maxDateHour && config.minDateMinute != config.maxDateMinute) {
                config.minDate = Date(year: config.selectDateYear, month: config.selectDateMonth, day: config.selectDateDay, hour: config.selectDateHour, minute: config.selectDateMinute)!
                config.maxDate = Date(year: config.selectDateYear, month: config.selectDateMonth, day: config.selectDateDay, hour: config.selectDateHour, minute: config.selectDateMinute, second: 59)!
            }
        }
    }
    
    private func showSelectDate() {
        if isScrollIngInView(pickerView) {
            return
        }
        
        var idxArray = [Int]()
        
        func appendYearIndex() {
            let idx = config.selectDateYear - config.minDateYear
            idxArray.append(idx)
        }
        
        func appendMonthIndex() {
            let idx: Int
            if config.selectDateYear == config.minDateYear {
                idx = config.selectDateMonth - config.minDateMonth
            } else {
                idx = config.selectDateMonth - 1
            }
            
            idxArray.append(idx)
        }
        
        func appendDayIndex() {
            let idx: Int
            
            if config.selectDateYear == config.minDateYear &&
                config.selectDateMonth == config.minDateMonth {
                
                idx = config.selectDateDay - config.minDateDay
            } else {
                idx = config.selectDateDay - 1
            }
            
            idxArray.append(idx)
        }
        
        func appendHourIndex() {
            let idx: Int
            
            if config.selectDateYear == config.minDateYear &&
                config.selectDateMonth == config.minDateMonth &&
                config.selectDateDay == config.minDateDay {
                
                idx = config.selectDateHour - config.minDateHour
            } else {
                idx = config.selectDateHour
            }
            
            idxArray.append(idx)
        }
        
        func appendMinuteIndex() {
            let idx: Int
            
            if config.selectDateYear == config.minDateYear &&
                config.selectDateMonth == config.minDateMonth &&
                config.selectDateDay == config.minDateDay &&
                config.selectDateHour == config.minDateHour {
                
                idx = config.selectDateMinute - config.minDateMinute
            } else {
                idx = config.selectDateMinute
            }
            
            idxArray.append(idx)
        }
        
        func appendSecondIndex() {
            let idx: Int
            
            if config.selectDateYear == config.minDateYear &&
                config.selectDateMonth == config.minDateMonth &&
                config.selectDateDay == config.minDateDay &&
                config.selectDateHour == config.minDateHour &&
                config.selectDateMinute == config.minDateMinute {
                
                idx = config.selectDateSecond - config.minDateSecond
            } else {
                idx = config.selectDateSecond
            }
            
            idxArray.append(idx)
        }
        
        let units = config.dateStyle.units
        if units.contains(.year) {
            appendYearIndex()
        }
        if units.contains(.month) {
            appendMonthIndex()
        }
        if units.contains(.day) {
            appendDayIndex()
        }
        if units.contains(.hour) {
            appendHourIndex()
        }
        if units.contains(.minute) {
            appendMinuteIndex()
        }
        if units.contains(.second) {
            appendSecondIndex()
        }
        
        for (column, row) in idxArray.enumerated() {
            pickerView.selectRow(row, inComponent: column, animated: true)
        }
        
        if !isScrollIngInView(pickerView) {
            selectDateClosure?(config.selectDate)
        }
    }
}

// MARK: - Helper
extension ZZDatePicker {
    private func fixSelectDate() {
        func fixSelectMonth() {
            var delta: Int?
            if config.selectDateYear == config.maxDateYear &&
                config.selectDateMonth > config.maxDateMonth {
                
                delta = config.maxDateMonth - config.selectDateMonth
            } else if config.selectDateYear == config.minDateYear &&
                        config.selectDateMonth < config.minDateMonth {
                
                delta = config.minDateMonth - config.selectDateMonth
            }
            
            if let delta = delta {
                updateSelectDate(byAdding: .month, value: delta)
            }
        }
        
        func fixSelectDay() {
            var delta: Int?
            if config.selectDateYear == config.maxDateYear &&
                config.selectDateMonth == config.maxDateMonth &&
                config.selectDateDay > config.maxDateDay {
                
                delta = config.maxDateDay - config.selectDateDay
            } else if config.selectDateYear == config.minDateYear &&
                        config.selectDateMonth == config.minDateMonth &&
                        config.selectDateDay < config.minDateDay {
                
                delta = config.minDateDay - config.selectDateDay
            }
            
            if let delta = delta {
                updateSelectDate(byAdding: .day, value: delta)
            }
        }
        
        func fixSelectHour() {
            var delta: Int?
            if config.selectDateYear == config.maxDateYear &&
                config.selectDateMonth == config.maxDateMonth &&
                config.selectDateDay == config.maxDateDay &&
                config.selectDateHour > config.maxDateHour {
                
                delta = config.maxDateHour - config.selectDateHour
            } else if config.selectDateYear == config.minDateYear &&
                        config.selectDateMonth == config.minDateMonth &&
                        config.selectDateDay == config.minDateDay &&
                        config.selectDateHour < config.minDateHour {
                
                delta = config.minDateHour - config.selectDateHour
            }
            
            if let delta = delta {
                updateSelectDate(byAdding: .hour, value: delta)
            }
        }
        
        func fixSelectMinute() {
            var delta: Int?
            if config.selectDateYear == config.maxDateYear &&
                config.selectDateMonth == config.maxDateMonth &&
                config.selectDateDay == config.maxDateDay &&
                config.selectDateHour == config.maxDateHour &&
                config.selectDateMinute > config.maxDateMinute {
                
                delta = config.maxDateMinute - config.selectDateMinute
            } else if config.selectDateYear == config.minDateYear &&
                        config.selectDateMonth == config.minDateMonth &&
                        config.selectDateDay == config.minDateDay &&
                        config.selectDateHour == config.minDateHour &&
                        config.selectDateMinute < config.minDateMinute {
                
                delta = config.minDateMinute - config.selectDateMinute
            }
            
            if let delta = delta {
                updateSelectDate(byAdding: .minute, value: delta)
            }
        }
        
        func fixSelectSecond() {
            var delta: Int?
            if config.selectDateYear == config.maxDateYear &&
                config.selectDateMonth == config.maxDateMonth &&
                config.selectDateDay == config.maxDateDay &&
                config.selectDateHour == config.maxDateHour &&
                config.selectDateMinute == config.maxDateMinute &&
                config.selectDateSecond > config.maxDateSecond {
                
                delta = config.maxDateSecond - config.selectDateSecond
            } else if config.selectDateYear == config.minDateYear &&
                        config.selectDateMonth == config.minDateMonth &&
                        config.selectDateDay == config.minDateDay &&
                        config.selectDateHour == config.minDateHour &&
                        config.selectDateMinute == config.minDateMinute &&
                        config.selectDateSecond < config.minDateSecond {
                
                delta = config.minDateSecond - config.selectDateSecond
            }
            
            if let delta = delta {
                updateSelectDate(byAdding: .second, value: delta)
            }
        }
        
        let units = config.dateStyle.units
        if units.contains(.month) {
            fixSelectMonth()
        }
        if units.contains(.day) {
            fixSelectDay()
        }
        if units.contains(.hour) {
            fixSelectHour()
        }
        if units.contains(.minute) {
            fixSelectMinute()
        }
        if units.contains(.second) {
            fixSelectSecond()
        }
    }
    
    private func updateSelectDate(byAdding component: Calendar.Component, value: Int) {
        config.selectDate = config.selectDate.zz_date(byAdding: component, value: value)!
    }
    
    private func getDayBoundary() -> (start: Int, end: Int) {
        let startDay: Int
        let endDay: Int
        
        if config.minDateYear == config.maxDateYear &&
            config.minDateMonth == config.maxDateMonth { // 最小日期和最大日期是同年同月的情况
            
            startDay = config.minDateDay
            endDay = config.maxDateDay
        } else if config.selectDateYear == config.minDateYear &&
            config.selectDateMonth == config.minDateMonth { // 选择的日期与最小日期同年同月的情况
            
            startDay = config.minDateDay
            endDay = maxDaysFor(config.selectDateYear, month: config.selectDateMonth)
        } else if config.selectDateYear == config.maxDateYear &&
                    config.selectDateMonth == config.maxDateMonth { // 选择的日期与最大日期同年同月的情况
            
            startDay = 1
            endDay = config.maxDateDay
        } else {    // 其他情况
            startDay = 1
            endDay = maxDaysFor(config.selectDateYear, month: config.selectDateMonth)
        }
        
        return (startDay, endDay)
    }
    
    private func isScrollIngInView(_ view: UIView) -> Bool {
        if let scrollView = view as? UIScrollView {
            return scrollView.isDragging || scrollView.isDecelerating
        }
        
        for sub in view.subviews {
            if isScrollIngInView(sub) {
                return true
            }
        }
        return false
    }
}

extension ZZDatePicker {
    class Config {
        /// 行高
        var rowHeight: CGFloat = 40
        /// 显示样式
        var dateStyle: DateStyle = .HH_mm
        
        var yearUnit = "年"
        var monthUnit = "月"
        var dayUnit = "日"
        var hourUnit = "时"
        var minuteUnit = "分"
        var secondUnit = "秒"
        
        var txtFont: UIFont = .size(15)
        var txtColor: UIColor = UIColor.black
        
        /// 最早日期（默认是1900）
        var minDate: Date = Date(year: 1900, month: 1, day: 1, hour: 0, minute: 0, second: 0)!
        /// 最大日期（默认是2099）
        var maxDate: Date = Date(year: 2099, month: 12, day: 31, hour: 23, minute: 59, second: 59)!
        /// 开始时的显示时间（默认当前时间）
        var selectDate = Date()
    }
    
    enum DateStyle {
        case yyyy
        case yyyy_MM
        case yyyy_MM_dd
        case yyyy_MM_dd_HH
        case yyyy_MM_dd_HH_mm
        case yyyy_MM_dd_HH_mm_ss
        
        case MM
        case MM_dd
        case MM_dd_HH
        case MM_dd_HH_mm
        case MM_dd_HH_mm_ss
        
        case dd
        case dd_HH
        case dd_HH_mm
        case dd_HH_mm_ss
        
        case HH
        case HH_mm
        case HH_mm_ss
        
        case mm
        case mm_ss
        
        case ss
        
        var units: Unit {
            switch self {
            case .yyyy:
                return [Unit.year]
            case .yyyy_MM:
                return [Unit.year, Unit.month]
            case .yyyy_MM_dd:
                return [Unit.year, Unit.month, Unit.day]
            case .yyyy_MM_dd_HH:
                return [Unit.year, Unit.month, Unit.day, Unit.hour]
            case .yyyy_MM_dd_HH_mm:
                return [Unit.year, Unit.month, Unit.day, Unit.hour, Unit.minute]
            case .yyyy_MM_dd_HH_mm_ss:
                return [Unit.year, Unit.month, Unit.day, Unit.hour, Unit.minute, Unit.second]
                
            case .MM:
                return [Unit.month]
            case .MM_dd:
                return [Unit.month, Unit.day]
            case .MM_dd_HH:
                return [Unit.month, Unit.day, Unit.hour]
            case .MM_dd_HH_mm:
                return [Unit.month, Unit.day, Unit.hour, Unit.minute]
            case .MM_dd_HH_mm_ss:
                return [Unit.month, Unit.day, Unit.hour, Unit.minute, Unit.second]
                
            case .dd:
                return [Unit.day]
            case .dd_HH:
                return [Unit.day, Unit.hour]
            case .dd_HH_mm:
                return [Unit.day, Unit.hour, Unit.minute]
            case .dd_HH_mm_ss:
                return [Unit.day, Unit.hour, Unit.minute, Unit.second]
                
            case .HH:
                return [Unit.hour]
            case .HH_mm:
                return [Unit.hour, Unit.minute]
            case .HH_mm_ss:
                return [Unit.hour, Unit.minute, Unit.second]
                
            case .mm:
                return [Unit.minute]
            case .mm_ss:
                return [Unit.minute, Unit.second]
                
            case .ss:
                return [Unit.second]
            }
        }
        
        var columns: Int {
            switch self {
            case .yyyy, .MM, .dd, .HH, .mm, .ss:
                return 1
            case .yyyy_MM, .MM_dd, .dd_HH, .HH_mm, .mm_ss:
                return 2
            case .yyyy_MM_dd, .MM_dd_HH, .dd_HH_mm, .HH_mm_ss:
                return 3
            case .yyyy_MM_dd_HH, .MM_dd_HH_mm, .dd_HH_mm_ss:
                return 4
            case .yyyy_MM_dd_HH_mm, .MM_dd_HH_mm_ss:
                return 5
            case .yyyy_MM_dd_HH_mm_ss:
                return 6
            }
        }
        
        struct Unit: OptionSet {
            let rawValue: Int
            
            static let year = Unit(rawValue: 1 << 0)
            static let month = Unit(rawValue: 1 << 1)
            static let day = Unit(rawValue: 1 << 2)
            static let hour = Unit(rawValue: 1 << 3)
            static let minute = Unit(rawValue: 1 << 4)
            static let second = Unit(rawValue: 1 << 5)
        }
    }
}

extension ZZDatePicker.Config {
    fileprivate var minDateYear: Int { minDate.zz_year }
    fileprivate var minDateMonth: Int { minDate.zz_month }
    fileprivate var minDateDay: Int { minDate.zz_day }
    fileprivate var minDateHour: Int { minDate.zz_hour }
    fileprivate var minDateMinute: Int { minDate.zz_minute }
    fileprivate var minDateSecond: Int { minDate.zz_second }
    
    fileprivate var selectDateYear: Int { selectDate.zz_year }
    fileprivate var selectDateMonth: Int { selectDate.zz_month }
    fileprivate var selectDateDay: Int { selectDate.zz_day }
    fileprivate var selectDateHour: Int { selectDate.zz_hour }
    fileprivate var selectDateMinute: Int { selectDate.zz_minute }
    fileprivate var selectDateSecond: Int { selectDate.zz_second }
    
    fileprivate var maxDateYear: Int { maxDate.zz_year }
    fileprivate var maxDateMonth: Int { maxDate.zz_month }
    fileprivate var maxDateDay: Int { maxDate.zz_day }
    fileprivate var maxDateHour: Int { maxDate.zz_hour }
    fileprivate var maxDateMinute: Int { maxDate.zz_minute }
    fileprivate var maxDateSecond: Int { maxDate.zz_second }
}

private func maxDaysFor(_ year: Int, month: Int) -> Int {
    switch month {
    case 1, 3, 5, 7, 8, 10, 12:
        return 31
    case 4, 6, 9, 11:
        return 30
    case 2:
        let isLeap = (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0)
        return isLeap ? 29 : 28
    default:
        return 0
    }
}
