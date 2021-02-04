
//
//  LoginManager.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/8/26.
//  Copyright © 2019 qingsong. All rights reserved.
//

import Foundation
import ReactiveSwift

let tokenProperty = MutableProperty<String>("")

class LoginManager {
    static let shared = LoginManager()
    
    var tempToken: String?
    private(set) var token: String = "" {
        didSet {
            UserDefaults.standard.set(token, forKey: tokenKey)
        }
    }
    
    private let tokenKey = "tokenKey"
    
    var isLogin: Bool {
        return !token.isEmpty
    }
    
    private init() {
        tokenProperty.signal.observeValues {
            self.token = $0
            
        }
        tokenProperty.value = (UserDefaults.standard.value(forKey: tokenKey) as? String) ?? ""
    }
    
    func setup() {
        tokenProperty.skipRepeats().signal.observeValues { [weak self] (token) in
            if token.isEmpty {
                self?.toLogin()
            }
        }
        
        tokenProperty.signal.observeValues { [weak self] (token) in
            if token.isEmpty && self?.tempToken != nil {
                self?.toLogin()
            }
        }
        
//        if DoctorManager.shared.id > 0 {
//            JPushManager.shared.login()
//        }
    }
    
    func toLogin() {
        if let tabBarVC = RootControllerManager.shared.tabBarController {
            let vc = BaseNavigationController(rootViewController: LoginController())
            vc.modalPresentationStyle = .fullScreen
            tabBarVC.present(vc, animated: true) {
                if let navVC = tabBarVC.selectedViewController as? BaseNavigationController {
                    navVC.popToRootViewController(animated: true)
                }
                tabBarVC.selectedIndex = 0
            }
        } else {
            RootControllerManager.shared.loginNavController?.popToRootViewController(animated: true)
        }
    }
    
    func loginSuccess(from vc: UIViewController) {
        if let _ = UIApplication.shared.keyWindow?.rootViewController?.children.first as? LoginController { // 启动app时未登录的情况
            UIApplication.shared.keyWindow?.rootViewController = MainTabBarController()
        } else {    // 启动app时已登录的情况
            vc.dismiss(animated: true, completion: nil)
        }
        JPushManager.shared.login()
    }
    
    func logout() {
//        UserApi.logout.response(None.self) { (resp) in
//            if resp.success {
//                tokenProperty.value = ""
//                JPushManager.shared.logout()
//            }
//        }
    }
}

