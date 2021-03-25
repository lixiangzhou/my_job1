//
//  EMREditHPISepCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditHPISepCell: UITableViewCell {
    
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
    let sepView = UIImageView()
}

// MARK: - UI
extension EMREditHPISepCell {
    private func setUI() {
        sepView.backgroundColor = .blue
        contentView.addSubview(sepView)
        
        sepView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.right.equalTo(-16)
            make.height.equalTo(4)
            make.top.bottom.equalToSuperview()
        }
    }
}
