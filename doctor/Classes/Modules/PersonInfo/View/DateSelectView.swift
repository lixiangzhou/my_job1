//
//  DateSelectView.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/5.
//

import Foundation

// https://github.com/xiaozhuxiong121/PGDatePicker

class DateSelectView: BaseShowView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    let titleLabel = UILabel(text: "", font: .size(12), textColor: .c9)
    let picker = UIDatePicker()
    var finishClosure: ((Date) -> Void)?
    // MARK: - Private Property
    
}

// MARK: - UI
extension DateSelectView {
    private func setUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        let toolBar = RoundOptionView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 44), roundingCorners: [.topLeft, .topRight])
        addSubview(toolBar)
        
        let cancelBtn = UIButton(title: "取消", font: .size(14), titleColor: .c6, target: self, action: #selector(hide))
        let finishBtn = UIButton(title: "确定", font: .size(14), titleColor: .c4167f3, target: self, action: #selector(finishAction))
        
        toolBar.addSubview(titleLabel)
        toolBar.addSubview(cancelBtn)
        toolBar.addSubview(finishBtn)
        
        picker.backgroundColor = .white
        picker.maximumDate = Date()
        picker.locale = Locale(identifier: "zh")
        picker.datePickerMode = .dateAndTime
        picker.setValue(UIColor.red, forKey: "textColor")
//        picker.setValue(UIColor.blue, forKey: "highlightColor")
//        picker.setValue(UIColor.green, forKey: "magnifierLineColor")
        addSubview(picker)
        
        toolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.bottom.equalToSuperview()
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        picker.snp.makeConstraints { (make) in
            make.top.equalTo(toolBar.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
}

// MARK: - Action
extension DateSelectView {
    @objc private func finishAction() {
        hide()
        finishClosure?(picker.date)
    }
}
