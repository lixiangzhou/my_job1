//
//  CommonPicker.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/8/5.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

protocol CommonPickerString {
    var string: String { get }
}

extension String: CommonPickerString {
    var string: String {
        return self
    }
}

enum CommonPickerDataSouce<CommonPickerString> {
    case one([CommonPickerString])
    case two([GroupModel<CommonPickerString>])
}


class CommonPicker: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    let commmonPicker = UIPickerView()
    let titleLabel = UILabel(font: .size(18), textColor: .gray, textAlignment: .center)
    let cancelBtn = UIButton(title: "取消", font: .size(17), titleColor: .gray, target: self, action: #selector(cancelAction))
    let finishBtn = UIButton(title: "完成", font: .size(17), titleColor: .blue, target: self, action: #selector(finishAction))
    
    var dataSource: CommonPickerDataSouce<CommonPickerString>? {
        didSet {
            commmonPicker.reloadAllComponents()
        }
    }
    
    func selectOne(_ one: CommonPickerString?) {
        guard let dataSource = dataSource, let one = one else { return }
        switch dataSource {
        case let .one(ds):
            if let idx = ds.firstIndex(where: { $0.string == one.string }) {
                commmonPicker.selectRow(idx, inComponent: 0, animated: false)
            }
        case let .two(ds):
            for (idx, group) in ds.enumerated() {
                if group.title == one.string {
                    commmonPicker.selectRow(idx, inComponent: 0, animated: false)
                    break
                }
            }
        }
    }
    
    func selectOne(_ one: CommonPickerString?, two: CommonPickerString?) {
        guard let dataSource = dataSource, let one = one, let two = two else { return }
        switch dataSource {
        case .one:
            break
        case let .two(ds):
            for (idx, group) in ds.enumerated() where group.title == one.string {
                commmonPicker.selectRow(idx, inComponent: 0, animated: true)
                commmonPicker.reloadComponent(1)
                for (subIdx, subTitle) in group.list.enumerated() where subTitle.string == two.string {
                    commmonPicker.selectRow(subIdx, inComponent: 1, animated: true)
                }
            }
        }
    }
    
    var finishClosure: ((CommonPicker) -> Void)?
    var cancelClosure: ((CommonPicker) -> Void)?
    
//    var oldData: GroupModel?
}

// MARK: - UI
extension CommonPicker {
    private func setUI() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(bgView)
        
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        let toolBar = UIView()
        toolBar.backgroundColor = .white
        addSubview(toolBar)
        
        toolBar.addSubview(cancelBtn)
        toolBar.addSubview(titleLabel)
        toolBar.addSubview(finishBtn)
        toolBar.addBottomLine()
        
        commmonPicker.backgroundColor = .white
        commmonPicker.dataSource = self
        commmonPicker.delegate = self
        addSubview(commmonPicker)
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        toolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.bottom.equalToSuperview()
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalTo(cancelBtn.snp.right).offset(30)
            make.right.equalTo(finishBtn.snp.left).offset(-30)
        }
        
        commmonPicker.snp.makeConstraints { (make) in
            make.top.equalTo(toolBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension CommonPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let dataSource = dataSource else { return 0 }
        
        switch dataSource {
        case .one:
            return 1
        case .two:
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        
        switch dataSource {
        case let .one(ds):
            return ds.count
        case let .two(ds):
            if component == 0 {
                return ds.count
            } else {
                let row0 = pickerView.selectedRow(inComponent: 0)
                
                return ds[row0].list.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let dataSource = dataSource else { return nil }
        
        switch dataSource {
        case let .one(ds):
            return ds[row].string
        case let .two(ds):
            if component == 0 {
                return ds[row].title
            } else {
                let row0 = pickerView.selectedRow(inComponent: 0)
                return ds[row0].list[row].string
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let dataSource = dataSource else { return UIView() }
        
        let txt: String
        switch dataSource {
        case let .one(ds):
            txt = ds[row].string
        case let .two(ds):
            if component == 0 {
                txt = ds[row].title
            } else {
                let row0 = pickerView.selectedRow(inComponent: 0)
                txt = ds[row0].list[row].string
            }
        }
        
        return UILabel(text: txt, font: .size(18), textColor: .gray, numOfLines: 1, textAlignment: .center)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let dataSource = dataSource else { return }
        
        switch dataSource {
        case .one:
            break
        case .two:
            if component == 0 {
                pickerView.reloadComponent(1)
            }
        }
    }
}

// MARK: - Action
extension CommonPicker {
    @objc private func cancelAction() {
        hide()
        cancelClosure?(self)
    }
    
    @objc private func finishAction() {
        hide()
        finishClosure?(self)
    }
}

// MARK: - Public
extension CommonPicker {
    @discardableResult
    static func show(_ completion: ((CommonPicker) -> Void)? = nil) -> CommonPicker {
        let picker = CommonPicker()
        UIApplication.shared.keyWindow?.addSubview(picker)
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        picker.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            picker.alpha = 1
        }) { (_) in
            UIApplication.shared.endIgnoringInteractionEvents()
            completion?(picker)
        }
        return picker
    }
    
    @objc func hide() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
