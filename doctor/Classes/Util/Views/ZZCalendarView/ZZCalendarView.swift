//
//  ZZCalendarView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class ZZCalendarView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    var config = Config() {
        didSet {
            weekView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: config.weekH)
            collectionView.frame = CGRect(x: 0, y: config.weekH, width: bounds.width, height: collectionHeight)
            collectionView.setCollectionViewLayout(getLayout(), animated: false)
            setSelect(year: config.selectDate.zz_year, month: config.selectDate.zz_month, animated: true)
        }
    }
    
    var currentMonthModel: MonthModel {
        let idx = Int(collectionView.contentOffset.x / collectionView.zz_width)
        return dataSource[idx]
    }
    
    var selectMonthClosure: ((MonthModel) -> Void)?
    
    // MARK: - Private Property
    private var weekView = UIStackView()
    private var collectionView: UICollectionView!
    
    private lazy var dataSource: [MonthModel] = {
        let yearRange = 1970...2050
        let monthRange = 1...12
        let calendar = Calendar(identifier: .gregorian)
        var monthModels = [MonthModel]()
        for y in yearRange {
            for m in monthRange {
                let date = Date(year: y, month: m, day: 1, hour: 8)!
                let days = date.zz_daysInMonth
                let dayRange = 1...days
                
                var dayModels = [DayModel]()
                
                for d in dayRange {
                    let day = date.zz_dayAfterNow(d - 1)!
                    let cmps = calendar.dateComponents(in: .current, from: day)
                    let dayModel = DayModel(year: y, month: m, day: d, weekday: cmps.weekday!, weekOfMonth: cmps.weekOfMonth!, date: day, state: .normal)
                    dayModels.append(dayModel)
                }
                
                let monthModel = MonthModel(year: y, month: m, weekday: date.zz_weekday, date: date, days: dayModels)
                monthModels.append(monthModel)
            }
        }
        return monthModels
    }()
    
    private var collectionHeight: CGFloat {
        bounds.height - config.weekH
    }
}

// MARK: - UI
extension ZZCalendarView {
    private func setUI() {
        var weeks = [UILabel]()
        let weekStrings = ["日", "一", "二", "三", "四", "五", "六"]
        
        for w in weekStrings {
            weeks.append(UILabel(text: w, font: config.weekTitleFont, textColor: config.weekTitleColor, textAlignment: .center))
        }
        
        weekView = UIStackView(arrangedSubviews: weeks)
        weekView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: config.weekH)
        weekView.axis = .horizontal
        weekView.distribution = .fillEqually
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: config.weekH, width: bounds.width, height: collectionHeight), collectionViewLayout: getLayout())
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(cell: ZZCalendarMonthView.self)
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(weekView)
        addSubview(collectionView)
        
        setSelect(year: config.selectDate.zz_year, month: config.selectDate.zz_month, animated: true)
    }
    
    private func getLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: bounds.width, height: bounds.height - config.weekH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
}

// MARK: - Delegate
extension ZZCalendarView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: ZZCalendarMonthView.self, for: indexPath)
        cell.monthModel =  dataSource[indexPath.row]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        selectMonthClosure?(currentMonthModel)
    }
}

// MARK: - Public
extension ZZCalendarView {
    func setSelect(year: Int, month: Int, animated: Bool) {
        let date = Date(year: year, month: month)!
        
        if let first = dataSource.first, let last = dataSource.last, date >= first.date, date <= last.date {
            let y = year - first.year
            let idx: Int
            if y == 0 {
                idx = month - first.month
            } else {
                idx = y * 12 + month - 1
            }
            collectionView.selectItem(at: IndexPath(item: idx, section: 0), animated: animated, scrollPosition: .centeredHorizontally)
        }
    }
    
    
    struct Config {
        let weekH: CGFloat = 40
        let weekTitleFont: UIFont = UIFont.size(14)
        let weekTitleColor: UIColor = UIColor(stringHexValue: "#989DB3")!
        let selectDate = Date()
    }
}
