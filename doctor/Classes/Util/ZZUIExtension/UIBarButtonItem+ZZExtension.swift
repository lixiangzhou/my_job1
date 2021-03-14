//
//  UIBarButtonItem+ZZExtension.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/8/13.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

let itemFontSize: CGFloat = 14
extension UIBarButtonItem {
    convenience init(title: String? = nil,
                     font: UIFont = UIFont.systemFont(ofSize: itemFontSize),
                     titleColor: UIColor = UIColor.c4167f3,
                     imageName: String? = nil,
                     hilightedImageName: String? = nil,
                     selectedImageName: String? = nil,
                     backgroundImageName: String? = nil,
                     hilightedBackgroundImageName: String? = nil,
                     selectedBackgroundImageName: String? = nil,
                     backgroundColor: UIColor? = nil,
                     target: Any? = nil,
                     action: Selector? = nil) {
        self.init(customView: UIButton(title: title, font: font, titleColor: titleColor, imageName: imageName, hilightedImageName: hilightedImageName, selectedImageName: selectedImageName, backgroundImageName: backgroundImageName, hilightedBackgroundImageName: hilightedBackgroundImageName, selectedBackgroundImageName: selectedBackgroundImageName, backgroundColor: backgroundColor, target: target, action: action))
    }
}
