//
//  EMREditCommonBigRightCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditCommonBigRightCell: UITableViewCell {
    
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
    let rightLabel = UILabel(font: .size(14), textColor: .c6)
    // MARK: - Private Property
    
    func setTopBottom(_ top: CGFloat, _ bottom: CGFloat) {
        leftLabel.snp.updateConstraints { (make) in
            make.top.equalTo(top)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-bottom)
        }
    }
}

// MARK: - UI
extension EMREditCommonBigRightCell {
    private func setUI() {
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(12)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel.snp.right).offset(8)
            make.top.equalTo(leftLabel)
            make.right.equalTo(-16)
            make.bottom.equalTo(0)
        }
    }
}
