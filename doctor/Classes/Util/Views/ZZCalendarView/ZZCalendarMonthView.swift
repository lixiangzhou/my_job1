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
            
        }
    }
    
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
        cell.dayModel =  monthModel.days[indexPath.row - monthModel.weekday + 1]
        return cell
    }
}
