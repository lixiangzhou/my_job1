//
//  EMREditCommonTopCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditCommonTopCell: UITableViewCell {
    
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
    var hasX: Bool = true {
        didSet {
            xView.isHidden = !hasX
            
            titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(hasX ? 28 : 12)
            }
        }
    }
    
    
    let noLabel = UILabel(text: "病历号：", font: .size(12), textColor: .c6)
    let diagnosisLabel = UILabel(text: "诊断：", font: .size(12), textColor: .c6)
    let dateLabel = UILabel(text: "创建日期：", font: .size(12), textColor: .c6)
    
    let descLabel = UILabel(text: "已自动填写最近一次病历信息，可继续重新填写或清空已有数据", font: .size(12), textColor: .cF98A21)
    
    let xView = UIImageView(image: UIImage(named: "mine_auth_xx"))
    let titleLabel = UILabel(font: .boldSize(16), textColor: .c3)
    // MARK: - Private Property
    
}

// MARK: - UI
extension EMREditCommonTopCell {
    private func setUI() {
        let sepView = UIView()
        sepView.backgroundColor = .cfbfbfb
        contentView.addSubview(noLabel)
        contentView.addSubview(diagnosisLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(sepView)
        contentView.addSubview(xView)
        contentView.addSubview(titleLabel)
        
        noLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.right.equalTo(-16)
        }
        
        diagnosisLabel.snp.makeConstraints { (make) in
            make.top.equalTo(noLabel.snp.bottom).offset(4)
            make.left.right.equalTo(noLabel)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(diagnosisLabel.snp.bottom).offset(4)
            make.left.right.equalTo(noLabel)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.left.right.equalTo(noLabel)
        }
        
        sepView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(8)
            make.left.right.equalTo(noLabel)
            make.height.equalTo(8)
        }
        
        xView.snp.makeConstraints { (make) in
            make.width.height.equalTo(8)
            make.left.equalTo(12)
            make.bottom.equalTo(-7)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sepView.snp.bottom).offset(16)
            make.left.equalTo(28)
            make.bottom.equalToSuperview()
            make.height.equalTo(22)
        }
    }
}
