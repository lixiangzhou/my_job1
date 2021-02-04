//
//  TodoSearchView.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class TodoSearchView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    var searchClosure: (() -> Void)?
    var timeClosure: (() -> Void)?
    // MARK: - Private Property
}

// MARK: - UI
extension TodoSearchView {
    private func setUI() {
        let leftBgView = zz_add(subview: UIView())
        leftBgView.backgroundColor = .cfbfbfb
        let iconView = leftBgView.zz_add(subview: UIImageView(""))
        let tipLabel = leftBgView.zz_add(subview: UILabel(text: "搜索患者姓名", font: .size(12), textColor: .c6))
        leftBgView.zz_setCorner(radius: 16, masksToBounds: true)
        leftBgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchAction)))
        
        let rightView = zz_add(subview: ZZImagePositionButton(title: "选择时间", font: .boldSize(12), titleColor: .c3, imageName: "", target: self, action: #selector(timeAction), imgPosition: .right, leftPadding: 0, middlePadding: 8, rightPadding: 0)) as! UIButton
        rightView.adjustsImageWhenHighlighted = false
        
        leftBgView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.bottom.equalToSuperview()
            make.right.equalTo(rightView.snp.left).offset(16)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.bottom.equalTo(leftBgView)
        }
    }
}

// MARK: - Action
extension TodoSearchView {
    @objc private func timeAction() {
//        timeClosure?()
        let selView = TodoMsgSelectSearchTimeView()
        selView.interactiveViews = [self]
        selView.show(from: self)
    }
    
    @objc private func searchAction() {
        print(#function)
//        searchClosure?()
    }
}

// MARK: - Helper
extension TodoSearchView {
    
}

// MARK: - Other
extension TodoSearchView {
    
}

// MARK: - Public
extension TodoSearchView {
    
}
