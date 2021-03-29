//
//  EMRCommonBottomCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class EMRCommonBottomCell: UITableViewCell {
    
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
    let bottomBtn = UIButton(title: "提交", font: .size(14), titleColor: .white, backgroundColor: .c4167f3)
    var bottomClosure: (() -> Void)?
    
}

// MARK: - UI
extension EMRCommonBottomCell {
    private func setUI() {
        bottomBtn.addTarget(self, action: #selector(bottomAction), for: .touchUpInside)
        bottomBtn.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(bottomBtn)
        
        bottomBtn.snp.makeConstraints { (make) in
            make.top.equalTo(42)
            make.left.equalTo(42)
            make.right.equalTo(-42)
            make.height.equalTo(42)
            make.bottom.equalTo(-42)
        }
    }
}

// MARK: - Action
extension EMRCommonBottomCell {
    @objc func bottomAction() {
        bottomClosure?()
    }
}
