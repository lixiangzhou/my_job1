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
            let x = (UIScreen.zz_width - collectionW) * 0.5
            weekView.frame = CGRect(x: x, y: 0, width: bounds.width, height: config.weekH)
            collectionView.frame = CGRect(x: x, y: config.weekH, width: collectionW, height: collectionH)
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
        let currentY = Date().zz_year
        let yearRange = (currentY - 10)...(currentY + 10)
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
                    let dayModel = DayModel(year: y, month: m, day: d, weekday: cmps.weekday!, weekOfMonth: cmps.weekOfMonth!, date: day)
                    dayModels.append(dayModel)
                }
                
                let monthModel = MonthModel(year: y, month: m, weekday: date.zz_weekday, date: date, days: dayModels)
                monthModels.append(monthModel)
            }
        }
        return monthModels
    }()
    
    var collectionW: CGFloat {
        floor(UIScreen.zz_width / 7) * 7
//        UIScreen.zz_width
    }
    
    var collectionH: CGFloat {
         45 * 6
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
        
        let x = (UIScreen.zz_width - collectionW) * 0.5
        weekView = UIStackView(arrangedSubviews: weeks)
        weekView.frame = CGRect(x: x, y: 0, width: bounds.width, height: config.weekH)
        weekView.axis = .horizontal
        weekView.distribution = .fillEqually
        
        collectionView = UICollectionView(frame: CGRect(x: x, y: config.weekH, width: collectionW, height: collectionH), collectionViewLayout: getLayout())
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(cell: ZZCalendarMonthView.self)
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(weekView)
        addSubview(collectionView)
        
//        collectionView.snp.makeConstraints { (make) in
//            make.top.equalTo(config.weekH)
//            make.left.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.width.equalTo(collectionW)
//            make.height.equalTo(collectionH)
//            make.centerX.equalToSuperview()
//        }
        
        setSelect(year: config.selectDate.zz_year, month: config.selectDate.zz_month, animated: true)
    }
    
    private func getLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionW, height: collectionH)
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
        cell.config = config
        
        cell.didSelectDayClosure = { [weak self] idxPath, month, day in
            guard let self = self else { return }
                if let startDay = self.config.start {
                    if let _ = self.config.end {
                        self.config.start = day
                        self.config.end = nil
                    } else {
                        if day.date.zz_isEarlier(than: startDay.date) {
                            self.config.start = day
                        } else {
                            self.config.end = day
                        }
                    }
                } else {
                    self.config.start = day
                }
            self.collectionView.reloadItems(at: [indexPath])
        }
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
            let idxPath = IndexPath(item: idx, section: 0)
            collectionView.selectItem(at: idxPath, animated: animated, scrollPosition: .centeredHorizontally)
            
            if let cell = collectionView.cellForItem(at: idxPath) as? ZZCalendarMonthView {
                cell.config = config
            }
        }
    }
    
    class Config {
        var weekH: CGFloat = 40
        var weekTitleFont: UIFont = UIFont.PingFangSC.semibold.size(13)
        var weekTitleColor: UIColor = UIColor(stringHexValue: "#989DB3")!
        var selectDate = Date()
        
        var start: DayModel?
        var end: DayModel?
    }
}
