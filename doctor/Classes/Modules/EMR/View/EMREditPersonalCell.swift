//
//  EMREditPersonalCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditPersonalCell: EMREditCommonBottomCell {
    
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
    let personalView = ZZGrowTextView()
    let mensesView = ZZGrowTextView()
    
    var submitClosure: ((Int) -> Void)?
}

// MARK: - UI
extension EMREditPersonalCell {
    private func setUI() {
        setTxtView(personalView)
        contentView.addSubview(personalView)
        let cleanBtn1 = contentView.zz_add(subview: UIButton(title: "清空", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(cleanAction)))
        cleanBtn1.zz_setCorner(radius: 4, masksToBounds: true)
        cleanBtn1.tag = 1
        
        let submitBtn1 = contentView.zz_add(subview: UIButton(title: "提交", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(submitAction)))
        submitBtn1.zz_setCorner(radius: 4, masksToBounds: true)
        submitBtn1.tag = 1
        
        let titleLabel = contentView.zz_add(subview: UILabel(text: "月经史（选填）", font: .boldSize(16), textColor: .c3))
        
        setTxtView(mensesView)
        
        contentView.addSubview(mensesView)
        
        let cleanBtn2 = contentView.zz_add(subview: UIButton(title: "清空", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(cleanAction)))
        cleanBtn2.zz_setCorner(radius: 4, masksToBounds: true)
        cleanBtn2.tag = 1
        
        let submitBtn2 = contentView.zz_add(subview: UIButton(title: "提交", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(submitAction)))
        submitBtn2.zz_setCorner(radius: 4, masksToBounds: true)
        submitBtn2.tag = 1
        
        personalView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(12)
            make.right.equalTo(-16)
        }
        
        submitBtn1.snp.makeConstraints { (make) in
            make.top.equalTo(personalView.snp.bottom).offset(24)
            make.right.equalTo(personalView)
            make.width.equalTo(48)
            make.height.equalTo(24)
        }
        
        cleanBtn1.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(submitBtn1)
            make.right.equalTo(submitBtn1.snp.left).offset(-16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(submitBtn1.snp.bottom).offset(16)
            make.height.equalTo(22)
        }
        
        mensesView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        submitBtn2.snp.makeConstraints { (make) in
            make.top.equalTo(mensesView.snp.bottom).offset(24)
            make.right.equalTo(mensesView)
            make.width.equalTo(48)
            make.height.equalTo(24)
        }
        
        cleanBtn2.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(submitBtn2)
            make.right.equalTo(submitBtn2.snp.left).offset(-16)
            make.bottom.equalTo(bottomBtn.snp.top).offset(-42)
        }
    }
}

// MARK: - Action
extension EMREditPersonalCell {
    
    @objc func cleanAction(_ sender: UIButton) {
        if sender.tag == 1 { // 个人史
            
        } else { // 月经史
            
        }
    }
    
    @objc func submitAction(_ sender: UIButton) {
        if sender.tag == 1 { // 个人史
            
        } else { // 月经史
            
        }
        submitClosure?(sender.tag)
    }
}
