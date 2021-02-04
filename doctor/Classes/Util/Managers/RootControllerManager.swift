//
//  RootControllerManager.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2020/2/20.
//  Copyright © 2020 sphr. All rights reserved.
//

import UIKit

class RootControllerManager {
    static let shared = RootControllerManager()
    
    private var window: UIWindow?
    
    var tabBarController: MainTabBarController? {
        return UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
    }
    
    var loginNavController: BaseNavigationController? {
        return UIApplication.shared.keyWindow?.rootViewController as? BaseNavigationController
    }
    
    /// 启动时调用
    func set(_ window: UIWindow?) {
        window?.backgroundColor = .white
        
//        if LoginManager.shared.isLogin {
            window?.rootViewController = MainTabBarController()
//        } else {
//            window?.rootViewController = BaseNavigationController(rootViewController: LoginController())
//        }
        
        window?.makeKeyAndVisible()
    }
}
