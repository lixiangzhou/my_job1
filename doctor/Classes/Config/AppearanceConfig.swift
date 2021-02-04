//
//  AppearanceConfig.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/31.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

struct AppearanceConfig {
    static func config() {
        setNavAppearance()
        setTabAppearance()
        
    }
    
    static func setNavAppearance() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSize(20), NSAttributedString.Key.foregroundColor: UIColor.c3]
    }
    
    static func setPhotoNavAppearance() {
        UINavigationBar.appearance().tintColor = nil
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSize(18), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    }
    
    static func setTabAppearance() {
        UITabBar.appearance().tintColor = .blue
        UITabBar.appearance().backgroundColor = .white
    }
}
