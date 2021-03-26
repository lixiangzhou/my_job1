//
//  EMREditDiagnosisPositionCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditDiagnosisPositionCell: UITableViewCell {
    
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
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    // MARK: - Private Property
    
}

// MARK: - UI
extension EMREditDiagnosisPositionCell {
    private func setUI() {
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        let sep = contentView.zz_add(subview: UILabel(text: "-", font: .size(14), textColor: .c3))
        addBottomLine(left: 12, right: -16, height: 1)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(16)
            make.height.equalTo(20)
            make.bottom.equalTo(-8)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(117)
            make.top.height.bottom.equalTo(leftLabel)
            make.right.equalTo(-16)
        }
        
        sep.snp.makeConstraints { (make) in
            make.bottom.equalTo(-8)
            make.left.equalTo(92)
            make.width.equalTo(9)
            make.height.equalTo(20)
        }
    }
}
