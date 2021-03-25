//
//  EMREditPHController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit
import ReactiveSwift

class EMREditPHController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
    }

    // MARK: - Public Property
    let viewModel = EMREditPHViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditPHController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: EMREditCommonTopCell.self)
        tableView.register(cell: EMREditPHCell.self)
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
extension EMREditPHController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeue(cell: EMREditCommonTopCell.self, for: indexPath)
            cell.hasX = false
            cell.titleLabel.text = "既往史（必填）"
            return cell
        } else {
            let cell = tableView.dequeue(cell: EMREditPHCell.self, for: indexPath)
            cell.setBtns(["无", "糖尿病", "消化系统疾病", "消化系统疾病", "菌痢及菌痢接触史", "高血压", "其他"])
            return cell
        }
    }
}

extension EMREditPHController {
    
    func nextAction() {
        
    }
    
}
