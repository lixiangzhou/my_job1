//
//  FontExtension.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/28.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

extension UIFont {
    /// 19 少数突出文字；18 主导航及多数按钮；17 少数重要文字；16 用在多数重要文字；15 用在多数重要文字；14 用在少数文字； 11 用在辅助行文字
    // ["PingFangSC-Medium", "PingFangSC-Semibold", "PingFangSC-Light", "PingFangSC-Ultralight", "PingFangSC-Regular", "PingFangSC-Thin"]
    
    enum PingFangSC: String {
        case medium = "PingFangSC-Medium"
        case semibold = "PingFangSC-Semibold"
        case light = "PingFangSC-Light"
        case ultralight = "PingFangSC-Ultralight"
        case regular = "PingFangSC-Regular"
        case thin = "PingFangSC-Thin"
        
        func size(_ size: CGFloat) -> UIFont {
            UIFont(name: rawValue, size: size)!
        }
    }
    
    static func size(_ size: CGFloat) -> UIFont {
//        return UIFont.systemFont(ofSize: size)
        PingFangSC.regular.size(size)
    }
    
    static func boldSize(_ size: CGFloat) -> UIFont {
//        return UIFont.boldSystemFont(ofSize: size)
        PingFangSC.medium.size(size)
    }
}

extension UIFont {
    //"AvenirNext-Medium", "AvenirNext-DemiBoldItalic", "AvenirNext-DemiBold", "AvenirNext-HeavyItalic", "AvenirNext-Regular", "AvenirNext-Italic", "AvenirNext-MediumItalic", "AvenirNext-UltraLightItalic", "AvenirNext-BoldItalic", "AvenirNext-Heavy", "AvenirNext-Bold", "AvenirNext-UltraLight"
    enum AvenirNext: String {
        case medium = "AvenirNext-Medium"
        case demibolditalic = "AvenirNext-DemiBoldItalic"
        case demibold = "AvenirNext-DemiBold"
        case heavyitalic = "AvenirNext-HeavyItalic"
        case regular = "AvenirNext-Regular"
        case italic = "AvenirNext-Italic"
        case mediumitalic = "AvenirNext-MediumItalic"
        case ultraLightitalic = "AvenirNext-UltraLightItalic"
        case bolditalic = "AvenirNext-BoldItalic"
        case heavy = "AvenirNext-Heavy"
        case bold = "AvenirNext-Bold"
        case ultralight = "AvenirNext-UltraLight"
        
        func size(_ size: CGFloat) -> UIFont {
            UIFont(name: rawValue, size: size)!
        }
    }
}
