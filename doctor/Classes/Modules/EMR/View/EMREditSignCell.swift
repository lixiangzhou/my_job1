//
//  EMREditSignCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditSignCell: EMREditCommonBottomCell {
    
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
    let txtView = ZZGrowTextView()
}

// MARK: - UI
extension EMREditSignCell {
    private func setUI() {
        let titleLabel = contentView.zz_add(subview: UILabel(text: "结论", font: .boldSize(16), textColor: .c3))
        
        setTxtView(txtView)
        contentView.addSubview(txtView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(24)
        }
        
        txtView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(bottomBtn.snp.top).offset(-42)
        }
    }
}
