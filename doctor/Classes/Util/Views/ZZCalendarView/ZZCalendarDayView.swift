//
//  ZZCalendarDayView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/22.
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
    
    
    
    // MARK: - Private Property
    
    let textLabel = UILabel(font: UIFont.AvenirNext.demibold.size(14), textColor: .c3, textAlignment: .center)
    
    var dayModel: DayModel! {
        didSet {
            textLabel.text = "\(dayModel.day)"
        }
    }
}

// MARK: - UI
extension ZZCalendarDayView {
    private func setUI() {
        textLabel.zz_setCorner(radius: 8, masksToBounds: true)
        contentView.addSubview(textLabel)
        
        
        textLabel.snp.makeConstraints { (make) in
            make.width.height.equalTo(32)
            make.center.equalToSuperview()
        }
    }
}
