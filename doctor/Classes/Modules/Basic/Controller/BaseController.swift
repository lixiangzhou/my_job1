//
//  BaseController.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/21.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift


class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cf7f6f8
//        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBackEnabled(true)

        if hideNavigation {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        setNavigationStyle(.default)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let backClassName = backClassName, var
            vcs = navigationController?.children,
           let idx = vcs.firstIndex(where: { $0.zz_className == backClassName }) {
            if idx + 1 <= vcs.count - 2 {
                vcs.removeSubrange((idx + 1)...(vcs.count - 2))
                navigationController?.setValue(vcs, forKey: "viewControllers")
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)

        if hideNavigation {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    deinit {
        print("DEINIT => \(self.classForCoder)")
    }
    
    var hideNavigation = false
    
    var backClassName: String?
    
    lazy var innerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return scrollView
    }()
    
    lazy var innerContentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        self.innerScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(self.view)
            make.height.equalTo(UIScreen.zz_frameUnderNavigation.height)
        }
        return contentView
    }()
}

// MARK: - UI
extension BaseController {
    @objc func setUI() {
        
    }
    
    @objc func setBinding() {
        
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .default
//    }
}

// MARK: - Action
extension BaseController {
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension BaseController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func resetScrollViewContentSizeUnderNavigation() {
        innerContentView.layoutHeight()
        innerContentView.snp.updateConstraints { (make) in
            make.height.equalTo(innerContentView.zz_height)
        }
        innerScrollView.contentSize.height = max(UIScreen.zz_frameUnderNavigation.height, innerContentView.frame.height)
    }
    
    func resetScrollViewContentSizeUnderNavigationOnlyWrapContent(_ additionHeight: CGFloat = 0) {
        innerContentView.layoutHeight()
        innerContentView.snp.updateConstraints { (make) in
            make.height.equalTo(innerContentView.zz_height + additionHeight)
        }

        innerScrollView.contentSize.height = innerContentView.frame.height + additionHeight
    }
    
    func resetScrollViewContentSizeUnderNavigationOnlyWrapContentWithBottomViewHeight(_ height: CGFloat) {
        innerContentView.layoutHeight()
        innerContentView.snp.updateConstraints { (make) in
            make.height.equalTo(innerContentView.zz_height)
        }

        innerScrollView.contentSize.height = innerContentView.frame.height + height + UIScreen.zz_tabBar_additionHeight
    }
}

// MARK: - Other
extension BaseController {
    enum NavigationStyle {
        case `default`
        case `systemDefault`
        case transparency
        case whiteBg
        case allWhite
        case other(Images)
        
        struct Images {
            var background: UIImage? = nil
            var shadow: UIImage? = nil
        }
    }
}

// MARK: - Public
extension BaseController {
    /// 设置导航栏样式
    func setNavigationStyle(_ style: NavigationStyle) {
        setNavigation(navigationController, style: style)
    }
    
    func setNavigation(_ navigationController: UINavigationController?, style: NavigationStyle) {
        var backgroundImage: UIImage? = nil
        var shadowImage: UIImage? = nil
        switch style {
        case .systemDefault:
            backgroundImage = nil
            shadowImage = nil
        case .default:
            backgroundImage = UIImage.zz_image(withColor: UIColor.white)
            shadowImage = UIImage.zz_image(withColor: UIColor.cf5f5f5)
        case .transparency:
            backgroundImage = UIImage.zz_image(withColor: .clear)
            shadowImage = UIImage()
        case .whiteBg:
            backgroundImage = UIImage.zz_image(withColor: .white)
            shadowImage = UIImage()
        case .allWhite:
            backgroundImage = UIImage.zz_image(withColor: UIColor.white)
            shadowImage = UIImage.zz_image(withColor: UIColor.white)
        case .other(let imgs):
            backgroundImage = imgs.background
            shadowImage = imgs.shadow
        }
        
        navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: .default)
        navigationController?.navigationBar.shadowImage = shadowImage
    }
    
    func setBackImage(_ imgName: String) {
        if navigationController?.viewControllers.count ?? 0 > 1 {
            // 空 title 是为了增加可点击范围
            let btn = UIButton(imageName: imgName, target: self, action: #selector(backAction))
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 15)
            btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        }
    }
    
    func setBackEnabled(_ enabled: Bool) {
        if enabled {
            setBackImage("common_nav_back")
        } else {
            if navigationController?.viewControllers.count ?? 0 > 1 {
                fd_interactivePopDisabled = true
                navigationItem.leftBarButtonItem = UIBarButtonItem()
            }
        }
    }
}

extension BaseController {
    
    @discardableResult
    func addNavigationItem(position: NavItemPosition, title: String, imgName: String, action: Selector) -> ImageTitleView {
        let config = ImageTitleView.Config(imageSize: CGSize(width: 25, height: 25), verticalHeight1: 0, verticalHeight2: 3, titleLeft: 0, titleRight: 0, titleFont: .size(14), titleColor: .white)
        
        let item = ImageTitleView()
        item.imgView.contentMode = .center
        item.config = config
        item.titleLabel.text = title
        item.imgView.image = UIImage(named: imgName)
        view.insertSubview(item, aboveSubview: innerContentView)
        
        item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        
        item.snp.makeConstraints { (make) in
            make.top.equalTo(35 + UIScreen.zz_statusBar_additionHeight)
            make.width.equalTo(50)
            make.height.equalTo(50)
            switch position {
            case .left: make.left.equalTo(10)
            case .right: make.right.equalTo(-10)
            }
        }
        return item
    }
    
    @discardableResult
    func setRightBarItem(title: String, action: Selector) -> UIButton {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, target: self, action: action)
        return navigationItem.rightBarButtonItem!.customView as! UIButton
    }
    
    @discardableResult
    func addLeftBackAction() -> UIButton {
        let button = UIButton(imageName: "common_nav_back", hilightedImageName: "common_nav_back", target: self, action: #selector(backAction))
        button.frame = CGRect(x: 12, y: UIScreen.zz_nav_statusHeight, width: 35, height: 44)
        view.addSubview(button)
        return button
    }

}

extension BaseController {
    enum NavItemPosition {
        case left, right
    }
}
