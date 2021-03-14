//
//  FeedBackDescCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class FeedBackDescCell: UITableViewCell {
    
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
    let txtView = ZZGrowTextView()
    // MARK: - Private Property
    
}

// MARK: - UI
extension FeedBackDescCell {
    private func setUI() {
        contentView.backgroundColor = .white
        let titleLabel = contentView.zz_add(subview: UILabel(text: "描述", font: UIFont.PingFangSC.medium.size(16), textColor: .c3))
        
        let pannelView = contentView.zz_add(subview: UIView())
        pannelView.backgroundColor = .white
        pannelView.zz_setBorder(color: .cf5f5f5, width: 1)
        pannelView.zz_setCorner(radius: 4, masksToBounds: true)
        
        txtView.textView.placeholder = "请输入"
        txtView.textView.font = UIFont.PingFangSC.medium.size(12)
        txtView.textView.placeholderColor = .c3
        txtView.textView.textColor = .c3
        txtView.config = ZZGrowTextView.Config(paddingInset: .init(top: 12, left: 12, bottom: 12, right: 12), minHeight: 164, maxHeight: 164)
        pannelView.addSubview(txtView)
        
        let countLabel = pannelView.zz_add(subview: UILabel(text: "0/300", font: UIFont.PingFangSC.medium.size(12), textColor: .c9)) as! UILabel
        
        txtView.limit = 300
        txtView.txtDidChangeClosure = { txt in
            countLabel.text = "\(txt.count)/300"
        }
        
        pannelView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(194)
            make.bottom.equalTo(-4)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(16)
        }
        
        txtView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(164)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.top.equalTo(txtView.snp.bottom)
            make.right.equalTo(-12)
        }
    }
}
