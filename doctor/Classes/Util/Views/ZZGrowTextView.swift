//
//  ZZGrowTextView.swift
//  healthcare_doctor
//
//  Created by 李向洲 on 2021/3/5.
//
//

import UIKit

class ZZGrowTextView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    let textView = ZZInnerGrowTextView()
    var config = Config() {
        didSet {
            layoutIfNeeded()
            textView.minHeight = config.minHeight
            textView.maxHeight = config.maxHeight
            updateTextViewConstraints()
            textView.receiveTextViewNotification()
        }
    }
    
    // MARK: - Private Property
    private var isToLimit = false
    private var originTxt = ""
    private var selectedStart = 0
    
    var limit = Int.max
    var sendClosure: ((String) -> Void)?
    var txtDidChangeClosure: ((String) -> Void)?
    var inputLimitClosure: ((String) -> Bool)?
}

// MARK: - UI
extension ZZGrowTextView {
    private func setUI() {
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .white
        backgroundColor = .white
        textView.delegate = self
        addSubview(textView)
        
        textView.minHeight = config.minHeight
        textView.maxHeight = config.maxHeight
        addTextViewConstraints()
    }
    
    func addTextViewConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false;
        
        // left
        textView.leftConstraint = NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: config.paddingInset.left)
        addConstraint(textView.leftConstraint)
        // right
        textView.rightConstraint = NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -config.paddingInset.right)
        addConstraint(textView.rightConstraint)
        // top
        textView.topConstraint = NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: config.paddingInset.top)
        addConstraint(textView.topConstraint)
        // bottom
        textView.bottomConstraint = NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -config.paddingInset.bottom)
        addConstraint(textView.bottomConstraint)
        
        let height = max(config.minHeight, textView.lineHeight)
        
        // height
        textView.heightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        addConstraint(textView.heightConstraint)
    }
    
    func updateTextViewConstraints() {
        textView.topConstraint.constant = config.paddingInset.top
        textView.leftConstraint.constant = config.paddingInset.left
        textView.bottomConstraint.constant = -config.paddingInset.bottom
        textView.rightConstraint.constant = -config.paddingInset.right
        let height = max(config.minHeight, textView.lineHeight)
        textView.heightConstraint.constant = height
    }
}

extension ZZGrowTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        originTxt = textView.text
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty {
            return true
        } else {
            if textView.returnKeyType == .send && text == "\n" {
                sendClosure?(textView.text)
                return false
            }
            
            if isToLimit { // 已经超过了限制
                return false
            }
            
            if let closure = inputLimitClosure, !closure(text) { // 不符合输入要求
                return false
            }
            
            return true
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let txt = textView.text ?? ""
        if UIApplication.shared.isChineseInputMode {
            if let range = textView.markedTextRange {
                selectedStart = textView.offset(from: textView.beginningOfDocument, to: range.start)
            } else {
                if txt.zz_ns.length > limit {
                    textView.text = originTxt
                    guard let start = textView.position(from: textView.beginningOfDocument, offset: selectedStart),
                        let end = textView.position(from: textView.beginningOfDocument, offset: selectedStart) else {
                            return;
                    }
                    textView.selectedTextRange = textView.textRange(from: start, to: end)
                    isToLimit = originTxt.zz_ns.length >= limit
                } else {
                    if let range = textView.selectedTextRange {
                        self.selectedStart = textView.offset(from: textView.beginningOfDocument, to: range.start)
                    }
                    originTxt = txt
                    isToLimit = txt.zz_ns.length >= limit
                }
            }
        } else {
            originTxt = txt
            isToLimit = txt.zz_ns.length >= limit
            if let range = textView.selectedTextRange {
                selectedStart = textView.offset(from: textView.beginningOfDocument, to: range.start)
            }
        }
        txtDidChangeClosure?(textView.text ?? "")
    }
}


extension ZZGrowTextView {
    struct Config {
        var paddingInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        var minHeight: CGFloat = 20
        var maxHeight: CGFloat = 50
    }
}

class ZZInnerGrowTextView: UITextView {
    // MARK: - LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Property
    fileprivate var leftConstraint: NSLayoutConstraint!
    fileprivate var rightConstraint: NSLayoutConstraint!
    fileprivate var topConstraint: NSLayoutConstraint!
    fileprivate var bottomConstraint: NSLayoutConstraint!
    fileprivate var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Public Property
    
    fileprivate var maxHeight: CGFloat = 0
    fileprivate var minHeight: CGFloat = 0
    
    var heightChangeClosure: (() -> Void)?
    
    var placeholder: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var placeholderColor: UIColor = .lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var placeholderInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var textContainerInset: UIEdgeInsets {
        didSet {
            var inset = textContainerInset
            inset.left += 3
            placeholderInsets = inset
        }
    }
    
    override var bounds: CGRect {
        didSet {
            if contentSize.height <= bounds.size.height + 1 {
                contentOffset = .zero
            } else if !isTracking {
                var offset = contentOffset
                
                if offset.y  > contentSize.height - bounds.size.height {
                    offset.y = contentSize.height - bounds.size.height;
                    if (!isDecelerating && !isTracking && !isDragging) {
                        contentOffset = offset;
                    }
                }
            }
        }
    }
    
    var lineHeight: CGFloat {
        CGFloat(Double(Int(font!.lineHeight * 1000)) / 1000.0)
    }
}

// MARK: -
extension ZZInnerGrowTextView {
    func setup() {
        scrollsToTop = false
        isUserInteractionEnabled = true
        
        contentMode = .redraw
        
        textContainerInset = .zero
        
        var inset = textContainerInset
        inset.left += 3
        placeholderInsets = inset
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveTextViewNotification), name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveTextViewNotification), name: UITextView.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveTextViewNotification), name: UITextView.textDidBeginEditingNotification, object: self)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if !placeholder.isEmpty && (text == nil || text!.isEmpty) {
            placeholderColor.set()
            
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byTruncatingTail
            style.alignment = textAlignment
            
            placeholder.zz_ns.draw(in: rect.inset(by: placeholderInsets), withAttributes: [NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: placeholderColor, NSAttributedString.Key.paragraphStyle: style])
        }
    }
}

extension ZZInnerGrowTextView {
    @objc fileprivate func receiveTextViewNotification() {
        setNeedsDisplay()
        
        var height = sizeThatFits(frame.size).height
        
        height = min(height, maxHeight)
        height = max(height, minHeight)
        
        if Int(height * 1000) != Int(heightConstraint.constant * 1000) {
            heightConstraint.constant = height
            if let closure = heightChangeClosure {
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: closure, completion: nil)
            }
        }
    }
}
