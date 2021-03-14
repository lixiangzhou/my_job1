//
//  ViewExtension.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/29.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

extension UIView {
    convenience init(frame: CGRect = .zero, bgColor: UIColor) {
        self.init(frame: frame)
        backgroundColor = bgColor
    }
    
    static func sepLine(color: UIColor = .lightGray) -> UIView {
        let sep = UIView()
        sep.backgroundColor = color
        return sep
    }
    
    @discardableResult
    func addTopLine(color: UIColor = .lightGray, left: CGFloat = 0, right: CGFloat = 0, height: CGFloat = 0.5) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(left)
            make.right.equalTo(-right)
            make.height.equalTo(height)
            make.top.equalToSuperview()
        }
        return line
    }
    
    @discardableResult
    func addBottomLine(color: UIColor = .cf5f5f5, left: CGFloat = 0, right: CGFloat = 0, height: CGFloat = 0.5) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(left)
            make.right.equalTo(-right)
            make.height.equalTo(height)
            make.bottom.equalToSuperview()
        }
        return line
    }
    
    @discardableResult
    func addShadow(color: UIColor = UIColor(white: 0, alpha: 0.05), offset: CGSize = CGSize(width: 0, height: 2), opacity: Float = 1, cornerRadius: CGFloat = 5, shadowRadius: CGFloat = 5, topOffset: CGFloat = 0) -> UIView? {
        if let sup = superview {
            func configShadow(_ shadow: UIView) {
                shadow.layer.shadowColor = color.cgColor
                shadow.layer.shadowOffset = offset
                shadow.layer.shadowOpacity = opacity
                shadow.layer.shadowRadius = shadowRadius
                shadow.layer.cornerRadius = cornerRadius
                shadow.backgroundColor = sup.backgroundColor
                shadow.layer.masksToBounds = false
            }
            
            if let shadow = sup.viewWithTag(hashValue) { // 查看是否添加过
                configShadow(shadow)
                return shadow
            } else { // 添加
                let shadow = UIView()
                shadow.tag = hashValue
                configShadow(shadow)
                sup.insertSubview(shadow, belowSubview: self)
                shadow.snp.makeConstraints { (make) in
                    make.top.equalTo(self).offset(topOffset)
                    make.left.right.bottom.equalTo(self)
                }
                return shadow
            }
        }
        return nil
    }
    
    @discardableResult
    func addDefaultShadow() -> UIView? {
        return addShadow()
    }
    
    var shadowView: UIView? {
        return superview?.viewWithTag(hashValue)
    }
}

extension UILabel {
    /// 更新 sizeToFit 之后的宽度，之前的约束必须先设置了宽度约束
    func snpUpdateWidth(addition: CGFloat = 0) {
        let width = (text ?? "").zz_size(withLimitSize: CGSize(width: 1000, height: 1000), fontSize: ceil(font.pointSize)).width
        snp.updateConstraints { (make) in
            make.width.equalTo(width + addition)
        }
    }
}

extension InputFieldView {
    func addShadowView(_ imgName: String) {
        let bg = UIImageView(image: UIImage(named: imgName))
        bg.contentMode = .scaleToFill
        backgroundColor = .clear
        
        insertSubview(bg, at: 0)
        bg.snp.makeConstraints { (make) in
            make.top.equalTo(-3)
            make.left.equalTo(-5)
            make.right.equalTo(5)
            make.bottom.equalTo(6.5)
        }
    }
}

protocol LayoutHeightProtocol {
    func layoutHeight()
}

extension UIView: LayoutHeightProtocol {
    func layoutHeight() {
        layoutIfNeeded()
        var height: CGFloat = 0
        for view in subviews {
            if view.zz_maxY > height {
                height = view.zz_maxY
            }
        }
        zz_height = height
    }
}


extension UILabel {
    func append(_ sufix: String = "*", color: UIColor = UIColor.red) {
        let attr = NSMutableAttributedString(string: text ?? "")
        attr.append(NSAttributedString(string: sufix, attributes: [NSAttributedString.Key.foregroundColor: color]))
        attributedText = attr
    }
}

extension UITextField {
    var placeHolderString: String {
        set {
            attributedPlaceholder = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.c9])
        }
        get {
            return attributedPlaceholder?.string ?? ""
        }
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        var sup = superview
        while sup != nil {
            if sup! is UITableView {
                return sup as? UITableView
            }
            sup = sup!.superview
        }
        return nil
    }
}
