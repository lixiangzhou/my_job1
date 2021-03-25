//
//  EMREditMainBottomCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditMainBottomCell: EMREditCommonBottomCell {
    
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
    let sumaryView = ZZGrowTextView()
    
    var addClosure: (() -> Void)?
    var cleanClosure: (() -> Void)?
    var submitClosure: (() -> Void)?
}

// MARK: - UI
extension EMREditMainBottomCell {
    private func setUI() {
        let addBtn = UIButton(title: "新增疼痛部位", font: .size(12), titleColor: .c4167f3, target: self, action: #selector(addAction))
        addBtn.zz_setBorder(color: .c4167f3, width: 1)
        addBtn.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(addBtn)
        
        let titleLabel = contentView.zz_add(subview: UILabel(text: "汇总", font: .boldSize(16), textColor: .c3))
        
        setTxtView(sumaryView)
        contentView.addSubview(sumaryView)
        
        let cleanBtn = contentView.zz_add(subview: UIButton(title: "清空", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(cleanAction)))
        cleanBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        let submitBtn = contentView.zz_add(subview: UIButton(title: "提交", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(submitAction)))
        submitBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        
        addBtn.snp.makeConstraints { (make) in
            make.top.equalTo(32)
            make.left.equalTo(84)
            make.right.equalTo(-88)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(addBtn.snp.bottom).offset(16)
            make.height.equalTo(22)
        }
        
        sumaryView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(sumaryView.snp.bottom).offset(24)
            make.right.equalTo(sumaryView)
            make.width.equalTo(48)
            make.height.equalTo(24)
        }
        
        cleanBtn.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(submitBtn)
            make.right.equalTo(submitBtn.snp.left).offset(-16)
            make.bottom.equalTo(bottomBtn.snp.top).offset(-42)
        }
    }
}

// MARK: - Action
extension EMREditMainBottomCell {
    @objc func addAction() {
        addClosure?()
    }
    
    @objc func cleanAction() {
        cleanClosure?()
    }
    
    @objc func submitAction() {
        submitClosure?()
    }
}
