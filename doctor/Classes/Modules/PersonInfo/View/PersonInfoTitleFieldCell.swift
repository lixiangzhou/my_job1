//
//  PersonInfoTitleFieldCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/22.
//  
//

import UIKit

class PersonInfoTitleFieldCell: UITableViewCell {
    
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
    let txtField = UITextField()
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension PersonInfoTitleFieldCell {
    private func setUI() {
        txtField.font = .size(14)
        txtField.textColor = .c3
        txtField.attributedPlaceholder = NSAttributedString(string: "其他", attributes: [NSAttributedString.Key.foregroundColor: UIColor.c3])
        contentView.addSubview(txtField)
        addBottomLine(left: 16, right: 16, height: 1)
        
        txtField.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(8)
            make.bottom.equalToSuperview()
        }
    }
}
