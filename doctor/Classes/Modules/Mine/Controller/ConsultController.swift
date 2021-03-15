//
//  ConsultController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class ConsultController: TopTabController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "知识资讯"
    }
    
    override func getTabControllers() -> [UIViewController] {
        hotVC.title = "最热"
        newVC.title = "最新"
        
        return [hotVC, newVC]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationStyle(.allWhite)
    }

    // MARK: - Public Property
    let hotVC = ConsultListController()
    let newVC = ConsultListController()
    // MARK: - Private Property
}

// MARK: - UI
extension ConsultController {
    override func setUI() {
        super.setUI()
    }
}
