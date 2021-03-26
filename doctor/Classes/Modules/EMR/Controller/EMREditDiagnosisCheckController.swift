//
//  EMREditDiagnosisCheckController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisCheckController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditDiagnosisCheckViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditDiagnosisCheckController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        
        tableView.register(cell: EMREditCommonTitleCell.self)
        tableView.register(cell: EMREditDiagnosisCheckBottomCell.self)
        tableView.register(cell: EMREditDiagnosisCheckCell.self)
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
extension EMREditDiagnosisCheckController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case let .title(title):
            let cell = tableView.dequeue(cell: EMREditCommonTitleCell.self, for: indexPath)
            cell.titleLabel.text = title
            return cell
        case let .item(items):
            let cell = tableView.dequeue(cell: EMREditDiagnosisCheckCell.self, for: indexPath)
            cell.items = ["腰椎MRI", "CT"]
            cell.addClosure = {
                tableView.performBatchUpdates {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                } completion: { (_) in
                    
                }
            }
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditDiagnosisCheckBottomCell.self, for: indexPath)
            cell.bottomClosure = { [weak self] in
                self?.nextAction()
            }
            return cell
        }
    }
}

extension EMREditDiagnosisCheckController {
    
    func nextAction() {
        
    }
}
