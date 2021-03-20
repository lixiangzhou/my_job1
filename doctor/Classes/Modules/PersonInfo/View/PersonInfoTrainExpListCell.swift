//
//  PersonInfoTrainExpListCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class PersonInfoTrainExpListCell: UITableViewCell {
    
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
    let hospitalLabel = UILabel(text: " ", font: .boldSize(16), textColor: .c3)
    let deptLabel = UILabel(text: " ", font: .size(14), textColor: .c6)
    let durationLabel = UILabel(text: " ", font: .size(14), textColor: .c3)
    let titleLabel = UILabel(text: " ", font: .boldSize(14), textColor: .c3)
    let descLabel = UILabel(text: " ", font: .size(14), textColor: .c6)
    
    let deleteBtn = UIButton(title: " 删除", font: .size(12), titleColor: .c9, imageName: "mine_personinfo_wexp_del")
    let editBtn = UIButton(title: " 编辑", font: .size(12), titleColor: .c9, imageName: "mine_personinfo_wexp_edit")
    
    var bottomLine: UIView!
    // MARK: - Private Property
    
}

// MARK: - UI
extension PersonInfoTrainExpListCell {
    private func setUI() {
        contentView.addSubview(hospitalLabel)
        contentView.addSubview(deptLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(deleteBtn)
        contentView.addSubview(editBtn)
        
        bottomLine = contentView.addBottomLine(left: 16, right: 16, height: 1)
        
        hospitalLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.height.equalTo(22)
            make.right.equalTo(-16)
        }
        
        deptLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hospitalLabel.snp.bottom).offset(8)
            make.left.equalTo(hospitalLabel)
            make.height.equalTo(20)
        }
        
        durationLabel.snp.makeConstraints { (make) in
            make.right.equalTo(hospitalLabel)
            make.height.top.equalTo(deptLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(deptLabel.snp.bottom).offset(16)
            make.left.equalTo(hospitalLabel)
            make.height.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(8)
            make.height.equalTo(32)
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.top.height.equalTo(deleteBtn)
            make.right.equalTo(-16)
            make.bottom.equalTo(-8)
            make.left.equalTo(deleteBtn.snp.right).offset(16)
        }
    }
}
