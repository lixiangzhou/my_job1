//
//  EMREditDiagnosisCheckCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditDiagnosisCheckCell: UITableViewCell {
    
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
    var items = [String]() {
        didSet {
            setBtns(items)
        }
    }
    var addClosure: (() -> Void)?
    // MARK: - Private Property
    let btnView = UIView()
    var btns = [UIButton]()
}

// MARK: - UI
extension EMREditDiagnosisCheckCell {
    private func setUI() {
        contentView.addSubview(btnView)
        let addBtn = contentView.zz_add(subview: UIButton(title: "新增", font: .size(12), titleColor: .c4167f3, backgroundColor: .cF5F8FF, target: self, action: #selector(addAction)))
        addBtn.zz_setBorder(color: .c4167f3, width: 1)
        addBtn.zz_setCorner(radius: 4, masksToBounds: true)
        
        btnView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(12)
            make.right.equalTo(-16)
            make.height.equalTo(0)
        }
        
        addBtn.snp.makeConstraints { (make) in
            make.top.equalTo(btnView.snp.bottom).offset(16)
            make.left.equalTo(84)
            make.right.equalTo(-88)
            make.height.equalTo(32)
            make.bottom.equalTo(-12)
        }
    }
    
    func setBtns(_ titles: [String]) {
        btns.forEach { $0.removeFromSuperview() }
        
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
//            btn.setTitleColor(.white, for: .selected)
            btnView.addSubview(btn)
            btns.append(btn)
        }
        
        let maxY = btns.isEmpty ? 0 : btns.last!.zz_maxY
        btnView.snp.updateConstraints { (make) in
            make.height.equalTo(maxY)
        }
    }
}

extension EMREditDiagnosisCheckCell {
    @objc func btnAction() {
        
    }
    
    @objc func addAction() {
        addClosure?()
    }
}
