//
//  EMRAddReuseListCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit

class EMRAddReuseListCell: UITableViewCell {
    
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
    let pannelBorderView = UIView()
    
    let timeLabel = UILabel(font: .size(14), textColor: .c3)
    let tagLabel = UILabel(font: .size(12), textColor: .white, textAlignment: .center)
    let diagnosisLabel = UILabel(font: .boldSize(14), textColor: .c3)
    
    
    // MARK: - Private Property
    let noTitleLabel = UILabel(font: .size(12), textColor: .c6)
    let noLabel = UILabel(font: .size(12), textColor: .c6)
    
    let stateTitleLabel = UILabel(font: .size(12), textColor: .c6)
    let stateLabel = UILabel(font: .size(12), textColor: .c42DC79)
    
    let hospitalTitleLabel = UILabel(font: .size(12), textColor: .c6)
    let hospitalLabel = UILabel(font: .size(12), textColor: .c6)
}

// MARK: - UI
extension EMRAddReuseListCell {
    private func setUI() {
        contentView.backgroundColor = .cf7f6f8
        let pannelView = UIView()
        contentView.addSubview(pannelView)
        pannelView.zz_setCorner(radius: 4, masksToBounds: true)
        pannelView.backgroundColor = .white
        
        tagLabel.zz_setCorner(radius: 4, masksToBounds: true)
        
        pannelBorderView.zz_setCorner(radius: 4, masksToBounds: true)
        pannelBorderView.zz_setBorder(color: .c4167f3, width: 1)
        pannelView.addSubview(pannelBorderView)
        
        pannelView.addSubview(timeLabel)
        pannelView.addSubview(tagLabel)
        pannelView.addSubview(diagnosisLabel)
        
        pannelView.addSubview(noTitleLabel)
        pannelView.addSubview(noLabel)
        
        pannelView.addSubview(stateTitleLabel)
        pannelView.addSubview(stateLabel)
        
        pannelView.addSubview(hospitalTitleLabel)
        pannelView.addSubview(hospitalLabel)
        
        pannelView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(16)
            make.bottom.right.equalTo(-16)
        }
        
        pannelBorderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(14)
            make.height.equalTo(20)
        }
        
        tagLabel.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.right.equalTo(-12)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        
        diagnosisLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(timeLabel.snp.bottom).offset(16)
            make.height.equalTo(20)
        }
        
        noTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(diagnosisLabel.snp.bottom).offset(8)
            make.left.equalTo(14)
            make.height.equalTo(17)
            make.width.equalTo(64)
        }
        
        noLabel.snp.makeConstraints { (make) in
            make.left.equalTo(noTitleLabel.snp.right)
            make.top.height.equalTo(noTitleLabel)
            make.right.equalTo(-14)
        }
        
        stateTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(noTitleLabel.snp.bottom).offset(4)
            make.left.width.height.equalTo(noTitleLabel)
        }
        
        stateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(stateTitleLabel.snp.right)
            make.top.height.equalTo(stateTitleLabel)
            make.right.equalTo(noLabel)
        }
        
        hospitalTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stateTitleLabel.snp.bottom).offset(4)
            make.left.width.height.equalTo(noTitleLabel)
            make.bottom.equalTo(-20)
        }
        
        hospitalLabel.snp.makeConstraints { (make) in
            make.left.equalTo(hospitalTitleLabel.snp.right)
            make.top.height.equalTo(hospitalTitleLabel)
            make.right.equalTo(noLabel)
        }
    }
}
