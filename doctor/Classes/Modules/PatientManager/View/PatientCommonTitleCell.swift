//
//  PatientCommonTitleCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class PatientCommonTitleCell: UITableViewCell {
    
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
    let titleLabel = UILabel(font: .boldSize(16), textColor: .c3)
}

// MARK: - UI
extension PatientCommonTitleCell {
    private func setUI() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(16)
            make.bottom.equalTo(0)
        }
    }
    
    
    func set(top: CGFloat, bottom: CGFloat) {
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(top)
            make.bottom.equalTo(-bottom)
        }
    }
}
