//
//  EMREditDiagnosisStartBottomCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditDiagnosisStartBottomCell: EMREditCommonBottomCell {
    
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
    var addClosure: (() -> Void)?
    var delClosure: (() -> Void)?
}

// MARK: - UI
extension EMREditDiagnosisStartBottomCell {
    private func setUI() {
        let addBtn = UIButton(title: "新增", font: .size(12), titleColor: .c4167f3, backgroundColor: .cF5F8FF, target: self, action: #selector(addAction))
        addBtn.zz_setBorder(color: .c4167f3, width: 1)
        addBtn.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(addBtn)
        
        let delBtn = UIButton(title: "删除", font: .size(12), titleColor: .c4167f3, backgroundColor: .cF5F8FF, target: self, action: #selector(delAction))
        delBtn.zz_setBorder(color: .c4167f3, width: 1)
        delBtn.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(delBtn)
        
        addBtn.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(12)
            make.height.equalTo(32)
            make.bottom.equalTo(bottomBtn.snp.bottom).offset(-60)
        }
        
        delBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.height.width.equalTo(addBtn)
            make.left.equalTo(addBtn.snp.right).offset(24)
        }
    }
}

// MARK: - Action
extension EMREditDiagnosisStartBottomCell {
    @objc func addAction() {
        addClosure?()
    }
    
    @objc func delAction() {
        delClosure?()
    }
}
