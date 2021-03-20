//
//  PersonInfoFieldCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class PersonInfoFieldCell: UITableViewCell {
    
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
    let innerView = TextLeftRightFieldView()
    // MARK: - Private Property
    
}

// MARK: - UI
extension PersonInfoFieldCell {
    private func setUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(innerView)
        innerView.config = TextLeftRightFieldViewConfig(bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
        innerView.rightField.textAlignment = .right
        
        innerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Action
extension PersonInfoFieldCell {
    
}

// MARK: - Helper
extension PersonInfoFieldCell {
    
}

// MARK: - Other
extension PersonInfoFieldCell {
    
}

// MARK: - Public
extension PersonInfoFieldCell {
    
}
