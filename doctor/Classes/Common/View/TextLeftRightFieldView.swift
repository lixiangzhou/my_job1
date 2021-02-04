//
//  TextLeftRightFieldView.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/8/5.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit
import ReactiveSwift

class TextLeftRightFieldView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    var config: TextLeftRightFieldViewConfig! {
        didSet {
            leftLabel.font = config.leftFont
            leftLabel.textColor = config.leftTextColor
            
            rightField.font = config.rightFont
            rightField.textColor = config.rightTextColor
            
            leftLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(config.leftPadding)
                make.centerY.equalToSuperview()
            }
            
            rightField.snp.remakeConstraints { (make) in
                make.right.equalTo(-config.rightPadding)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(config.rightWidth)
            }
            
            bottomLine.isHidden = !config.hasBottomLine
            bottomLine.backgroundColor = config.bottomLineColor
            
            bottomLine.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.equalTo(config.bottomLineLeftPadding)
                make.right.equalTo(-config.bottomLineRightPadding)
                make.height.equalTo(config.bottomLineHeight)
            }
        }
    }
    
    // MARK: -
    let leftLabel = UILabel()
    let rightField = UITextField()
    let bottomLine = UIView()
    
    
    var (fieldChangeSignal, fieldChangeObserver) = Signal<UITextField, Never>.pipe()
    var (fieldTxtChangeSignal, fieldTxtChangeObserver) = Signal<String, Never>.pipe()
    
    var inputLimitClosure: ((String) -> Bool)?
    var chinesePlugin: ChineseInputPlugin!
    var enableChinesePlugin: Bool = false {
        didSet {
            if enableChinesePlugin {
                if chinesePlugin == nil {
                    chinesePlugin = ChineseInputPlugin(rightField)
                    chinesePlugin.limit = config.rightLimit
                }
            } else {
                chinesePlugin = nil
            }
        }
    }    
}

// MARK: - UI
extension TextLeftRightFieldView {
    private func setUI() {
        addSubview(leftLabel)
        addSubview(rightField)
        addSubview(bottomLine)
        rightField.delegate = self
        
        fieldChangeSignal.observeValues { [weak self] (field) in
            self?.fieldTxtChangeObserver.send(value: field.text ?? "")
        }
        
        rightField.reactive.continuousTextValues.observeValues { [weak self] (_) in
            guard let self = self else { return }
            self.fieldChangeObserver.send(value: self.rightField)
        }
        
        config = TextLeftRightFieldViewConfig()
    }
}

extension TextLeftRightFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if enableChinesePlugin {
            chinesePlugin.originTxt = textField.text ?? ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let config = config else { return true }
        
        let text = textField.text ?? ""
        
        if string.isEmpty {
            if config.clearWhenFirstDelete {
                textField.text = nil
            }
            fieldChangeObserver.send(value: textField)
            return true
        } else {
            if config.rightLimit == 0 {
                fieldChangeObserver.send(value: textField)
                return true
            } else {
//                if enableChinesePlugin {
//                    if chinesePlugin.isToLimit { // 已经超过了限制
//                        return false
//                    }
//                }
//
//                if let closure = inputLimitClosure, !closure(string) { // 不符合输入要求
//                    return false
//                }
                
                if !enableChinesePlugin && UIApplication.shared.isChineseInputMode && textField.markedTextRange != nil {
                    fieldChangeObserver.send(value: textField)
                    return false
                }
                
                if enableChinesePlugin {
                    if chinesePlugin.isToLimit { // 已经超过了限制
                        fieldChangeObserver.send(value: textField)
                        return false
                    }
                    
                    if let closure = inputLimitClosure, !closure(string) {
                        fieldChangeObserver.send(value: textField)
                        return false
                    }
                } else {
                    if let closure = inputLimitClosure, !closure(string) {
                        fieldChangeObserver.send(value: textField)
                        return false
                    }
                    
                    if (text + string).zz_ns.length > config.rightLimit {
                        fieldChangeObserver.send(value: textField)
                        return false
                    }
                }
                fieldChangeObserver.send(value: textField)
                return true
            }
        }
    }
}

struct TextLeftRightFieldViewConfig {
    /// 左边的View距离左边的距离
    var leftPadding: CGFloat
    /// 右边的View距离右边的距离
    var rightPadding: CGFloat
    
    /// 文本字体
    var leftFont: UIFont
    /// 文本字体颜色
    var leftTextColor: UIColor
    
    /// 文本字体
    var rightFont: UIFont
    /// 文本字体颜色
    var rightTextColor: UIColor
    /// field宽度
    var rightWidth: CGFloat
    /// field 输入长度限制，0表示无限制
    var rightLimit: Int
    /// 获取焦点后首次删除时清空内容
    var clearWhenFirstDelete: Bool
    
    var hasBottomLine = true
    var bottomLineColor: UIColor?
    var bottomLineLeftPadding: CGFloat
    var bottomLineRightPadding: CGFloat
    var bottomLineHeight: CGFloat
    
    init(leftPadding: CGFloat = 15,
         rightPadding: CGFloat = 15,
         leftFont: UIFont = UIFont.size(16),
         leftTextColor: UIColor = UIColor.gray,
         rightFont: UIFont = UIFont.size(15),
         rightTextColor: UIColor = UIColor.gray,
         rightWidth: CGFloat = 150,
         rightLimit: Int = 0,
         clearWhenFirstDelete: Bool = false,
         hasBottomLine: Bool = true,
         bottomLineColor: UIColor = UIColor.lightGray,
         bottomLineLeftPadding: CGFloat = 0,
         bottomLineRightPadding: CGFloat = 0,
         bottomLineHeight: CGFloat = 0.5) {
        
        self.leftPadding = leftPadding
        self.rightPadding = rightPadding
        
        self.leftFont = leftFont
        self.leftTextColor = leftTextColor
        
        self.rightFont = rightFont
        self.rightTextColor = rightTextColor
        self.rightWidth = rightWidth
        self.rightLimit = rightLimit
        self.clearWhenFirstDelete = clearWhenFirstDelete
        
        self.hasBottomLine = hasBottomLine
        self.bottomLineLeftPadding = bottomLineLeftPadding
        self.bottomLineColor = bottomLineColor
        self.bottomLineRightPadding = bottomLineRightPadding
        self.bottomLineHeight = bottomLineHeight
    }
}


/// 中文输入
class ChineseInputPlugin {
    var isToLimit = false
    var originTxt = ""
    var selectedStart = 0
    var limit = 0
    weak var textField: UITextField?
    
    init(_ field: UITextField) {
        self.textField = field
        
        textField?.reactive.controlEvents(.editingChanged).observeValues { [weak self] (field) in
            guard let self = self, self.limit > 0 else { return }
            
            let fieldTxt = field.text ?? ""
            if UIApplication.shared.isChineseInputMode {
                if let range = field.markedTextRange {
                    self.selectedStart = field.offset(from: field.beginningOfDocument, to: range.start)
                } else {
                    if fieldTxt.zz_ns.length > self.limit {
                        field.text = self.originTxt
                        field.zz_set(selectedRange: NSRange(location: self.selectedStart, length: 0))
                        self.isToLimit = self.originTxt.zz_ns.length >= self.limit
                    } else {
                        if let range = field.selectedTextRange {
                            self.selectedStart = field.offset(from: field.beginningOfDocument, to: range.start)
                        }
                        self.originTxt = fieldTxt
                        self.isToLimit = fieldTxt.zz_ns.length >= self.limit
                    }
                }
            } else {
                self.originTxt = fieldTxt
                self.isToLimit = fieldTxt.zz_ns.length >= self.limit
                if let range = field.selectedTextRange {
                    self.selectedStart = field.offset(from: field.beginningOfDocument, to: range.start)
                }
            }
        }
    }
}
