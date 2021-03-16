//
//  ZZCalendarDayView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class ZZCalendarDayView: UICollectionViewCell {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    static let identifier = "ZZCalendarDayViewIdentifier"
    
    // MARK: - Private Property
    let textLabel = UILabel(font: .size(14), textColor: .c3, textAlignment: .center)
    var dayModel: DayModel! {
        didSet {
            textLabel.text = "\(dayModel.day)"
            
            textLabel.textColor = dayModel.isToday ? UIColor.red : UIColor.c3
        }
    }
}

// MARK: - UI
extension ZZCalendarDayView {
    private func setUI() {
        contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}
