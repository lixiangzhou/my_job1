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
            if config.validateOK {
                prepareMinMaxAndColumn()
                refreshDataSource()
                showSelectDate()
            }
        }
    }
    
    var selectDateClosure: ((Date) -> Void)?
    
    var viewForRowInComponentClosure: ((_ row: Int, _ component: Int, _ value: Int) -> UIView)?
    
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
    
    private var columns = 0
    
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
        
        if config.validateOK {
            prepareMinMaxAndColumn()
            refreshDataSource()
            showSelectDate()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pickerView.frame = bounds
    }
}

// MARK: - Delegate
extension ZZDatePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch config.dateStyle {
        case .yyyy:
            return years.count
        case .yyyy_MM:
            if component == 0 {
                return years.count
            } else {
                return months.count
            }
        case .yyyy_MM_dd:
            if component == 0 {
                return years.count
            } else if component == 1 {
                return months.count
            } else if component == 2 {
                return days.count
            }
        case .yyyy_MM_dd_HH:
            if component == 0 {
                return years.count
            } else if component == 1 {
                return months.count
            } else if component == 2 {
                return days.count
            } else if component == 3 {
                return hours.count
            }
        case .yyyy_MM_dd_HH_mm:
            if component == 0 {
                return years.count
            } else if component == 1 {
                return months.count
            } else if component == 2 {
                return days.count
            } else if component == 3 {
                return hours.count
            } else if component == 4 {
                return minutes.count
            }
        case .yyyy_MM_dd_HH_mm_ss:
            if component == 0 {
                return years.count
            } else if component == 1 {
                return months.count
            } else if component == 2 {
                return days.count
            } else if component == 3 {
                return hours.count
            } else if component == 4 {
                return minutes.count
            } else if component == 5 {
                return seconds.count
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        config.rowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        refreshDataSource()
        
        func updateYear() {
            updateSelectDate(byAdding: .year, value: years[row] - config.selectDateYear)
        }
        
        func updateMonth() {
            updateSelectDate(byAdding: .month, value: months[row] - config.selectDateMonth)
        }

        func updateDay() {
            updateSelectDate(byAdding: .day, value: days[row] - config.selectDateDay)
        }
        
        func updateHour() {
            updateSelectDate(byAdding: .hour, value: hours[row] - config.selectDateHour)
        }
        
        func updateMinute() {
            updateSelectDate(byAdding: .minute, value: minutes[row] - config.selectDateMinute)
        }

        func updateSecond() {
            updateSelectDate(byAdding: .second, value: seconds[row] - config.selectDateSecond)
        }

        switch config.dateStyle {
        case .yyyy:
            updateYear()
        case .yyyy_MM:
            if component == 0 {
                updateYear()
            } else if component == 1 {
                updateMonth()
            }
        case .yyyy_MM_dd:
            if component == 0 {
                updateYear()
            } else if component == 1 {
                updateMonth()
            } else if component == 2 {
                updateDay()
            }
        case .yyyy_MM_dd_HH:
            if component == 0 {
                updateYear()
            } else if component == 1 {
                updateMonth()
            } else if component == 2 {
                updateDay()
            } else if component == 3 {
                updateHour()
            }
        case .yyyy_MM_dd_HH_mm:
            if component == 0 {
                updateYear()
            } else if component == 1 {
                updateMonth()
            } else if component == 2 {
                updateDay()
            } else if component == 3 {
                updateHour()
            } else if component == 4 {
                updateMinute()
            }
        case .yyyy_MM_dd_HH_mm_ss:
            if component == 0 {
                updateYear()
            } else if component == 1 {
                updateMonth()
            } else if component == 2 {
                updateDay()
            } else if component == 3 {
                updateHour()
            } else if component == 4 {
                updateMinute()
            } else if component == 5 {
                updateSecond()
            }
        }
        
        fixSelectDate()
        
        pickerView.reloadAllComponents()
        
        showSelectDate()
        
        selectDateClosure?(config.selectDate)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var txt = ""
        var value = 0
        func setYearTxt() {
            value = years[row]
            txt = String(format: "%04d\(config.yearUnit)", years[row])
        }
        
        func setMonthTxt() {
            value = months[row]
            txt = String(format: "%02d\(config.monthUnit)", months[row])
        }
        
        func setDayTxt() {
            value = days[row]
            txt = String(format: "%02d\(config.dayUnit)", days[row])
        }
        
        func setHourTxt() {
            value = hours[row]
            txt = String(format: "%02d\(config.hourUnit)", hours[row])
        }
        
        func setMinuteTxt() {
            value = minutes[row]
            txt = String(format: "%02d\(config.minuteUnit)", minutes[row])
        }
        
        func setSecondTxt() {
            value = seconds[row]
            txt = String(format: "%02d\(config.secondUnit)", seconds[row])
        }
        
        switch config.dateStyle {
        case .yyyy:
            setYearTxt()
        case .yyyy_MM:
            if component == 0 {
                setYearTxt()
            } else if component == 1 {
                setMonthTxt()
            }
        case .yyyy_MM_dd:
            if component == 0 {
                setYearTxt()
            } else if component == 1 {
                setMonthTxt()
            } else if component == 2 {
                setDayTxt()
            }
        case .yyyy_MM_dd_HH:
            if component == 0 {
                setYearTxt()
            } else if component == 1 {
                setMonthTxt()
            } else if component == 2 {
                setDayTxt()
            } else if component == 3 {
                setHourTxt()
            }
        case .yyyy_MM_dd_HH_mm:
            if component == 0 {
                setYearTxt()
            } else if component == 1 {
                setMonthTxt()
            } else if component == 2 {
                setDayTxt()
            } else if component == 3 {
                setHourTxt()
            } else if component == 4 {
                setMinuteTxt()
            }
        case .yyyy_MM_dd_HH_mm_ss:
            if component == 0 {
                setYearTxt()
            } else if component == 1 {
                setMonthTxt()
            } else if component == 2 {
                setDayTxt()
            } else if component == 3 {
                setHourTxt()
            } else if component == 4 {
                setMinuteTxt()
            } else if component == 5 {
                setSecondTxt()
            }
        }
        
        if let view = viewForRowInComponentClosure?(row, component, value) {
            return view
        } else {
            return UILabel(text: txt, font: config.txtFont, textColor: config.txtColor)
        }
    }
}

// MARK: - Helper
extension ZZDatePicker {
    
    /// 准备初始化最大最小值及列数
    private func prepareMinMaxAndColumn() {
        switch config.dateStyle {
        case .yyyy:
            columns = 1
            prepareYears()
        case .yyyy_MM:
            columns = 2
            prepareYears()
            prepareMonths()
        case .yyyy_MM_dd:
            columns = 3
            prepareYears()
            prepareMonths()
        case .yyyy_MM_dd_HH:
            columns = 4
            prepareYears()
            prepareMonths()
            prepareHours()
        case .yyyy_MM_dd_HH_mm:
            columns = 5
            prepareYears()
            prepareMonths()
            prepareHours()
            prepareMinutes()
        case .yyyy_MM_dd_HH_mm_ss:
            columns = 6
            prepareYears()
            prepareMonths()
            prepareHours()
            prepareMinutes()
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
}

// MARK: -
extension ZZDatePicker {
    private func refreshDataSource() {
        switch config.dateStyle {
        case .yyyy:
            break
        case .yyyy_MM:
            refreshMonthData()
        case .yyyy_MM_dd:
            refreshMonthData()
            refreshDayData()
        case .yyyy_MM_dd_HH:
            refreshMonthData()
            refreshDayData()
            refreshHourData()
        case .yyyy_MM_dd_HH_mm:
            refreshMonthData()
            refreshDayData()
            refreshHourData()
            refreshMinuteData()
        case .yyyy_MM_dd_HH_mm_ss:
            refreshMonthData()
            refreshDayData()
            refreshHourData()
            refreshMinuteData()
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
        
        
        switch config.dateStyle {
        case .yyyy:
            appendYearIndex()
        case .yyyy_MM:
            appendYearIndex()
            appendMonthIndex()
        case .yyyy_MM_dd:
            appendYearIndex()
            appendMonthIndex()
            appendDayIndex()
        case .yyyy_MM_dd_HH:
            appendYearIndex()
            appendMonthIndex()
            appendDayIndex()
            appendHourIndex()
        case .yyyy_MM_dd_HH_mm:
            appendYearIndex()
            appendMonthIndex()
            appendDayIndex()
            appendHourIndex()
            appendMinuteIndex()
        case .yyyy_MM_dd_HH_mm_ss:
            appendYearIndex()
            appendMonthIndex()
            appendDayIndex()
            appendHourIndex()
            appendMinuteIndex()
            appendSecondIndex()
        }
        
        for (column, row) in idxArray.enumerated() {
            pickerView.selectRow(row, inComponent: column, animated: true)
        }
    }
    
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
        
        switch config.dateStyle {
        case .yyyy:
            break
        case .yyyy_MM:
            fixSelectMonth()
        case .yyyy_MM_dd:
            fixSelectMonth()
            fixSelectDay()
        case .yyyy_MM_dd_HH:
            fixSelectMonth()
            fixSelectDay()
            fixSelectHour()
        case .yyyy_MM_dd_HH_mm:
            fixSelectMonth()
            fixSelectDay()
            fixSelectHour()
            fixSelectMinute()
        case .yyyy_MM_dd_HH_mm_ss:
            fixSelectMonth()
            fixSelectDay()
            fixSelectHour()
            fixSelectMinute()
            fixSelectSecond()
        }
    }
    
    private func updateSelectDate(byAdding component: Calendar.Component, value: Int) {
        config.selectDate = config.selectDate.zz_date(byAdding: component, value: value)!
    }
    
    private func isScrollIngInView(_ view: UIView) -> Bool {
        if let scrollView = view as? UIScrollView {
            return scrollView.isDragging || scrollView.isDragging
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
    struct Config {
        /// 行高
        var rowHeight: CGFloat = 40
        /// 显示样式
        var dateStyle: DateStyle = .yyyy_MM_dd_HH_mm_ss
        
        var yearUnit = "年"
        var monthUnit = "月"
        var dayUnit = "日"
        var hourUnit = "时"
        var minuteUnit = "分"
        var secondUnit = "秒"
        
        var txtFont: UIFont = .size(15)
        var txtColor: UIColor = UIColor.darkGray
        
        /// 最早日期（默认是1900）
        var minDate: Date = {
            var date = Date(timeIntervalSince1970: 0)
            return date.zz_date(byAdding: .year, value: -70)!
        }()
        /// 最大日期（默认是2099）
        var maxDate: Date = {
            var date = Date(timeIntervalSince1970: 0)
            var newDate = date.zz_date(byAdding: .year, value: 129)!
            return newDate.zz_date(bySetting: 23, minute: 59, second: 59)!
        }()
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
    }
}

extension ZZDatePicker.Config {
    fileprivate var validateOK: Bool {
        let minInterval = selectDate.timeIntervalSince1970
        let startInterval = selectDate.timeIntervalSince1970
        let maxInterval = selectDate.timeIntervalSince1970
        
        guard minInterval <= startInterval && startInterval <= maxInterval else {
            return false
        }
        return true
    }
    
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
