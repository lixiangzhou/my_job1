//
//  EMREditCommonTitleCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditCommonTitleCell: UITableViewCell {
    
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
extension EMREditCommonTitleCell {
    private func setUI() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(8)
            make.bottom.equalToSuperview()
        }
    }
    
    
    func setTopBottomOffset(_ top: CGFloat = 8, _ bottom: CGFloat = 0) {
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(top)
            make.bottom.equalTo(0)
        }
    }
}
