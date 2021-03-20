//
//  PersonInfoEditAvatorCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//  
//

import UIKit

class PersonInfoEditAvatorCell: UITableViewCell {
    
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
    let titleLabel = UILabel(text: "头像", font: .size(14), textColor: .c3)
    let iconView = UIImageView(image: UIImage(named: "mine_avator"))
}

// MARK: - UI
extension PersonInfoEditAvatorCell {
    private func setUI() {
        backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        iconView.backgroundColor = .blue
        iconView.zz_setCorner(radius: 12, masksToBounds: true)
        contentView.addSubview(iconView)
        let arrowView = contentView.zz_add(subview: UIImageView.defaultRightArrow())
        
        contentView.addBottomLine(color: .cf5f5f5, left: 16, right: 16, height: 1)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(arrowView.zz_size)
            make.left.equalTo(iconView.snp.right).offset(8)
        }
    }
}
