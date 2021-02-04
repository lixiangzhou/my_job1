//
//  HUDConfig.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/31.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

struct HUD {
    static func show(toast: String, duration: TimeInterval = 2, in view: UIView? = UIApplication.shared.keyWindow!, fromTop: Bool? = nil, canToastOverlay: Bool = false) {
        guard let view = getShowView(view, fromTop: fromTop) else { return }
        view.canToastOverlay = canToastOverlay
        executeInMain {
            ZZHud.show(message: toast,
                       font: UIFont.systemFont(ofSize: 14),
                       color: UIColor.white,
                       backgroundColor: UIColor(white: 0.2, alpha: 0.9),
                       cornerRadius: 5,
                       showDuration: duration,
                       contentInset: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15),
                       offsetY: -50,
                       toView: view)
        }
    }
    
    static func showLoding(toView: UIView? = UIApplication.shared.keyWindow!, fromTop: Bool? = nil) {
        guard let toView = getShowView(toView, fromTop: fromTop) else { return }
        executeInMain {
            let bgView = UIView(frame: toView.bounds)
            bgView.backgroundColor = .clear
            
            let loadingBgView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            
            let activityView = UIActivityIndicatorView(style: .whiteLarge)
            activityView.startAnimating()
            
            loadingBgView.addSubview(activityView)
            
            activityView.center = loadingBgView.center
            loadingBgView.center = bgView.center
            loadingBgView.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
            
            bgView.addSubview(loadingBgView)
            
            ZZHud.show(loading: bgView,
                       toView: toView,
                       hudCornerRadius: 5,
                       hudBackgroundColor: .clear,
                       hudAlpha: 1,
                       contentInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                       position: .center,
                       offsetY: 0,
                       animation: nil)
        }
    }
    
    static func hideLoding(forView: UIView? = UIApplication.shared.keyWindow!, fromTop: Bool? = nil) {
        guard let forView = getShowView(forView, fromTop: fromTop) else { return }
        executeInMain {
            ZZHud.hideLoading(for: forView)
        }
    }
    
    static func showError(_ result: BoolString, in view: UIView? = UIApplication.shared.keyWindow!, fromTop: Bool? = nil) {
        guard let view = view else { return }
        if !result.isSuccess && !result.toast.isEmpty {
            show(toast: result.toast, in: view, fromTop: fromTop)
        }
    }
    
    static func showSuccess(_ result: BoolString, in view: UIView? = UIApplication.shared.keyWindow!, fromTop: Bool? = nil) {
        guard let view = view else { return }
        if result.isSuccess && !result.toast.isEmpty {
            show(toast: result.toast, in: view, fromTop: fromTop)
        }
    }
    
    static func show(_ result: BoolString, in view: UIView? = UIApplication.shared.keyWindow!, fromTop: Bool? = nil) {
        if result.isSuccess {
            showSuccess(result, in: view, fromTop: fromTop)
        } else {
            showError(result, in: view, fromTop: fromTop)
        }
    }
    
    private static func getShowView(_ view: UIView?, fromTop: Bool?) -> UIView? {
        var toView = view
        if fromTop == true {
            toView = UIViewController.topController?.view
        }
        return toView
    }
}
