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
    let searchField = UITextField()
    
    let selView = TodoMsgSelectSearchTimeView()
    var timeSelectView: ZZImagePositionButton!
    var timeTypeView: ZZImagePositionButton!
}

// MARK: - UI
extension TodoSearchView {
    private func setUI() {
        backgroundColor = .white
        let leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 32)))
        leftView.addSubview(UIImageView(frame: CGRect(x: 16, y: 8, width: 16, height: 16), image: UIImage(named: "todo_top_search")))
        searchField.leftView = leftView
        searchField.leftViewMode = .always
        searchField.backgroundColor = .cf6f6f6
        searchField.attributedPlaceholder = NSAttributedString(string: "搜索患者姓名", attributes: [NSAttributedString.Key.foregroundColor: UIColor.c6])
        searchField.font = .size(12)
        searchField.textColor = .c3
        searchField.zz_setCorner(radius: 16, masksToBounds: true)
        addSubview(searchField)
        
        timeSelectView = ZZImagePositionButton(title: "时间区间", font: .size(12), titleColor: .c6, imageName: "todo_top_calendar", backgroundColor: .cf6f6f6, target: self, action: #selector(timeAction), imgPosition: .right, leftPadding: 6, middlePadding: 6, rightPadding: 6)
        timeSelectView.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        timeSelectView.zz_setCorner(radius: 8, masksToBounds: true)
        addSubview(timeSelectView)
        
        timeTypeView = ZZImagePositionButton(title: "已逾期", font: .size(12), titleColor: .c6, imageName: "todo_top_arrow_down", backgroundColor: .cf6f6f6, target: self, action: #selector(typeAction), imgPosition: .right, leftPadding: 14, middlePadding: 4, rightPadding: 14)
        timeTypeView.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        timeTypeView.zz_setCorner(radius: 8, masksToBounds: true)
        
        searchField.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.height.equalTo(32)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension TodoSearchView {
    @objc private func timeAction() {
        
    }
    
    @objc private func searchAction() {
        print(#function)
    }
    
    @objc private func typeAction() {
        if selView.superview != nil {
            return
        }
        selView.interactiveViews = [self]
        selView.show(from: self)
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
    func addTypeView(_ addOrNot: Bool) {
        if addOrNot {
            addSubview(timeTypeView)
            
            timeSelectView.snp.makeConstraints { (make) in
                make.top.height.equalTo(searchField)
                make.left.equalTo(searchField.snp.right).offset(8)
                make.width.equalTo(timeSelectView.zz_width)
            }
            
            timeTypeView.snp.makeConstraints { (make) in
                make.top.height.equalTo(searchField)
                make.left.equalTo(timeSelectView.snp.right).offset(8)
                make.width.equalTo(timeTypeView.zz_width)
                make.right.equalTo(-16)
            }
        } else {
            timeSelectView.snp.makeConstraints { (make) in
                make.top.height.equalTo(searchField)
                make.left.equalTo(searchField.snp.right).offset(8)
                make.width.equalTo(timeSelectView.zz_width)
                make.right.equalTo(-16)
            }
        }
        
    }
}
