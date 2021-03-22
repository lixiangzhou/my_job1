//
//  PersonInfoTitleTxtCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/22.
//  
//

import UIKit

class PersonInfoTitleTxtCell: UITableViewCell {
    
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
    let txtLabel = UILabel(font: .size(14), textColor: .c3)
    // MARK: - Private Property
    
}

// MARK: - UI
extension PersonInfoTitleTxtCell {
    private func setUI() {
        contentView.addSubview(txtLabel)
        addBottomLine(left: 16, right: 16, height: 1)
        
        txtLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(16)
        }
    }
}
