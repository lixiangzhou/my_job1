//
//  ZZCalendarDayView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class ZZCalendarDurationDayView: UICollectionViewCell {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    
    
    
    // MARK: - Private Property
    let pannelView = UIView()
    let textLabel = UILabel(font: UIFont.AvenirNext.demibold.size(14), textColor: .c3, textAlignment: .center)
    let stateLabel = UILabel(text: " ", font: .size(10), textColor: .white)
    let bgColorLeftView = UIView()
    let bgColorRightView = UIView()
    var dayModel: DayModel! {
        didSet {
            textLabel.text = "\(dayModel.day)"
//            textLabel.textColor = dayModel.isToday ? UIColor.red : UIColor.c3
        }
    }
}

// MARK: - UI
extension ZZCalendarDurationDayView {
    private func setUI() {
        contentView.addSubview(bgColorLeftView)
        contentView.addSubview(bgColorRightView)
        
        pannelView.zz_setCorner(radius: 8, masksToBounds: true)
        contentView.addSubview(pannelView)
        pannelView.addSubview(textLabel)
        pannelView.addSubview(stateLabel)
        
        pannelView.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(40)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(7)
            make.centerX.equalToSuperview()
        }
        
        stateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-2)
            make.centerX.equalToSuperview()
        }
        
        bgColorLeftView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(pannelView)
            make.left.equalToSuperview()
            make.right.equalTo(pannelView.snp.centerX)
        }
        
        bgColorRightView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(pannelView)
            make.right.equalToSuperview()
            make.left.equalTo(pannelView.snp.centerX)
        }
    }
}
