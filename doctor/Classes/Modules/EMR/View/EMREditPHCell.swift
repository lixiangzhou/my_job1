//
//  EMREditPHCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditPHCell: UITableViewCell {
    
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
    
    let btnView = UIView()
    var btns = [UIButton]()
    
    let otherView = ZZGrowTextView()
    let sumaryView = ZZGrowTextView()
    
    var cleanClosure: (() -> Void)?
    var submitClosure: (() -> Void)?
    var nextClosure: (() -> Void)?
    // MARK: - Private Property
}

// MARK: - UI
extension EMREditPHCell {
    private func setUI() {
        contentView.addSubview(btnView)
        
        setTxtView(otherView)
        otherView.textView.font = .size(14)
        otherView.textView.placeholderColor = .c9
        otherView.textView.placeholder = "请说明："
        contentView.addSubview(otherView)
        
        let titleLabel = contentView.zz_add(subview: UILabel(text: "汇总", font: .boldSize(16), textColor: .c3))
        
        setTxtView(sumaryView)
        contentView.addSubview(sumaryView)
        
        let scaleBtn = contentView.zz_add(subview: UIButton(title: "收起", font: .size(12), titleColor: .c4167f3, imageName: "", backgroundColor: .cDDE4FF, target: self, action: #selector(scaleAction)))
        scaleBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        let cleanBtn = contentView.zz_add(subview: UIButton(title: "清空", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(cleanAction)))
        cleanBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        let submitBtn = contentView.zz_add(subview: UIButton(title: "提交", font: .size(12), titleColor: .c4167f3, backgroundColor: .cDDE4FF, target: self, action: #selector(submitAction)))
        submitBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        let nextBtn = contentView.zz_add(subview: UIButton(title: "下一页", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(nextAction)))
        nextBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        btnView.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.right.equalTo(-16)
            make.height.equalTo(0)
        }
        
        otherView.snp.makeConstraints { (make) in
            make.top.equalTo(btnView.snp.bottom).offset(16)
            make.left.equalTo(12)
            make.right.equalTo(-16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(otherView.snp.bottom).offset(16)
            make.height.equalTo(22)
        }
        
        sumaryView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        scaleBtn.snp.makeConstraints { (make) in
            make.top.equalTo(sumaryView.snp.bottom).offset(24)
            make.right.equalTo(sumaryView)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(scaleBtn)
            make.width.equalTo(48)
            make.height.equalTo(24)
            make.right.equalTo(scaleBtn.snp.left).offset(-16)
        }
        
        cleanBtn.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(scaleBtn)
            make.right.equalTo(submitBtn.snp.left).offset(-16)
        }
        
        nextBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cleanBtn.snp.bottom).offset(42)
            make.left.equalTo(53)
            make.right.equalTo(-58)
            make.height.equalTo(42)
            make.bottom.equalTo(-42)
        }
    }
    
    func setBtns(_ titles: [String]) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        let h: CGFloat = 28
        let padding: CGFloat = 16
        
        let maxW = UIScreen.zz_width - emrEditLeftWidth - 16 - 12
        
        for (_, title) in titles.enumerated() {
            var w = title.zz_size(withLimitWidth: 200, fontSize: 12).width + 16
            w = max(w, 52)
            let btn = UIButton(title: title, font: .size(12), titleColor: .c6, backgroundColor: .cF7FBFF, target: self, action: #selector(btnAction))
            
            let needWidth = w + padding
            if x + needWidth > maxW {
                x = 0
                y = y + h + padding
            }
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            x += needWidth
            
            btn.zz_setCorner(radius: 4, masksToBounds: true)
            btn.setTitleColor(.white, for: .selected)
            btnView.addSubview(btn)
            btns.append(btn)
        }
        
        let maxY = btns.isEmpty ? 0 : btns.last!.zz_maxY
        btnView.snp.updateConstraints { (make) in
            make.height.equalTo(maxY)
        }
    }
    
    func setTxtView(_ txtView: ZZGrowTextView) {
        txtView.zz_setCorner(radius: 4, masksToBounds: true)
        txtView.zz_setBorder(color: .cf5f5f5, width: 1)
        txtView.backgroundColor = .cFAFAFA
        txtView.textView.backgroundColor = .cFAFAFA
        txtView.config = .init(minHeight: 72, maxHeight: 72)
    }
}

// MARK: - Action
extension EMREditPHCell {
    @objc func btnAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = .cF7FBFF
        } else {
            btns.forEach {
                $0.isSelected = false
                $0.backgroundColor = .cF7FBFF
            }
            sender.isSelected = true
            sender.backgroundColor = .c4167f3
        }
    }
    
    @objc func scaleAction() {
        
    }
    
    @objc func cleanAction() {
//        cleanClosure?()
    }
    
    @objc func submitAction() {
//        submitClosure?()
    }
    
    @objc func nextAction() {
//        nextClosure?()
    }
}
