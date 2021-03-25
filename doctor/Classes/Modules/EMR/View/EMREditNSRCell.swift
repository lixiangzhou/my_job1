//
//  EMREditNSRCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditNSRCell: UITableViewCell {
    
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
    
    let scoreView = UIView()
    var scoreBtns = [UIButton]()
    
    // MARK: - Private Property
    var selectBtn: UIButton?
}

// MARK: - UI
extension EMREditNSRCell {
    private func setUI() {
        contentView.addSubview(scoreView)
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        let wh: CGFloat = 28
        let padding: CGFloat = 16
        
        let maxW = UIScreen.zz_width - emrEditLeftWidth - 16 - 12
        
        for i in 0...10 {
            let btn = UIButton(title: "\(i)", font: .size(12), titleColor: .c6, backgroundColor: .cF7FBFF, target: self, action: #selector(btnAction))
            btn.frame = CGRect(x: x, y: y, width: wh, height: wh)
            btn.zz_setCircle()
            btn.setTitleColor(.white, for: .selected)
            scoreView.addSubview(btn)
            scoreBtns.append(btn)
            
            x = btn.zz_maxX + padding
            if x > maxW {
                x = 0
                y = y + wh + padding
            }
        }
        
        let nextBtn = contentView.zz_add(subview: UIButton(title: "下一页", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(nextAction)))
        nextBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        scoreView.snp.makeConstraints { (make) in
            make.left.top.equalTo(12)
            make.right.equalTo(-16)
            make.height.equalTo(scoreBtns.last!.zz_maxY)
        }
        
        nextBtn.snp.makeConstraints { (make) in
            make.top.equalTo(scoreView.snp.bottom).offset(60)
            make.left.equalTo(53)
            make.right.equalTo(-58)
            make.height.equalTo(42)
            make.bottom.equalTo(-42)
        }
    }
}

// MARK: - Action
extension EMREditNSRCell {
    @objc func btnAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = .cF7FBFF
        } else {
            scoreBtns.forEach {
                $0.isSelected = false
                $0.backgroundColor = .cF7FBFF
            }
            sender.isSelected = true
            sender.backgroundColor = .c4167f3
        }
    }
    
    @objc func nextAction() {
        
    }
}

// MARK: - Helper
extension EMREditNSRCell {
    
}

// MARK: - Other
extension EMREditNSRCell {
    
}

// MARK: - Public
extension EMREditNSRCell {
    
}
