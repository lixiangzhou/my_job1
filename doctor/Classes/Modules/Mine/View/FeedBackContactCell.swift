//
//  FeedBackContactCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class FeedBackContactCell: UITableViewCell {
    
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
    let fieldView = UITextField()
    var submitClosure: ((String) -> Void)?
}

// MARK: - UI
extension FeedBackContactCell {
    private func setUI() {
        contentView.backgroundColor = .white
        let titleLabel = contentView.zz_add(subview: UILabel(text: "您的联系方式", font: UIFont.PingFangSC.medium.size(16), textColor: .c3))
        
        fieldView.font = UIFont.PingFangSC.medium.size(12)
        fieldView.zz_setBorder(color: .cf5f5f5, width: 1)
        fieldView.zz_setCorner(radius: 4, masksToBounds: true)
        fieldView.placeHolderString = "手机号/邮箱/微信/QQ"
        fieldView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        fieldView.leftViewMode = .always
        contentView.addSubview(fieldView)
        
        let tipLabel = contentView.zz_add(subview: UILabel(text: "感谢您对宝林医生的关注与支持，我们将会在第一时间联系回复您。", font: UIFont.PingFangSC.light.size(12), textColor: .c9))
        
        let btn = UIButton(title: "提交", font: UIFont.PingFangSC.regular.size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(submitAction))
        btn.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(btn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(16)
        }
        
        fieldView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(32)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fieldView.snp.bottom).offset(8)
            make.left.right.equalTo(fieldView)
        }
        
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom).offset(40)
            make.left.equalTo(42)
            make.right.equalTo(-42)
            make.height.equalTo(42)
            make.bottom.equalTo(40)
        }
    }
}

// MARK: - Action
extension FeedBackContactCell {
    @objc func submitAction() {
        submitClosure?(fieldView.text ?? "")
    }
}
