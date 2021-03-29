//
//  EMRCommonTitleCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class EMRCommonTitleCell: UITableViewCell {
    
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
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension EMRCommonTitleCell {
    private func setUI() {
        
    }
}

// MARK: - Action
extension EMRCommonTitleCell {
    
}

// MARK: - Helper
extension EMRCommonTitleCell {
    
}

// MARK: - Other
extension EMRCommonTitleCell {
    
}

// MARK: - Public
extension EMRCommonTitleCell {
    
}
