//
//  PersonInfoSexCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class PersonInfoSexCell: UITableViewCell {
    
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
    let titleLabel = UILabel(text: "性别", font: .size(14), textColor: .c3)
    let maleBtn = UIButton(title: " 男", imageName: "mine_personinfo_male", selectedImageName: "mine_personinfo_male")
    let femaleBtn = UIButton(title: " 女", imageName: "mine_personinfo_female", selectedImageName: "mine_personinfo_female")
}

// MARK: - UI
extension PersonInfoSexCell {
    private func setUI() {
        backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(maleBtn)
        contentView.addSubview(femaleBtn)
        contentView.addBottomLine(color: .cf5f5f5, left: 16, right: 16, height: 1)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        maleBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(femaleBtn.snp.left).offset(-16)
        }
        
        femaleBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
        }
    }
}
