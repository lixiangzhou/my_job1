//
//  EMREditBasicArrowCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit

class EMREditCommonArrowCell: EMREditXCell {
    
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
    
    let rightLabel = UILabel(textAlignment: .right)
}

// MARK: - UI
extension EMREditCommonArrowCell {
    private func setUI() {
        addArrowView()
        contentView.addSubview(rightLabel)
        
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.bottom.equalTo(titleLabel)
        }
    }
    
    func setRight(text: Text, placeholder: String, placeholderColor: UIColor = .c9, placeholderFont: UIFont = .size(12)) {
        rightLabel.set(txt: text, placeholder: placeholder, placeholderColor: placeholderColor, placeholderFont: placeholderFont)
    }
}
