//
//  DatePicker.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/8/5.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

class DatePicker: BaseShowView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    let datePicker = UIDatePicker()
    let cancelBtn = UIButton(title: "取消", font: .size(17), titleColor: .gray, target: self, action: #selector(cancelAction))
    let finishBtn = UIButton(title: "完成", font: .size(17), titleColor: UIColor.blue, target: self, action: #selector(finishAction))
    
    var finishClosure: ((DatePicker, Date) -> Void)?
    var cancelClosure: ((DatePicker) -> Void)?
}

// MARK: - UI
extension DatePicker {
    private func setUI() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(bgView)
        
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        let toolBar = UIView()
        toolBar.backgroundColor = .white
        addSubview(toolBar)
        
        toolBar.addSubview(cancelBtn)
        toolBar.addSubview(finishBtn)
        toolBar.addBottomLine()
        
        datePicker.locale = Locale(identifier: "zh")
        datePicker.datePickerMode = .date
        datePicker.minimumDate = "1900-01-01".zz_date(withDateFormat: "yyyy-MM-dd")
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = .white
        addSubview(datePicker)
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        toolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(toolBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Action
extension DatePicker {
    @objc private func cancelAction() {
        hide()
        cancelClosure?(self)
    }
    
    @objc private func finishAction() {
        hide()
        finishClosure?(self, datePicker.date)
    }
}

// MARK: - Public
extension DatePicker {
    @discardableResult
    static func show() -> DatePicker {
        let view = DatePicker()
        view.show()
        return view
    }
}
