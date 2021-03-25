//
//  EMREditHPIBottomCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditHPIBottomCell: UITableViewCell {
    
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
    
    var cleanClosure: (() -> Void)?
    var submitClosure: (() -> Void)?
    var nextClosure: (() -> Void)?
    
}

// MARK: - UI
extension EMREditHPIBottomCell {
    private func setUI() {
        let titleLabel = contentView.zz_add(subview: UILabel(text: "汇总", font: .boldSize(16), textColor: .c3))
        
        sumaryView.zz_setCorner(radius: 4, masksToBounds: true)
        sumaryView.zz_setBorder(color: .cf5f5f5, width: 1)
        sumaryView.backgroundColor = .cFAFAFA
        sumaryView.textView.backgroundColor = .cFAFAFA
        sumaryView.config = .init(minHeight: 72, maxHeight: 72)
        contentView.addSubview(sumaryView)
        
        let scaleBtn = contentView.zz_add(subview: UIButton(title: "收起", font: .size(12), titleColor: .c4167f3, imageName: "", backgroundColor: .cDDE4FF, target: self, action: #selector(scaleAction)))
        scaleBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        let cleanBtn = contentView.zz_add(subview: UIButton(title: "清空", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(cleanAction)))
        cleanBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        let submitBtn = contentView.zz_add(subview: UIButton(title: "提交", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(submitAction)))
        submitBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        let nextBtn = contentView.zz_add(subview: UIButton(title: "下一页", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(nextAction)))
        nextBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(16)
            make.height.equalTo(22)
        }
        
        sumaryView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        scaleBtn.snp.makeConstraints { (make) in
            make.top.equalTo(sumaryView.snp.bottom).offset(24)
            make.right.equalTo(sumaryView)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(scaleBtn)
            make.width.equalTo(48)
            make.height.equalTo(24)
            make.right.equalTo(scaleBtn.snp.left).offset(-16)
        }
        
        cleanBtn.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(scaleBtn)
            make.right.equalTo(submitBtn.snp.left).offset(-16)
        }
        
        nextBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cleanBtn.snp.bottom).offset(42)
            make.left.equalTo(53)
            make.right.equalTo(-58)
            make.height.equalTo(42)
            make.bottom.equalTo(-42)
        }
    }
}

// MARK: - Action
extension EMREditHPIBottomCell {
    @objc func scaleAction() {
        
    }
    
    @objc func cleanAction() {
        cleanClosure?()
    }
    
    @objc func submitAction() {
        submitClosure?()
    }
    
    @objc func nextAction() {
        nextClosure?()
    }
}
