//
//  EmptyDataView.swift
//  healthcare_doctor
//
//  Created by 李向洲 on 2020/7/25.
//  Copyright © 2020 LXZ. All rights reserved.
//

import UIKit

enum EmptyDataViewItem {
    /// UIImageView 控件
    /// 注意：width 与 height 必须同时设置；否则按照图片宽高设置
    case imageView(imageName: String, mode: UIView.ContentMode = .scaleAspectFit, backgroundColor: UIColor? = nil, width: CGFloat? = nil, height: CGFloat? = nil, target: NSObject? = nil, action: Selector? = nil)
    
    /// UILabel 控件
    case label(text: String? = nil, font: UIFont? = nil, textColor: UIColor? = nil, attributedString: NSAttributedString? = nil, alignment: NSTextAlignment = .center, numberOfLines: Int = 0, width: CGFloat? = nil, target: NSObject? = nil, action: Selector? = nil)
    
    /// UIButton 控件
    case button(title: String? = nil, font: UIFont? = nil, textColor: UIColor = UIColor.darkText, imageName: String? = nil, backgroundName: String? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, width: CGFloat? = nil, height: CGFloat? = nil, target: NSObject? = nil, action: Selector? = nil)
    
    /// 自定义控件
    case custom(view: UIView, width: CGFloat? = nil, height: CGFloat? = nil)
    
    /// 内部控件的间距
    case space(CGFloat)
    
    /// 内容识图整体的偏移量
    case offset(CGFloat = 0)
    
    case emptyConfig(backgroundColor: UIColor? = nil, isEnabled: Bool? = nil)
}

extension EmptyDataViewItem {
     private var caseValue: String {
        switch self {
        case let .imageView(imageName: imageName, mode: mode, backgroundColor: backgroundColor, width: width, height: height, target: target, action: action):
            return "image_\(imageName)_\(mode.rawValue)_\(String(describing: backgroundColor))_\(String(describing: width))_\(String(describing: height))_\(String(describing: target))_\(String(describing: action))"
            
        case let .label(text: text, font: font, textColor: textColor, attributedString: attributedString, alignment: alignment, numberOfLines: numberOfLines, width: width, target: target, action: action):
            return "label_\(String(describing: text))_\(String(describing: font))_\(String(describing: textColor))_\(String(describing: attributedString))_\(alignment)_\(numberOfLines)_\(String(describing: width))_\(String(describing: target))_\(String(describing: action))"
            
        case let .button(title: title, font: font, textColor: textColor, imageName: imageName, backgroundName: backgroundName, backgroundColor: backgroundColor, cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor, width: width, height: height, target: target, action: action):
            return "button_\(String(describing: title))_\(String(describing: font))_\(textColor)_\(String(describing: imageName))_\(String(describing: backgroundName))_\(String(describing: backgroundColor))_\(String(describing: cornerRadius))_\(String(describing: borderWidth))_\(String(describing: borderColor))_\(String(describing: width))_\(String(describing: height))_\(String(describing: target))_\(String(describing: action))"
            
        case let .custom(view: view, width: width, height: height):
            return "custom_\(view)_\(String(describing: width))_\(String(describing: height))"
            
        case let .space(space):
            return "space_\(space)"
            
        case let .offset(offset):
            return "offset_\(offset)"
        case let .emptyConfig(backgroundColor: backgroundColor, isEnabled: isEnabled):
            return "backgroundColor_\(String(describing: backgroundColor))_\(String(describing: isEnabled))"
        }
    }
    
    var width: CGFloat? {
        switch self {
        case let .label(text: _, font: _, textColor: _, attributedString: _, alignment: _, numberOfLines: _, width: width, target: _, action: _):
            return width
        case let .button(title: _, font: _, textColor: _, imageName: _, backgroundName: _, backgroundColor: _, cornerRadius: _, borderWidth: _, borderColor: _, width: width, height: _, target: _, action: _):
            return width
        case let .imageView(imageName: _, mode: _, backgroundColor: _, width: width, height: _, target: _, action: _):
            return width
        case let .custom(view: _, width: width, height: _):
            return width
        case .space, .offset, .emptyConfig:
            return nil
        }
    }
    
    var height: CGFloat? {
        switch self {
        case let .button(title: _, font: _, textColor: _, imageName: _, backgroundName: _, backgroundColor: _, cornerRadius: _, borderWidth: _, borderColor: _, width: _, height: height, target: _, action: _):
            return height
        case let .imageView(imageName: _, mode: _, backgroundColor: _, width: _, height: height, target: _, action: _):
            return height
        case let .custom(view: _, width: _, height: height):
            return height
        case .space, .offset, .label, .emptyConfig:
            return nil
        }
    }
    
    var view: UIView? {
        switch self {
        case .imageView:
            return imageView
        case .button:
            return button
        case let .custom(view: v, width: _, height: _):
            return v
        case .label:
            return label
        case .space, .offset, .emptyConfig:
            return nil
        }
    }
    
    var customView: UIView? {
        if case let .custom(view: view, width: _, height: _) = self {
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        return nil
    }
    
    var button: UIButton? {
        if case let .button(title: title, font: font, textColor: textColor, imageName: imageName, backgroundName: backgroundName, backgroundColor: backgroundColor, cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor, width: _, height: _, target: target, action: action) = self {
            
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            
            btn.setTitle(title, for: .normal)
            btn.titleLabel?.font = font
            btn.setTitleColor(textColor, for: .normal)
            
            if let imageName = imageName {
                btn.setImage(UIImage(named: imageName), for: .normal)
            }
            
            if let backgroundName = backgroundName {
                btn.setBackgroundImage(UIImage(named: backgroundName), for: .normal)
            }
            
            btn.backgroundColor = backgroundColor
            
            if let cornerRadius = cornerRadius {
                btn.layer.cornerRadius = cornerRadius
                btn.layer.masksToBounds = true
            }
            
            if let borderWidth = borderWidth, let borderColor = borderColor {
                btn.layer.borderColor = borderColor.cgColor
                btn.layer.borderWidth = borderWidth
            }
            
            if let target = target, let action = action {
                btn.addTarget(target, action: action, for: .touchUpInside)
            }
            return btn
        }
        return nil
    }
    
    var label: UILabel? {
        if case let .label(text: text, font: font, textColor: textColor, attributedString: attributedString, alignment: alignment, numberOfLines: numberOfLines, width: _, target: target, action: action) = self {
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            
            if text != nil {
                label.text = text
            }
            
            if font != nil {
                label.font = font
            }
            
            if textColor != nil {
                label.textColor = textColor
            }
            
            if attributedString != nil {
                label.attributedText = attributedString
            }
            
            label.textAlignment = alignment
            label.numberOfLines = numberOfLines
            
            if let target = target, let action = action {
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
            }
            return label
        }
        return nil
    }
    
    var imageView: UIImageView? {
        if case let .imageView(imageName: imageName, mode: mode, backgroundColor: backgroundColor, width: _, height: _, target: target, action: action) = self {
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = mode
            imageView.backgroundColor = backgroundColor
            
            if let target = target, let action = action {
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
            }
            return imageView
        }
        return nil
    }
}

extension EmptyDataViewItem: Hashable {
    static func == (lhs: EmptyDataViewItem, rhs: EmptyDataViewItem) -> Bool {
        lhs.caseValue == rhs.caseValue
    }
}

class EmptyDataView: UIView {
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        superview?.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        updateSizeConstraints(superview)
    }
    
    deinit {
        print("empytdateview deinit")
    }
    
    
    private var sizeConstraints = [NSLayoutConstraint]()
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        updateSizeConstraints(superview)
    }
    
    func updateSizeConstraints(_ sup: UIView?) {
        if let rect = sup?.bounds, rect != .zero {
            
            if !sizeConstraints.isEmpty {
                removeConstraints(sizeConstraints)
            }
            sizeConstraints = [
                NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: rect.width),
                NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: rect.height)
            ]
            
            addConstraints(sizeConstraints)
        }
    }
}

private var emptyDataConfigItemsKey = "emptyDataConfigItemsKey"
private var cacheKey = "cacheKey"

private typealias Cache = Dictionary<[EmptyDataViewItem], EmptyDataView>

extension UIView {
    private var cache: Cache {
        set {
            objc_setAssociatedObject(self, &cacheKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let _cache = objc_getAssociatedObject(self, &cacheKey) as? Cache {
                return _cache
            }
            let _cache = Cache()
            objc_setAssociatedObject(self, &cacheKey, _cache, .OBJC_ASSOCIATION_RETAIN)
            return _cache
        }
    }
    
    var emptyDataConfigItems: [EmptyDataViewItem] {
        set {
            objc_setAssociatedObject(self, &emptyDataConfigItemsKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &emptyDataConfigItemsKey) as? [EmptyDataViewItem] ?? []
        }
    }
    
    func showEmptyView() {
        if let view = cache[emptyDataConfigItems] {
            view.isHidden = false
            view.superview?.bringSubviewToFront(view)
        } else {
            let items = emptyDataConfigItems
            // 如果配置项没有view就不处理
            guard !items.compactMap({ $0 }).isEmpty else { return }
            
            let emptyDataView = EmptyDataView()
            
            var lastView: UIView?
            var lastSpace: CGFloat = 0
            
            let containerView = emptyDataView.containerView
            addSubview(emptyDataView)
            
            var offset: CGFloat = 0
            
            for item in items {
                if let view = item.view {
                    containerView.addSubview(view)

                    if let lastView = lastView { //
                        containerView.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: lastView, attribute: .bottom, multiplier: 1, constant: lastSpace))
                    } else { // 第一个View
                        containerView.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: lastSpace))
                    }

                    if case .label = item, let width = item.width {
                        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width))
                    } else if let width = item.width, let height = item.height {
                        view.addConstraints([
                            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width),
                            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
                        ])
                    } else {
                        view.sizeToFit()
                    }

                    containerView.addConstraints([
                        NSLayoutConstraint(item: view, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .left, multiplier: 1, constant: 0),
                        NSLayoutConstraint(item: view, attribute: .right, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .right, multiplier: 1, constant: 0),
                        NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0)
                    ])

                    lastView = view
                    lastSpace = 0
                } else if case let .space(value) = item {
                    lastSpace = value
                } else if case let .offset(value) = item {
                    offset = value
                } else if case let .emptyConfig(backgroundColor: bgColor, isEnabled: isEnabled) = item {
                    if let bgColor = bgColor {
                        emptyDataView.backgroundColor = bgColor
                    }
                    if let isEnabled = isEnabled {
                        emptyDataView.isUserInteractionEnabled = isEnabled
                    }
                }
            }

            emptyDataView.addConstraints([
                NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: emptyDataView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: emptyDataView, attribute: .centerY, multiplier: 1, constant: offset)
            ])
            
            containerView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: lastView!, attribute: .bottom, multiplier: 1, constant: lastSpace))
            
            cache[items] = emptyDataView
            
            layoutIfNeeded()
        }
    }
    
    func hideEmptyView() {
        for v in cache.values {
            v.isHidden = true
        }
    }
    
    func setShowEmpty(_ isShow: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isShow {
                self?.showEmptyView()
            } else {
                self?.hideEmptyView()
            }
        }
    }
}
