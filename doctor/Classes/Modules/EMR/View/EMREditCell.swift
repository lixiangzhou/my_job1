//
//  EMREditCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit

class EMREditCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let txtLabel = UILabel(font: .size(12), textColor: .c3, textAlignment: .right)
    let leftLine = RoundOptionView(frame: CGRect(x: 0, y: 0, width: 4, height: 16), radius: 1.5, roundColor: .c4167f3, bgColor: .white, roundingCorners: [.topRight, .bottomRight])
    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension EMREditCell {
    private func setUI() {
        contentView.addSubview(txtLabel)
        
        contentView.addSubview(leftLine)
        
        leftLine.snp.makeConstraints { (make) in
            make.centerY.left.equalToSuperview()
            make.width.equalTo(leftLine.zz_width)
            make.height.equalTo(leftLine.zz_height)
        }
        
        txtLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-18)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
        }
    }
}
