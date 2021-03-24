//
//  PatientManagerTopView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/23.
//  
//

import UIKit

class PatientManagerTopView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    
    var searchClosure: ((String) -> Void)?
    var selectClosure: ((String) -> Void)?
    
    // MARK: - Private Property
    let searchView = SearchField()
    
    let dropView = DropDownSelectView()
    var typeView: ZZImagePositionButton!
}

// MARK: - UI
extension PatientManagerTopView {
    private func setUI() {
        backgroundColor = .white
        addSubview(searchView)
        
        typeView = ZZImagePositionButton(title: "选择诊断", font: .size(12), titleColor: .c6, imageName: "todo_top_arrow_down", backgroundColor: .cf6f6f6, target: self, action: #selector(typeAction), imgPosition: .right, leftPadding: 14, middlePadding: 4, rightPadding: 14)
        typeView.frame = CGRect(x: 0, y: 0, width: 98, height: 32)
        typeView.zz_setCorner(radius: 8, masksToBounds: true)
        addSubview(typeView)
        
        dropView.selectClosure = { txt in
            print(txt)
        }
        
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.height.equalTo(32)
            make.bottom.equalToSuperview()
        }
        
        typeView.snp.makeConstraints { (make) in
            make.top.height.equalTo(searchView)
            make.left.equalTo(searchView.snp.right).offset(8)
            make.width.equalTo(typeView.zz_width)
            make.right.equalTo(-16)
        }
    }
}

// MARK: - Action
extension PatientManagerTopView {
    @objc private func typeAction() {
        endEditing(true)
        if dropView.superview != nil {
            return
        }
        dropView.show(from: typeView, size: CGSize(width: typeView.zz_width, height: 33 * 3))
    }
}
