//
//  EMREditDiagnosisPlanNextController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisPlanNextController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditDiagnosisPlanNextViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditDiagnosisPlanNextController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        
        tableView.register(cell: EMREditCommonTitleCell.self)
        tableView.register(cell: EMREditDiagnosisPlanNextCell.self)
        tableView.register(cell: EMREditDiagnosisPlanNextBottomCell.self)
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
extension EMREditDiagnosisPlanNextController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case .title:
            let cell = tableView.dequeue(cell: EMREditCommonTitleCell.self, for: indexPath)
            cell.titleLabel.text = model.rawValue
            cell.titleLabel.font = .boldSize(16)
            cell.setTopBottomOffset(12, 0)
            return cell
        case .hospital, .toOtherHospital, .finish:
            let cell = tableView.dequeue(cell: EMREditDiagnosisPlanNextCell.self, for: indexPath)
            cell.titleLabel.text = model.rawValue
            cell.showSelect = viewModel.selectIndexPath == indexPath
            return cell
        case .diagnosis:
            let cell = tableView.dequeue(cell: EMREditDiagnosisPlanNextCell.self, for: indexPath)
            cell.titleLabel.text = model.rawValue
            cell.showDiagnosisView = viewModel.selectIndexPath == indexPath
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditDiagnosisPlanNextBottomCell.self, for: indexPath)
            cell.bottomClosure = { [weak self] in
                self?.confirmAction()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectIndexPath = indexPath
        
        tableView.reloadData()
    }
}

extension EMREditDiagnosisPlanNextController {
    
    func confirmAction() {
        
    }
}
