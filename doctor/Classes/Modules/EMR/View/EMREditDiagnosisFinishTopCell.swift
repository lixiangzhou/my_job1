//
//  EMREditDiagnosisFinishTopCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class EMREditDiagnosisFinishTopCell: UITableViewCell {
    
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
    let nameLabel = UILabel(text: " ", font: .boldSize(14), textColor: .c3)
    let ageLabel = UILabel(text: " ", font: .size(12), textColor: .c3)
    let sexLabel = UILabel(text: " ", font: .size(12), textColor: .c3)
    let idLabel = UILabel(text: " ", font: .size(12), textColor: .c9)
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension EMREditDiagnosisFinishTopCell {
    private func setUI() {
        iconView.zz_setCorner(radius: 24, masksToBounds: true)
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(sexLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(idLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(12)
            make.width.height.equalTo(48)
            make.bottom.equalTo(-12)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(14)
            make.left.equalTo(iconView.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        sexLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
        
        ageLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLabel)
            make.left.equalTo(sexLabel.snp.right).offset(8)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView).offset(-2)
            make.left.equalTo(nameLabel)
        }
    }
}

// MARK: - Action
extension EMREditDiagnosisFinishTopCell {
    
}

// MARK: - Helper
extension EMREditDiagnosisFinishTopCell {
    
}

// MARK: - Other
extension EMREditDiagnosisFinishTopCell {
    
}

// MARK: - Public
extension EMREditDiagnosisFinishTopCell {
    
}
