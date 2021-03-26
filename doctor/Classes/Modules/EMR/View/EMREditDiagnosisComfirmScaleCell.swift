//
//  EMREditDiagnosisComfirmScaleCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditDiagnosisComfirmScaleCell: UITableViewCell {
    
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
    let titleLabel = UILabel(font: .size(14), textColor: .c3)
    let rightLabel = UILabel(font: .size(12), textColor: .c3, textAlignment: .right)
    let scoreLabel = UILabel(font: .boldSize(14), textColor: .c3)
    let degreeLabel = UILabel(font: .boldSize(14), textColor: .c3)
    // MARK: - Private Property
    
}

// MARK: - UI
extension EMREditDiagnosisComfirmScaleCell {
    private func setUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(degreeLabel)
        let arrowView = contentView.zz_add(subview: UIImageView.defaultRightArrow())
        
        contentView.addBottomLine(left: 12, right: 16, height: 1)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(12)
            make.height.equalTo(20)
            make.right.lessThanOrEqualTo(rightLabel.snp.left).offset(5)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.bottom.height.equalTo(titleLabel)
            make.right.equalTo(-33)
            make.width.equalTo(40)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(rightLabel)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(12)
            make.height.equalTo(20)
            make.bottom.equalTo(-6)
        }
        
        degreeLabel.snp.makeConstraints { (make) in
            make.height.bottom.equalTo(scoreLabel)
            make.right.equalTo(-16)
            make.left.equalTo(120)
        }
    }
}
