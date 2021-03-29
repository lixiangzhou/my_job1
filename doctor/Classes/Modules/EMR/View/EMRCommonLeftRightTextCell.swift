//
//  EMRCommonLeftRightTextCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class EMRCommonLeftRightTextCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    let leftLabel = UILabel(font: .size(14), textColor: .c3)
    let rightLabel = UILabel(font: .size(14), textColor: .c3)
    // MARK: - Private Property
    
    
//    func set(top: CGFloat, bottom: CGFloat) {
//        leftLabel.snp.updateConstraints { (make) in
//            make.top.equalTo(top)
//            make.bottom.equalTo(-bottom)
//        }
//    }
}

// MARK: - UI
extension EMRCommonLeftRightTextCell {
    private func setUI() {
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.left.equalTo(16)
            make.height.equalTo(20)
            make.bottom.equalTo(-4)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(120)
            make.centerY.equalTo(leftLabel)
        }
    }
}

// MARK: - Action
extension EMRCommonLeftRightTextCell {
    
}

// MARK: - Helper
extension EMRCommonLeftRightTextCell {
    
}

// MARK: - Other
extension EMRCommonLeftRightTextCell {
    
}

// MARK: - Public
extension EMRCommonLeftRightTextCell {
    
}
