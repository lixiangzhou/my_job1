//
//  EMREditCommonAddCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditCommonAddCell: UITableViewCell {
    
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
   
    let addBtn = UIButton(title: "新增", font: .size(12), titleColor: .c4167f3, backgroundColor: .cF5F8FF)
    var addClosure: (() -> Void)?
    // MARK: - Private Property
    
    func setTopBottom(_ top: CGFloat, _ bottom: CGFloat) {
        
    }
}

// MARK: - UI
extension EMREditCommonAddCell {
    private func setUI() {
        addBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        addBtn.zz_setBorder(color: .c4167f3, width: 1)
        addBtn.zz_setCorner(radius: 4, masksToBounds: true)
        contentView.addSubview(addBtn)
        
        addBtn.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(84)
            make.right.equalTo(-88)
            make.height.equalTo(32)
            make.bottom.equalTo(-16)
        }
    }
    
}

extension EMREditCommonAddCell {
    
    @objc func addAction() {
        addClosure?()
    }
}
