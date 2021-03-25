//
//  EMREditCommonBottomCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditCommonBottomCell: UITableViewCell {
    
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
    let bottomBtn = UIButton(title: "下一页", font: .size(14), titleColor: .white, backgroundColor: .c4167f3)
    var bottomClosure: (() -> Void)?
    
}

// MARK: - UI
extension EMREditCommonBottomCell {
    private func setUI() {
        bottomBtn.addTarget(self, action: #selector(bottomAction), for: .touchUpInside)
        bottomBtn.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(bottomBtn)
        
        bottomBtn.snp.makeConstraints { (make) in
            make.left.equalTo(53)
            make.right.equalTo(-58)
            make.height.equalTo(42)
            make.bottom.equalTo(-42)
        }
    }
    
    func setTxtView(_ txtView: ZZGrowTextView) {
        txtView.zz_setCorner(radius: 4, masksToBounds: true)
        txtView.zz_setBorder(color: .cf5f5f5, width: 1)
        txtView.backgroundColor = .cFAFAFA
        txtView.textView.backgroundColor = .cFAFAFA
        txtView.config = .init(minHeight: 72, maxHeight: 72)
    }
}

// MARK: - Action
extension EMREditCommonBottomCell {
    @objc func bottomAction() {
        bottomClosure?()
    }
}
