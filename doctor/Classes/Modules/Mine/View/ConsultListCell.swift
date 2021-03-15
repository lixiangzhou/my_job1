//
//  ConsultListCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class ConsultListCell: UITableViewCell {
    
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
    let iconView = UIImageView()
    let titleLabel = UILabel(text: " ", font: UIFont.PingFangSC.medium.size(16), textColor: .c3, numOfLines: 2)
    
    let midLabel = UILabel(text: " ", font: UIFont.PingFangSC.regular.size(12), textColor: .c9)
    
    let dzLabel = UILabel(text: "点赞0", font: UIFont.PingFangSC.regular.size(12), textColor: .c3)
    let readLabel = UILabel(text: "阅读0", font: UIFont.PingFangSC.regular.size(12), textColor: .c3)
    
    var bottomLine: UIView!
    // MARK: - Private Property
}

// MARK: - UI
extension ConsultListCell {
    private func setUI() {
        backgroundColor = .white
        
        iconView.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(midLabel)
        
        let dzIcon = UIImageView(image: UIImage(named: "mine_consult_dz"))
        let readIcon = UIImageView(image: UIImage(named: "mine_consult_read"))
        
        dzIcon.contentMode = .center
        readIcon.contentMode = .center
        
        contentView.addSubview(dzIcon)
        contentView.addSubview(dzLabel)
        contentView.addSubview(readIcon)
        contentView.addSubview(readLabel)
        
        bottomLine = contentView.addBottomLine(left: 16, right: 16, height: 1)
        
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.bottom.equalTo(-16)
            make.height.equalTo(96)
            make.width.equalTo(118)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(16)
            make.right.equalTo(-16)
        }
        
        midLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(dzIcon.snp.top).offset(-8)
        }
        
        dzIcon.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.width.height.equalTo(20)
            make.bottom.equalTo(iconView).offset(-2)
        }
        
        dzLabel.sizeToFit()
        dzLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dzIcon.snp.right).offset(4)
            make.top.bottom.equalTo(dzIcon)
            make.width.equalTo(dzLabel.zz_width)
        }
        
        readIcon.snp.makeConstraints { (make) in
            make.left.equalTo(dzLabel.snp.right).offset(17)
            make.width.height.bottom.equalTo(dzIcon)
        }
        
        readLabel.sizeToFit()
        readLabel.snp.makeConstraints { (make) in
            make.left.equalTo(readIcon.snp.right).offset(4)
            make.top.bottom.equalTo(readIcon)
            make.width.equalTo(readLabel.zz_width)
        }
    }
}
