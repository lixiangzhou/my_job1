//
//  EMREditHPITitleCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditHPITitleCell: UITableViewCell {
    
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
    let titleLabel = UILabel(font: .boldSize(14), textColor: .c4167f3)
}

// MARK: - UI
extension EMREditHPITitleCell {
    private func setUI() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(8)
            make.bottom.equalToSuperview()
        }
    }
    
    /// 8   16
    func setTopOffset(_ offset: CGFloat) {
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(offset)
        }
    }
}

// MARK: - Action
extension EMREditHPITitleCell {
    
}

// MARK: - Helper
extension EMREditHPITitleCell {
    
}

// MARK: - Other
extension EMREditHPITitleCell {
    
}

// MARK: - Public
extension EMREditHPITitleCell {
    
}
