//
//  LeftRightUpDownLabelCell.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/12/7.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

class LeftRightUpDownLabelCell: UITableViewCell {
    
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
    let innerView = LeftRightUpDownLabelView()
}

// MARK: - UI
extension LeftRightUpDownLabelCell {
    private func setUI() {
        contentView.addSubview(innerView)
        
        innerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
