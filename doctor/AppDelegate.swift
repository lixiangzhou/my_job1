//
//  AppDelegate.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
//        JPushManager.shared.setup(with: launchOptions)
        AppSetupConfig.config()
        RootControllerManager.shared.set(window)
        
        return true
    }
    
}

