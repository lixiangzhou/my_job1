//
//  TodoController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class TodoController: TopTabController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func getTabControllers() -> [UIViewController] {
        todoListVC.title = "代办"
        msgListVC.title = "消息"
        
        todoListVC.searchView.searchClosure = { [weak self] txt in
            self?.searchAction()
        }
        
        msgListVC.searchView.durationClosure = { [weak self] from, to in
            self?.searchAction()
        }
        
        msgListVC.searchView.typeClosure = { [weak self] type in
            self?.searchAction()
        }
        
        return [todoListVC, msgListVC]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationStyle(.allWhite)
    }

    // MARK: - Public Property
    let todoListVC = TodoListController()
    let msgListVC = MsgListController()
    // MARK: - Private Property
}

// MARK: - UI
extension TodoController {
    override func setUI() {
        super.setUI()
    }
}

// MARK: - Action
extension TodoController {
    func searchAction() {
        let vc = TodoMsgSearchController()
        push(vc)
    }
}
