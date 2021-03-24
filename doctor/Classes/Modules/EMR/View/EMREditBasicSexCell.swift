//
//  EMREditBasicSexCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit

class EMREditBasicSexCell: UITableViewCell {
    
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
    let xView = UIImageView(image: UIImage(named: "mine_auth_xx"))
}

// MARK: - UI
extension EMREditBasicSexCell {
    private func setUI() {
        backgroundColor = .white
        
        contentView.addSubview(xView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(maleBtn)
        contentView.addSubview(femaleBtn)
        contentView.addBottomLine(color: .cf5f5f5, left: 12, right: 16, height: 1)
        
        xView.snp.makeConstraints { (make) in
            make.width.height.equalTo(8)
            make.left.equalTo(12)
            make.bottom.equalTo(-14)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(28)
            make.bottom.equalTo(-8)
            make.height.equalTo(20)
        }
        
        maleBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleLabel)
            make.right.equalTo(femaleBtn.snp.left).offset(-16)
        }
        
        femaleBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleLabel)
            make.right.equalTo(-16)
        }
    }
}
