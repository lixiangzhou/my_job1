//
//  StringExtension.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/8/14.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

func regex(_ regex: String, match: String) -> Bool {
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: match.zz_ns)
}

extension String {
    
    func needed(with font: UIFont, color: UIColor) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        attributeString.append(NSAttributedString(string: "*", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.red]))
        return attributeString
    }
    
    var isPwd: Bool {
        regex("[a-zA-Z0-9._]*", match: self)
    }
    
    var isChinese: Bool {
        regex("[\\u4e00-\\u9fa5]+", match: self)
    }
    
    var isEnglish: Bool {
        regex("[a-zA-Z]*", match: self)
    }
    
    /// 是否符合姓名输入要求
    var isMatchNameInputValidate: Bool {
        regex("[\\u4e00-\\u9fa5a-zA-Z·➋➌➍➎➏➐➑➒ ]*", match: self)
    }
    
    /// 是否符合手机号输入要求
    var isNumber: Bool {
        regex("[0-9]*", match: self)
    }
    
    /// 是否匹配身份证号输入要求
    var isMatchIdNoInputing: Bool {
        regex("[\\dxX]*", match: self)
    }
    
    /// 是否匹配身份证号
    var isMatchIdNo: Bool {
        regex("^(\\d{14}|\\d{17})(\\d|[xX])$", match: self)
    }
    
    var isMatchMobile: Bool {
        regex("^1\\d{10}", match: self)
    }
    
    var isMatchPwd: Bool {
        return self.count >= 6 && self.count <= 20 && !self.isChinese
    }
    
    var isMatchEmailInput: Bool {
        return isNumber || isEnglish || self == "_" || self == "." || self == "@"
    }
    
    var isMatchEmail: Bool {
//        regex("^[A-Z,a-z,\\d]+([-_.][A-Z,a-z,\\d]+)*@([A-Z,a-z,\\d]+[-_.])+[A-Z,a-z,\\d]*", match: self)
        regex("^[A-Z,a-z,\\d]+[-_.,A-Z,a-z,\\d]*@[-_.,A-Z,a-z,\\d]+", match: self)
    }
    
//    var md5String: String? {
//        if let data = self.data(using: .utf8) as NSData?,
//            let md5Data = data.hashData(with: CCDIGEST_MD5) as NSData?,
//            let md5 = md5Data.hexString() {
//            return md5
//        }
//        return nil
//    }
}

extension String {
    enum TimeFormat {
        /// 2020-01-01
        case ymd
        /// 2020-01-01 00:00
        case ymd_hm_1
        /// 2020年01月01日 00:00
        case ymd_hm_2
        /// 00:00
        case hm
        /// 昨天 00:00
        case yestoday_hm
    }
    
    var formatedDate: Date? {
        zz_date(withDateFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
    func formated(_ format: TimeFormat = .ymd_hm_1) -> String? {
        switch format {
        case .ymd:
            return formatedDate?.zz_string(withDateFormat: "yyyy-MM-dd")
        case .ymd_hm_1:
            return formatedDate?.zz_string(withDateFormat: "yyyy-MM-dd HH:mm")
        case .ymd_hm_2:
            return formatedDate?.zz_string(withDateFormat: "yyyy年MM月dd日 HH:mm")
        case .hm:
            return formatedDate?.zz_string(withDateFormat: "HH:mm")
        case .yestoday_hm:
            return formatedDate?.zz_string(withDateFormat: "昨天 HH:mm")
        }
        
    }
}

extension String {
    func attribute(_ attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func attribute(font: UIFont, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color])
    }
    
    func attribute(font: UIFont, color: UIColor, lineSpacing: CGFloat) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: style])
    }
    
    func defaultLineHeightAttribute(font: UIFont, color: UIColor) -> NSAttributedString {
        attribute(font: font, color: color, lineSpacing: 5)
    }
}

extension NSAttributedString {
    var mutable: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }
}

extension NSMutableAttributedString {
    func addLink(txt: String, font: UIFont, color: UIColor, bgColor: UIColor? = nil, lineHeight: CGFloat, action: (() -> Void)?) {
        let link = NSMutableAttributedString(string: txt)
        link.yy_lineSpacing = lineHeight
        link.yy_font = font
        
        link.yy_setTextHighlight(link.yy_rangeOfAll(), color: color, backgroundColor: bgColor) { (_, _, _, _) in
            action?()
        }
        append(link)
    }
}

