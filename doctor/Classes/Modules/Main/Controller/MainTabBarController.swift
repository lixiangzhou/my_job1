//
//  MainTabBarController.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/21.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit
import ReactiveSwift
import ESTabBarController_swift

let didSelectTabbarProperty = MutableProperty<Int>(0)

class MainTabBarController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildControllers()
    }
    
    private func addChildControllers() {
        let todo = wrap(TodoController(), title: "待办", img: "", selImg: "")
        let pm = wrap(PatientManagerController(), title: "患者管理", img: "", selImg: "")
        let mine = wrap(MineController(), title: "我的", img: "", selImg: "")
//        viewControllers = [todo.nav, pm.nav, mine.nav]
        viewControllers = [pm.nav, mine.nav, todo.nav]
//        viewControllers = [mine.nav, pm.nav, todo.nav]
    }

    @discardableResult
    private func wrap(_ controller: UIViewController, title: String, img: String, selImg: String) -> (nav: UIViewController, item: ESTabBarItem) {
        let contentView = ESTabBarItemContentView()
        contentView.textColor = .blue
        contentView.highlightTextColor = .red
        contentView.renderingMode = .alwaysOriginal
        let item = ESTabBarItem(contentView,
                                title: title,
                                image: UIImage(named: img),
                                selectedImage: UIImage(named: selImg))
        controller.tabBarItem = item
        
        controller.title = title
        let nav = BaseNavigationController(rootViewController: controller)
        return (nav, item)
    }
    
//    override var childForStatusBarStyle: UIViewController? {
//        selectedViewController
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        selectedViewController?.preferredStatusBarStyle ?? .default
//    }
}

extension MainTabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        didSelectTabbarProperty.value = selectedIndex
    }
}
