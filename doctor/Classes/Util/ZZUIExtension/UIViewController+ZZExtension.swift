//
//  UIViewController+ZZExtension.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/27.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

public extension UIViewController {
    func popToViewController(_ viewControllerName: String, animated: Bool = true) {
        guard let childVC = navigationController?.children else {
            return
        }
        
        var targetVC: UIViewController?
        let vcName = (Bundle.main.infoDictionary?["CFBundleExecutable"] as? String ?? "") + ".\(viewControllerName)"
        for vc in childVC {
            if vc.classForCoder.description() == vcName {
                targetVC = vc
                break
            }
        }
        
        if targetVC != nil {
            navigationController?.popToViewController(targetVC!, animated: animated)
        }
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: nil)
    }
}

extension UIViewController {
    static var topController: UIViewController? {
        if let root = UIApplication.shared.keyWindow?.rootViewController {
            return getTop(from: root)
        }
        return nil
    }
    
    static func getTop(from vc: UIViewController) -> UIViewController {
        if let vc = vc.presentedViewController {
            return getTop(from: vc)
        } else if let tabVC = vc as? UITabBarController, let vc = tabVC.selectedViewController {
            return getTop(from: vc)
        } else if let navVC = vc as? UINavigationController, let vc = navVC.topViewController {
            return getTop(from: vc)
        } else {
            return vc
        }
    }
}
