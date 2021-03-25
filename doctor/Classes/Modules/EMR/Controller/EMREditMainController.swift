//
//  EMREditMainController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit
import ReactiveSwift

class EMREditMainController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditMainViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditMainController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: EMREditCommonTopCell.self)
        tableView.register(cell: EMREditMainItemCell.self)
        tableView.register(cell: EMREditMainBottomCell.self)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setBinding() {
        tableView.reactive.reloadData <~ viewModel.dataSourceProperty.signal.map(value: ())
    }
}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension EMREditMainController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case .top:
            let cell = tableView.dequeue(cell: EMREditCommonTopCell.self, for: indexPath)
            cell.titleLabel.text = "主述"
            return cell
        case let .middle(item: item):
            let cell = tableView.dequeue(cell: EMREditMainItemCell.self, for: indexPath)
            cell.partView.showTip = true
            cell.partView.rightTipLabel.isHidden = true
            cell.partView.rightLabel.isHidden = false
            cell.hasSepLine = viewModel.dataSourceProperty.value.count - 2 != indexPath.row
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditMainBottomCell.self, for: indexPath)
            cell.addClosure = { [weak self] in
                self?.addAction()
            }
            cell.cleanClosure = { [weak self] in
                self?.cleanAction()
            }
            cell.submitClosure = { [weak self] in
                self?.submitAction()
            }
            cell.bottomClosure = { [weak self] in
                self?.nextAction()
            }
            return cell
        }
    }
}

extension EMREditMainController {
    func addAction() {
        viewModel.add()
    }
    
    func cleanAction() {
        viewModel.clean()
    }
    
    func submitAction() {
        
    }
    
    func nextAction() {
        
    }
}
