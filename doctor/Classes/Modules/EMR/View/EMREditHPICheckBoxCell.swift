//
//  EMREditHPICheckBoxCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditHPICheckBoxCell: EMREditXCell {
    
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
    var btns = [UIButton]()
}

// MARK: - UI
extension EMREditHPICheckBoxCell {
    private func setUI() {
        let strs = ["是", "否"]
        for (idx, str) in strs.enumerated() {
            let btn = UIButton(title: str, font: .size(10), titleColor: .c4167f3, backgroundColor: .cEEF1FF, target: self, action: #selector(btnAction))
            btn.setTitleColor(.white, for: .selected)
            btn.zz_setCorner(radius: 4, masksToBounds: true)
            contentView.addSubview(btn)
            btn.tag = idx
            btns.append(btn)
        }
        
        let yesBtn = btns[0]
        yesBtn.backgroundColor = .c4167f3
        yesBtn.isSelected = true
        let noBtn = btns[1]
        
        noBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-8)
            make.right.equalTo(-16)
            make.width.equalTo(48)
            make.height.equalTo(28)
        }
        
        yesBtn.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(noBtn)
            make.right.equalTo(noBtn.snp.left).offset(-16)
        }
    }
}

// MARK: - Action
extension EMREditHPICheckBoxCell {
    @objc func btnAction(_ sender: UIButton) {
        if !sender.isSelected {
            btns.forEach {
                if $0 == sender {
                    $0.backgroundColor = .cEEF1FF
                } else {
                    $0.isSelected = true
                    $0.backgroundColor = .c4167f3
                }
            }
        }
    }
}

// MARK: - Helper
extension EMREditHPICheckBoxCell {
    
}

// MARK: - Other
extension EMREditHPICheckBoxCell {
    
}

// MARK: - Public
extension EMREditHPICheckBoxCell {
    
}
