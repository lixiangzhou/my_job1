//
//  SearchField.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/22.
//  
//

import UIKit

class SearchField: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    let field = UITextField()
    var cancelBtn: UIButton!
    // MARK: - Private Property
    var cancelWidth: CGFloat = 40 {
        didSet {
            cancelBtn.snp.remakeConstraints { (make) in
                make.width.equalTo(cancelWidth)
                make.top.bottom.equalToSuperview()
                make.right.equalToSuperview()
            }
        }
    }
}

// MARK: - UI
extension SearchField {
    private func setUI() {
        let leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 32)))
        leftView.addSubview(UIImageView(frame: CGRect(x: 16, y: 8, width: 16, height: 16), image: UIImage(named: "todo_top_search")))
        field.leftView = leftView
        field.leftViewMode = .always
        field.backgroundColor = .cf6f6f6
        field.font = .size(12)
        field.attributedPlaceholder = NSAttributedString(string: "搜索患者姓名", attributes: [NSAttributedString.Key.foregroundColor: UIColor.c6])
        field.textColor = .c3
        field.zz_setCorner(radius: 16, masksToBounds: true)
        field.clearButtonMode = .whileEditing
        field.delegate = self
        addSubview(field)
        
        cancelBtn = UIButton(title: "取消", font: .size(12), titleColor: .c9, target: self, action: #selector(cancelAction))
        addSubview(cancelBtn)
        cancelWidth = 40
        cancelBtn.alpha = 0
        
        field.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(0)
        }
    }
}

// MARK: - Action
extension SearchField {
    @objc func cancelAction() {
        field.endEditing(true)
    }
}

// MARK: - Helper
extension SearchField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        field.snp.updateConstraints { (make) in
            make.right.equalTo(-cancelWidth)
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.cancelBtn.alpha = 1
            self.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        field.snp.updateConstraints { (make) in
            make.right.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.cancelBtn.alpha = 0
            self.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
}

// MARK: - Other
extension SearchField {
    
}

// MARK: - Public
extension SearchField {
    
}
