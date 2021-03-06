//
//  InputFieldView.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/29.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class InputFieldView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    var hideTopLine = true {
        didSet {
            topLine.isHidden = hideTopLine
        }
    }
    
    var hideBottomLine = false {
        didSet {
            bottomLine.isHidden = hideBottomLine
        }
    }
    
    var topLineColor = UIColor.clear {
        didSet {
            topLine.backgroundColor = topLineColor
        }
    }
    
    var bottomLineColor = UIColor.clear {
        didSet {
            bottomLine.backgroundColor = bottomLineColor
        }
    }
    
    var text: String? {
        set {
            textField.text = newValue
            if bankNoMode {
                textField.text = formatToBankString(newValue ?? "")
            }
        }
        get {
            return textField.text
        }
    }
    
    var textColor = UIColor.gray {
        didSet {
            textField.textColor = textColor
        }
    }
    
    var textFont = UIFont.size(14) {
        didSet {
            textField.font = textFont
        }
    }
    
    var placeholder: String? = "占位文字" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        didSet {
            textField.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var leftImage: UIImage? {
        didSet {
            leftView.image = leftImage
            if let leftImage = leftImage {
                leftViewSize = leftImage.size
            }
        }
    }
    
    var rightImage: UIImage? {
        didSet {
            rightView.image = rightImage
            if let rightImage = rightImage {
                rightViewSize = rightImage.size
            }
        }
    }
    
    var rightSelectedImage: UIImage? {
        didSet {
            rightView.highlightedImage = rightSelectedImage
        }
    }
    
    var hasRightView = false {
        didSet {
            if hasRightView == false {
                rightPadding = 0
                rightViewSize = CGSize.zero
                right2InputViewPadding = 0
            }
            
            rightView.isHidden = !hasRightView
        }
    }
    
    var leftViewSize = CGSize(width: 30, height: 30) {
        didSet {
            if leftView.superview != nil {
                leftView.snp.updateConstraints({ (maker) in
                    maker.size.equalTo(leftViewSize)
                })
            }
        }
    }
    
    var leftPadding: CGFloat = 0 {
        didSet {
            if leftView.superview != nil {
                leftView.snp.updateConstraints({ (maker) in
                    maker.left.equalTo(leftPadding)
                })
            }
        }
    }
    
    /// leftView 和 textField 的间距
    var left2InputViewPadding = 12 {
        didSet {
            if leftView.superview != nil {
                leftView.snp.updateConstraints({ (maker) in
                    maker.right.equalTo(textField.snp.left).offset(-left2InputViewPadding)
                })
            }
        }
    }
    
    var rightViewSize = CGSize(width: 0, height: 0) {
        didSet {
            if rightView.superview != nil {
                rightView.snp.updateConstraints({ (maker) in
                    maker.size.equalTo(rightViewSize)
                })
            }
        }
    }
    
    var rightPadding: CGFloat = 0 {
        didSet {
            if rightView.superview != nil {
                rightView.snp.updateConstraints({ (maker) in
                    maker.right.equalTo(rightPadding)
                })
            }
        }
    }
    
    /// rightView 和 textField 的间距
    var right2InputViewPadding = 10 {
        didSet {
            if rightView.superview != nil {
                rightView.snp.updateConstraints({ (maker) in
                    maker.left.equalTo(textField.snp.right).offset(right2InputViewPadding)
                })
            }
        }
    }
    
    var inputLengthLimit = Int.max
    
    var bankNoMode = false
    
    var editEnabled: Bool {
        set {
            textField.isUserInteractionEnabled = newValue
        }
        get {
            return textField.isUserInteractionEnabled
        }
    }
    

    var editingChangedSignal: Signal<String, Never>!
    var (fieldChangeSignal, fieldChangeObserver) = Signal<UITextField, Never>.pipe()
    var (fieldTxtChangeSignal, fieldTxtChangeObserver) = Signal<String, Never>.pipe()
    var enableChineseInput = true
    var inputLimitClosure: ((String) -> Bool)?
    
    var chinesePlugin: ChineseInputPlugin!
    var enableChinesePlugin: Bool = false {
        didSet {
            if enableChinesePlugin {
                if chinesePlugin == nil {
                    chinesePlugin = ChineseInputPlugin(textField)
                    chinesePlugin.limit = inputLengthLimit
                }
            } else {
                chinesePlugin = nil
            }
        }
    }
    
    // MARK: - Private Property
    private let leftView = UIImageView()
    let rightView = UIImageView()
    
    let textField = UITextField()
    //    fileprivate let deleteView = UIImageView()
    
    private let topLine = UIView.sepLine()
    private let bottomLine = UIView.sepLine()
}

// MARK: - UI
extension InputFieldView {
    fileprivate func setUI() {
        textField.delegate = self
        
        editingChangedSignal = textField.reactive.controlEvents(.editingChanged).map { $0.text ?? "" }
        
        fieldChangeSignal.observeValues { [weak self] (field) in
            self?.fieldTxtChangeObserver.send(value: field.text ?? "")
        }
        
        textField.reactive.continuousTextValues.observeValues { [weak self] (_) in
            guard let self = self else { return }
            self.fieldChangeObserver.send(value: self.textField)
        }
        
        addSubview(textField)
        addSubview(leftView)
        addSubview(rightView)
        //        addSubview(deleteView)
        addSubview(topLine)
        addSubview(bottomLine)
        
        leftView.contentMode = .scaleAspectFit
        rightView.contentMode = .scaleAspectFit
        textField.clearButtonMode = .whileEditing
        
        topLine.isHidden = hideTopLine
        bottomLine.isHidden = hideBottomLine
        topLine.backgroundColor = topLineColor
        bottomLine.backgroundColor = bottomLineColor
        textField.textColor = textColor
        textField.text = text
        textField.placeholder = placeholder
        textField.attributedText = attributedPlaceholder
        textField.keyboardType = keyboardType
        leftView.image = leftImage
        rightView.image = rightImage
        rightView.highlightedImage = rightSelectedImage
        
        leftView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(leftPadding)
            maker.right.equalTo(textField.snp.left).offset(-left2InputViewPadding)
            maker.size.equalTo(leftViewSize)
        }
        
        textField.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(textField.snp.right).offset(right2InputViewPadding)
            maker.right.equalToSuperview().offset(rightPadding)
            maker.size.equalTo(rightViewSize)
        }
        
        topLine.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(0.5)
        }
        
        bottomLine.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalToSuperview()
            maker.height.equalTo(1)
        }
    }
}

// MARK: - Action
extension InputFieldView {
    
}

// MARK: - Helper
extension InputFieldView {
    func formatToBankString(_ text: String) -> String {
        var string = text.replacingOccurrences(of: " ", with: "")
        if string.count > 4 {
            string.insert(" ", at: string.index(string.startIndex, offsetBy: 4))
        }
        
        if string.count > 9 {
            string.insert(" ", at: string.index(string.startIndex, offsetBy: 9))
        }
        
        if string.count > 14 {
            string.insert(" ", at: string.index(string.startIndex, offsetBy: 14))
        }
        
        if string.count > 19 {
            string.insert(" ", at: string.index(string.startIndex, offsetBy: 19))
        }
        
        if string.count > 24 {
            string.insert(" ", at: string.index(string.startIndex, offsetBy: 24))
        }
        
        return string
    }
}

// MARK: - Delegate
extension InputFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if enableChinesePlugin {
            chinesePlugin.originTxt = textField.text ?? ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let emptyCharacter = Character(" ")
        
        func resetPositin(offset: Int) {
            let offset = max(0, offset)
            let newPosition = textField.position(from: textField.beginningOfDocument, offset: offset)!
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
        var text = textField.text ?? ""
        if range.length > 0 && string.isEmpty { // 删除
            if bankNoMode {
                if range.length == 1 {  // 删除一位
                    let toDeleteCharacter = text[text.index(text.startIndex, offsetBy: range.location)]
                    // 最后一位是空格则多删除一位
                    if range.location == text.count - 1 {
                        if toDeleteCharacter == emptyCharacter {
                            textField.deleteBackward()
                        }
                        fieldChangeObserver.send(value: textField)
                        return true
                    } else {
                        var offset = range.location
                        if toDeleteCharacter == emptyCharacter {
                            textField.deleteBackward()
                            offset -= 1
                        }
                        textField.deleteBackward()
                        textField.text = formatToBankString(textField.text!)
                        resetPositin(offset: offset)
                        fieldChangeObserver.send(value: textField)
                        return false
                    }
                } else if range.length > 1 {
                    textField.deleteBackward()
                    textField.text = formatToBankString(textField.text!)
                    
                    var offset = range.location
                    if range.location == 4 || range.location == 9 || range.location == 14 || range.location == 19 || range.location == 24 {
                        offset += 1
                    }
                    
                    if NSMaxRange(range) != text.count {    // 光标不是在最后
                        resetPositin(offset: offset)
                    }
                    fieldChangeObserver.send(value: textField)
                    return false
                } else {
                    fieldChangeObserver.send(value: textField)
                    return true
                }
            } else {
                if textField.isSecureTextEntry {
                    textField.text = textField.text?.zz_replace(start: range.location, length: range.length, with: string)
                    resetPositin(offset: range.location)
                    fieldChangeObserver.send(value: textField)
                    return false
                }
                return true
            }
        } else if string.count > 0 {    // 输入文字
            if bankNoMode {
                if (text + string).count > inputLengthLimit {   // 超过限制
                    fieldChangeObserver.send(value: textField)
                    return false
                }
                if string.trimmingCharacters(in: CharacterSet.decimalDigits).count > 0 {    // 不是数字
                    fieldChangeObserver.send(value: textField)
                    return false
                }
                
                textField.insertText(string)
                textField.text = formatToBankString(textField.text!)
                
                var offset = range.location + string.count
                if range.location == 4 || range.location == 9 || range.location == 14 || range.location == 19 || range.location == 24 {
                    offset += 1
                }
                resetPositin(offset: offset)
                fieldChangeObserver.send(value: textField)
                return false
            } else {
                if !enableChineseInput && UIApplication.shared.isChineseInputMode && textField.markedTextRange != nil {
                    return false
                }
                
                if enableChinesePlugin {
                    if chinesePlugin.isToLimit { // 已经超过了限制
                        return false
                    }
                    
                    if let closure = inputLimitClosure, !closure(string) {
                        return false
                    }
                } else {
                    if let closure = inputLimitClosure, !closure(string) {
                        return false
                    }
                    
                    if (text + string).zz_ns.length > inputLengthLimit {
                        fieldChangeObserver.send(value: textField)
                        return false
                    }
                }
                
                if textField.isSecureTextEntry {
                    let idx = text.index(text.startIndex, offsetBy: range.location)
                    text.insert(contentsOf: string, at: idx)
                    textField.text = text
                    resetPositin(offset: range.location + string.zz_ns.length)
                    fieldChangeObserver.send(value: textField)
                    return false
                }
            }
        }
        fieldChangeObserver.send(value: textField)
        return true
    }
}

// MARK: - Other
extension InputFieldView {
    @objc private func tapEye() {
        rightView.isHighlighted = !rightView.isHighlighted
        self.isSecureTextEntry = rightView.isHighlighted
    }
}

// MARK: - Public
extension InputFieldView {
    static func eyeFieldView(leftImage: UIImage? = nil, text: String? = nil, font: UIFont = .size(15), placeholder: String?, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = .lightGray) -> InputFieldView {
        let fieldView = InputFieldView.commonFieldView(leftImage: leftImage, text: text, font: font, placeholder: placeholder, leftSpacing: leftSpacing, rightSpacing: rightSpacing, bottomLineColor: bottomLineColor)
        
        fieldView.hasRightView = true
        fieldView.rightView.isUserInteractionEnabled = true
        fieldView.rightImage = UIImage(named: "login_pwd_eye_open")
        fieldView.rightSelectedImage = UIImage(named: "login_pwd_eye_close")
        fieldView.rightViewSize = CGSize(width: 20, height:
            40)
        fieldView.rightView.contentMode = .scaleAspectFit
        fieldView.right2InputViewPadding = 5
        fieldView.rightView.isHighlighted = true
        fieldView.isSecureTextEntry = true
        
        fieldView.rightView.addGestureRecognizer(UITapGestureRecognizer(target: fieldView, action: #selector(tapEye)))
        
        return fieldView
    }
    
    static func commonFieldView(leftImage: UIImage? = nil, text: String? = nil, font: UIFont = .size(15), placeholder: String?, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = .lightGray) -> InputFieldView {
        let fieldView = InputFieldView()
        fieldView.backgroundColor = .white
        fieldView.leftImage = leftImage
        fieldView.text = text
        fieldView.textFont = font
        fieldView.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        fieldView.hasRightView = false
        fieldView.bottomLineColor = bottomLineColor
        fieldView.leftPadding = leftSpacing
        fieldView.rightPadding = -rightSpacing
        fieldView.hideBottomLine = false
        fieldView.leftViewSize = CGSize(width: 25, height: 15)
        
        return fieldView
    }
    
    static func codeFieldView(leftImage: UIImage? = nil, text: String? = nil, placeholder: String?, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = .lightGray) -> (InputFieldView, UIButton, UILabel) {
        let btn = UIButton(title: "发送验证码", font: UIFont.boldSize(14), titleColor: UIColor.c4167f3)
        
        let size = btn.currentTitle!.zz_size(withLimitWidth: 100, fontSize: btn.titleLabel!.font.pointSize)
        btn.frame = CGRect(origin: .zero, size: CGSize(width: size.width, height: 30))
        
        let timeLabel = UILabel(text: "60S", font: btn.titleLabel!.font, textColor: .c4167f3, textAlignment: .right)
        timeLabel.isHidden = true
        
        let fieldView = InputFieldView.rightClickViewFieldView(leftImage: leftImage, text: text, placeholder: placeholder, clickView: btn, leftSpacing: leftSpacing, rightSpacing: rightSpacing, bottomLineColor: bottomLineColor)
        
        fieldView.rightView.addSubview(timeLabel)
        fieldView.right2InputViewPadding = 0
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
        }
        
        btn.reactive.controlEvents(.touchUpInside).observeValues { $0.isHidden = true }
        btn.reactive.controlEvents(.touchUpInside).observeValues { _ in timeLabel.isHidden = false }
        
        return (fieldView, btn, timeLabel)
    }
    
    static func rightClickViewFieldView(leftImage: UIImage? = nil, text: String? = nil, placeholder: String?, clickView: UIButton, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = .lightGray) -> InputFieldView {
        let fieldView = InputFieldView.commonFieldView(leftImage: leftImage, text: text, placeholder: placeholder, leftSpacing: leftSpacing, rightSpacing: rightSpacing, bottomLineColor: bottomLineColor)
        
        fieldView.hasRightView = true
        fieldView.rightView.isUserInteractionEnabled = true
        fieldView.rightViewSize = clickView.zz_size
        fieldView.right2InputViewPadding = 10
        
        fieldView.rightView.addSubview(clickView)
        return fieldView
    }
}

extension InputFieldView {
    func setPwdInputRule() {
        leftViewSize = CGSize(width: 20, height: 30)
        inputLengthLimit = 20
        textField.keyboardType = .numbersAndPunctuation
        isSecureTextEntry = true
        enableChineseInput = false
        inputLimitClosure = {
            return $0.isPwd
        }
    }
    
    func setMobileInputRule() {
        inputLengthLimit = 11
        keyboardType = .numberPad
        leftViewSize = CGSize(width: 20, height: 32)
        inputLimitClosure = {
            return $0.isNumber
        }
    }
    
    func setCodeInputRule() {
        inputLengthLimit = 6
        keyboardType = .numberPad
        leftViewSize = CGSize(width: 20, height: 30)
        inputLimitClosure = {
            return $0.isNumber
        }
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        }
    }
}

