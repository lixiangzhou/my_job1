//
//  EMREditCommonFieldCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit

class EMREditCommonFieldCell: EMREditXCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let fieldView = UITextField()
}

// MARK: - UI
extension EMREditCommonFieldCell {
    private func setUI() {
        contentView.addSubview(fieldView)
        
        fieldView.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.right.equalTo(-16)
            make.width.equalTo(120)
            make.bottom.equalToSuperview()
        }
    }
}
