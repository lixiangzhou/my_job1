//
//  EMREditPersonalController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit
import ReactiveSwift

class EMREditPersonalController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
    }

    // MARK: - Public Property
    let viewModel = EMREditPersonalViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditPersonalController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: EMREditCommonTopCell.self)
        tableView.register(cell: EMREditPersonalCell.self)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setBinding() {
    }
}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension EMREditPersonalController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeue(cell: EMREditCommonTopCell.self, for: indexPath)
            cell.hasX = false
            cell.titleLabel.text = "个人史（必填）"
            return cell
        } else {
            let cell = tableView.dequeue(cell: EMREditPersonalCell.self, for: indexPath)
            return cell
        }
    }
}

extension EMREditPersonalController {
    
    func nextAction() {
        
    }
    
}
