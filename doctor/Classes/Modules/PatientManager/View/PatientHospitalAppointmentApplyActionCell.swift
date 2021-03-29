//
//  PatientHospitalAppointmentApplyActionCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class PatientHospitalAppointmentApplyActionCell: UITableViewCell {
    
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
    
    let titleLabel = UILabel(text: "住院申请", font: .size(14), textColor: .c3)
    // MARK: - Private Property
    
    var agreeBtn: UIButton!
    var rejectBtn: UIButton!
}

// MARK: - UI
extension PatientHospitalAppointmentApplyActionCell {
    private func setUI() {
        agreeBtn = UIButton(title: "同意", font: .size(10), titleColor: .c4167f3, backgroundColor: .cEEF1FF, target: self, action: #selector(agreeAction))
        agreeBtn.setTitleColor(.white, for: .selected)
        agreeBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        rejectBtn = UIButton(title: "拒绝", font: .size(10), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(rejectAction))
        agreeBtn.setTitleColor(.white, for: .selected)
        rejectBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(agreeBtn)
        contentView.addSubview(rejectBtn)
        contentView.addBottomLine(left: 16, right: 16, height: 1)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.bottom.equalTo(-8)
            make.top.equalTo(12)
        }
        
        agreeBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-4)
            make.width.equalTo(48)
            make.height.equalTo(28)
            make.right.equalTo(-16)
        }
        
        rejectBtn.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(agreeBtn)
            make.right.equalTo(agreeBtn.snp.left).offset(-16)
        }
    }
}

// MARK: - Action
extension PatientHospitalAppointmentApplyActionCell {
    @objc func agreeAction() {
        rejectBtn.isSelected = false
        agreeBtn.isSelected = true
        
        agreeBtn.backgroundColor = .c4167f3
        rejectBtn.backgroundColor = .cEEF1FF
    }
    
    @objc func rejectAction() {
        rejectBtn.isSelected = true
        agreeBtn.isSelected = false
        
        agreeBtn.backgroundColor = .cEEF1FF
        rejectBtn.backgroundColor = .c4167f3
    }
}
