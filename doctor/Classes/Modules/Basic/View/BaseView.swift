//
//  BaseView.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/6/10.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT => \(self.classForCoder)")
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension BaseView {
    private func setUI() {
        
    }
}

class BaseShowView: BaseView {
    let tapHideView = UIView()
    let contentView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tapHideView)
        addSubview(contentView)
        
        tapHideView.backgroundColor = .clear
        tapHideView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        contentView.backgroundColor = .clear
        
        tapHideView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(tapHideView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseShowView {
    @objc func show() {
        frame = UIScreen.main.bounds
        UIApplication.shared.keyWindow?.addSubview(self)
        
        alpha = 0
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }) { (_) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    @objc func showHorizontal() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        snp.remakeConstraints({ (maker) in
            maker.width.equalTo(UIScreen.main.bounds.height)
            maker.height.equalTo(UIScreen.main.bounds.width)
            maker.center.equalTo(UIApplication.shared.keyWindow!)
        })
        alpha = 0
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(rotationAngle: .pi * 0.5)
            self.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    
    @objc func hide() {
        alpha = 1
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform.identity
        }) { (_) in
            self.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
    @objc func orientationChanged() {
        let orientation = UIDevice.current.orientation
        guard orientation == .landscapeLeft || orientation == .landscapeRight else { return }
        
        self.transform = .identity
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(rotationAngle: .pi * 0.5 * (orientation == .landscapeLeft ? 1 : -1))
            self.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
