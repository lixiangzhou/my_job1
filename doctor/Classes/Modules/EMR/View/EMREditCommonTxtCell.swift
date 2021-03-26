//
//  EMREditCommonTxtCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditCommonTxtCell: UITableViewCell {
    
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
    let rightLabel = UILabel(font: .size(14), textColor: .c3, textAlignment: .right)
    
    var bottomLine: UIView!
    // MARK: - Private Property
    
    func setTopBottom(_ top: CGFloat, _ bottom: CGFloat) {
        leftLabel.snp.updateConstraints { (make) in
            make.top.equalTo(top)
            make.bottom.equalTo(-bottom)
        }
    }
}

// MARK: - UI
extension EMREditCommonTxtCell {
    private func setUI() {
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        bottomLine = contentView.addBottomLine(color: .cf5f5f5, left: 12, right: 16, height: 1)
        
        leftLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(12)
            make.bottom.equalTo(-8)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(leftLabel)
            make.right.equalTo(-16)
        }
    }
}
