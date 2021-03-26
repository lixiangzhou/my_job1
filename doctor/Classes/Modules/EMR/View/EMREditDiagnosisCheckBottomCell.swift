//
//  EMREditDiagnosisCheckBottomCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditDiagnosisCheckBottomCell: EMREditCommonBottomCell {
    
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
    
}

// MARK: - UI
extension EMREditDiagnosisCheckBottomCell {
    private func setUI() {
        bottomBtn.snp.makeConstraints { (make) in
            make.top.equalTo(48)
            make.left.equalTo(53)
            make.right.equalTo(-58)
            make.height.equalTo(42)
            make.bottom.equalTo(-42)
        }
    }
}
