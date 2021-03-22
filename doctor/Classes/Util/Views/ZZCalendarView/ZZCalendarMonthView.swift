//
//  ZZCalendarMonthView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class ZZCalendarMonthView: UICollectionViewCell {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    var config = ZZCalendarView.Config() {
        didSet {
            collectionView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            collectionView.setCollectionViewLayout(getLayout(), animated: false)
            collectionView.reloadData()
        }
    }
    
    var didSelectDayClosure: ((IndexPath, MonthModel, DayModel) -> Void)?
    
    var monthModel: MonthModel! {
        didSet {
            collectionView.reloadData()
        }
    }
    var collectionView: UICollectionView!
    // MARK: - Private Property
    
}

// MARK: - UI
extension ZZCalendarMonthView {
    private func setUI() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: getLayout())
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cell: ZZCalendarDayView.self)
        collectionView.register(cell: UICollectionViewCell.self)
        collectionView.backgroundColor = .white
        contentView.addSubview(collectionView)
    }
    
    private func getLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: bounds.width / 7, height: bounds.height / 6)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }
}

// MARK: - Delegate
extension ZZCalendarMonthView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthModel.days.count + monthModel.weekday - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < monthModel.weekday - 1 {
            return collectionView.dequeue(cell: UICollectionViewCell.self, for: indexPath)
        }
        
        let cell = collectionView.dequeue(cell: ZZCalendarDayView.self, for: indexPath)
        let model = monthModel.days[indexPath.row - monthModel.weekday + 1]
        cell.dayModel = model
        
        if let start = config.start {
            if let end = config.end {
                if isEqual(day1: model, day2: start) {
                    setCell(cell, state: .start)
                } else if isEqual(day1: model, day2: end) {
                    setCell(cell, state: .end)
                } else if model.date.zz_isLater(than: start.date) && model.date.zz_isEarlier(than: end.date) {
                    setCell(cell, state: .select)
                } else {
                    setCell(cell, state: .normal)
                }
            } else {
                if isEqual(day1: model, day2: start) {
                    setCell(cell, state: .start)
                } else {                
                    setCell(cell, state: .normal)
                }
            }
        } else {
            setCell(cell, state: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = monthModel.days[indexPath.row - monthModel.weekday + 1]
        didSelectDayClosure?(indexPath, monthModel, model)
    }
    
    func isEqual(day1: DayModel, day2: DayModel) -> Bool {
        day1.year == day2.year && day1.month == day2.month && day1.day == day2.day
    }
    
    func setCell(_ cell: ZZCalendarDayView, state: DayState) {
        switch state {
        case .normal:
            cell.bgColorLeftView.backgroundColor = .white
            cell.bgColorRightView.backgroundColor = .white
            cell.pannelView.backgroundColor = .white
            cell.textLabel.textColor = .c3
            cell.stateLabel.isHidden = true
        case .select:
            cell.bgColorLeftView.backgroundColor = .c8DA5FF
            cell.bgColorRightView.backgroundColor = .c8DA5FF
            cell.pannelView.backgroundColor = .clear
            cell.textLabel.textColor = .white
            cell.stateLabel.isHidden = true
        case .start:
            cell.bgColorLeftView.backgroundColor = .white
            cell.bgColorRightView.backgroundColor = config.end == nil ? UIColor.white : .c8DA5FF
            cell.pannelView.backgroundColor = .c4167f3
            cell.textLabel.textColor = .white
            cell.stateLabel.text = "开始"
            cell.stateLabel.isHidden = false
        case .end:
            cell.bgColorLeftView.backgroundColor = .c8DA5FF
            cell.bgColorRightView.backgroundColor = .white
            cell.pannelView.backgroundColor = .c4167f3
            cell.textLabel.textColor = .white
            cell.stateLabel.text = "结束"
            cell.stateLabel.isHidden = false
        }
    }
}
