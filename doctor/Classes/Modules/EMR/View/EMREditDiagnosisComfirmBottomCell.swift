//
//  EMREditDiagnosisComfirmBottomCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditDiagnosisComfirmBottomCell: EMREditDiagnosisStartBottomCell {
    
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
extension EMREditDiagnosisComfirmBottomCell {
    private func setUI() {
        
    }
}
