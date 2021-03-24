//
//  PatientManagerListCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/23.
//  
//

import UIKit

class PatientManagerListCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: PatientManagerListModel! {
        didSet {
            setTopInfo()
            setPatientInfo()
            setMidInfo()
            setActionInfo()
        }
    }
    
    // MARK: - Public Property
    
    let topView = UIView()
    let timeLabel = UILabel(font: .size(14), textColor: .c3)
    let stateLabel = UILabel()
    let topBottmFirstLabel = UILabel(font: .size(12), textColor: .c6)
    let topBottmSecondLabel = UILabel(font: .size(12), textColor: .c6)
    var topBottomLabels = [UILabel]()
    
    let midView = UIView()
    var midlabels = [UILabel]()
    
    let infoView = UIView()
    let iconView = UIImageView()
    let nameLabel = UILabel(text: " ", font: .boldSize(16), textColor: .c3)
    let ageLabel = UILabel(text: " ", font: .size(14), textColor: .c3)
    let sexLabel = UILabel(text: " ", font: .size(16), textColor: .c3)
    let idLabel = UILabel(text: " ", font: .size(12), textColor: .c6)
    
    let actionView = UIView()
    var actionBtns = [UIButton]()
    
    let bottomView = UIView()
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension PatientManagerListCell {
    private func setUI() {
        topView.addBottomLine(left: 16, right: 16, height: 1)
        
        topView.backgroundColor = .white
        infoView.backgroundColor = .white
        midView.backgroundColor = .white
        actionView.backgroundColor = .white
        bottomView.backgroundColor = .cf8f8f8
        
        topView.addSubview(timeLabel)
        topView.addSubview(stateLabel)
        topView.addSubview(topBottmFirstLabel)
        topView.addSubview(topBottmSecondLabel)
        
        topBottomLabels.append(topBottmFirstLabel)
        topBottomLabels.append(topBottmSecondLabel)
        
        let margin: CGFloat = 16
        timeLabel.frame = CGRect(x: margin, y: margin, width: UIScreen.zz_width - margin * 2, height: 20)
        
        setInfoView()
        
        contentView.addSubview(topView)
        contentView.addSubview(infoView)
        contentView.addSubview(midView)
        contentView.addSubview(actionView)
        contentView.addSubview(bottomView)
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        infoView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        midView.snp.makeConstraints { (make) in
            make.top.equalTo(infoView.snp.bottom)
            make.height.equalTo(0)
            make.left.right.equalToSuperview()
        }
        
        actionView.snp.makeConstraints { (make) in
            make.top.equalTo(midView.snp.bottom)
            make.height.equalTo(0)
            make.left.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(actionView.snp.bottom)
            make.height.equalTo(8)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func setInfoView() {
        iconView.zz_setCorner(radius: 20, masksToBounds: true)
        infoView.addSubview(iconView)
        infoView.addSubview(nameLabel)
        infoView.addSubview(sexLabel)
        infoView.addSubview(ageLabel)
        infoView.addSubview(idLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(30)
            make.width.height.equalTo(40)
            make.bottom.equalTo(-18)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(iconView.snp.right).offset(8)
            make.height.equalTo(22)
        }
        
        sexLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(16)
        }
        
        ageLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLabel)
            make.left.equalTo(sexLabel.snp.right).offset(16)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView).offset(2)
            make.left.equalTo(nameLabel)
        }
    }
}

// MARK: - Action
extension PatientManagerListCell {
    @objc func btnAction(_ btn: UIButton) {
        
    }
}

// MARK: - Helper
extension PatientManagerListCell {
    
    func setTopInfo() {
        timeLabel.text = model.timeString
        
        let margin = timeLabel.zz_x
        var maxY = timeLabel.zz_maxY
        
        let stateHidden = model.stateAttributeString == nil
        stateLabel.isHidden = stateHidden
        stateLabel.attributedText = model.stateAttributeString
        
        if !stateHidden {
            stateLabel.frame = CGRect(x: margin, y: maxY + 8, width: timeLabel.zz_width, height: 20)
            maxY = stateLabel.zz_maxY
        }
        
        topBottomLabels.forEach { $0.isHidden = true }
        if !model.topBottomAttributeStrings.isEmpty {
            var x = margin
            for (idx, attr) in model.topBottomAttributeStrings.enumerated() {
                let label = topBottomLabels[idx]
                label.attributedText = attr
                
                let w = attr.string.zz_size(withLimitWidth: 1000, fontSize: label.font.pointSize).width
                label.frame = CGRect(x: x, y: maxY + 4, width: w, height: 17)
                x = label.zz_maxX + 16
                label.isHidden = false
            }
            maxY = topBottomLabels.first!.zz_maxY
        }
        
        topView.snp.updateConstraints { (make) in
            make.height.equalTo(maxY + 8)
        }
    }
    
    func setPatientInfo() {
        iconView.backgroundColor = .blue
        nameLabel.text = "大一"
        ageLabel.text = "34"
        sexLabel.text = "男"
        idLabel.text = "身份证：110********280011"
    }
    
    func setMidInfo() {
        midlabels.forEach { $0.isHidden = true }
        var y: CGFloat = 0
        for (idx, string) in model.midStrings.enumerated() {
            let label: UILabel
            if idx < midlabels.count {
                label = midlabels[idx]
                label.isHidden = false
            } else {
                label = UILabel(font: .size(14), textColor: .c3)
                midView.addSubview(label)
                midlabels.append(label)
            }
            let size = string.zz_size(withLimitWidth: UIScreen.zz_width - 30 * 2, fontSize: label.font.pointSize)
            label.frame = CGRect(x: 30, y: y, width: size.width, height: size.height)
            label.text = string
            y = label.frame.maxY + 8
        }
        
        midView.snp.updateConstraints { (make) in
            make.height.equalTo(y == 0 ? 0 : (y + 8))
        }
    }
    
    func setActionInfo() {
        actionBtns.forEach { $0.isHidden = true }
        
        let maxW = UIScreen.zz_width
        let padding: CGFloat = 8
        let startX: CGFloat = maxW - padding
        var x: CGFloat = startX
        var y: CGFloat = 0
        let h: CGFloat = 32
        
        var lastBtn: UIButton?
        for (idx, model) in model.actionModels.enumerated() {
            let btn: UIButton
            if idx < actionBtns.count {
                btn = actionBtns[idx]
                btn.isHidden = false
            } else {
                btn = UIButton(font: .size(12), titleColor: .c4167f3, target: self, action: #selector(btnAction))
                btn.zz_setCorner(radius: 4, masksToBounds: true)
                btn.zz_setBorder(color: .c4167f3, width: 1)
                
                actionView.addSubview(btn)
                actionBtns.append(btn)
            }
            
            let title = model
            
            btn.setTitle(title, for: .normal)
            btn.tag = idx
            var w = title.zz_size(withLimitWidth: 1000, fontSize: btn.titleLabel!.font.pointSize).width + 16
            w = max(w, 64)
            
            x = x - w - padding
            if x < 16 {
                x = startX - w - padding
                y = y + h + padding
            }
            
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            lastBtn = btn
        }
        
        let maxY = lastBtn?.frame.maxY ?? 0
        
        actionView.snp.updateConstraints { (make) in
            make.height.equalTo(maxY == 0 ? 0 : (maxY + 16))
        }
    }
}

// MARK: - Other
extension PatientManagerListCell {
    
}

// MARK: - Public
extension PatientManagerListCell {
    
}
