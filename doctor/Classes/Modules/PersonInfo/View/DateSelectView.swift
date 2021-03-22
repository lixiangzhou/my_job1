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
//    let picker = UIDatePicker()
    let datePicker = ZZDatePicker()
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
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        addSubview(bgView)
        
        let cfg = ZZDatePicker.Config()
        cfg.dateStyle = .yyyy_MM_dd
        datePicker.config = cfg
        datePicker.backgroundColor = .white
        
        let arr = ["年", "月", "日"]
        
        let itemW: CGFloat = 73
        
        for (idx, unit) in arr.enumerated() {
            let label = UILabel(text: unit, font: UIFont.AvenirNext.demibold.size(13), textColor: UIColor(stringHexValue: "#989DB3"), textAlignment: .right)
            label.frame = CGRect(x: CGFloat(idx) * itemW, y: 0, width: itemW, height: cfg.rowHeight)
            datePicker.selectBgView.addSubview(label)
        }
        
        datePicker.viewForRowInComponentClosure = { _, _, unit, value in
            let view = UIView()
            let label = UILabel(text: "\(value)", font: UIFont.AvenirNext.demibold.size(14), textColor: .c3, textAlignment: .center)
            view.addSubview(label)
            label.zz_setCorner(radius: 4, masksToBounds: true)
            label.backgroundColor = .cfbfbfb
            label.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(48)
                make.height.equalTo(24)
            }
            return view
        }
        addSubview(datePicker)
        
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
        
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(toolBar.snp.bottom)
            make.height.equalTo(240)
            make.width.equalTo(itemW * 3)
            make.centerX.bottom.equalToSuperview()
//            make.bottom.left.right.equalToSuperview()
        }
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(datePicker)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension DateSelectView {
    @objc private func finishAction() {
        hide()
        finishClosure?(datePicker.config.selectDate)
    }
}
