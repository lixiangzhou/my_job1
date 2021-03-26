//
//  EMREditDiagnosisStartController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisStartController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditDiagnosisStartViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditDiagnosisStartController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        
        tableView.register(cell: EMREditCommonTitleCell.self)
        tableView.register(cell: EMREditDiagnosisStartBottomCell.self)
        tableView.register(cell: EMREditDiagnosisStartItemCell.self)
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
extension EMREditDiagnosisStartController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case .top:
            let cell = tableView.dequeue(cell: EMREditCommonTitleCell.self, for: indexPath)
            cell.titleLabel.text = "初步诊断（必填）"
            return cell
        case let .item(left: left, right: right):
            let cell = tableView.dequeue(cell: EMREditDiagnosisStartItemCell.self, for: indexPath)
            cell.leftLabel.set(txt: left, placeholder: "请选择部位")
            cell.rightLabel.set(txt: right, placeholder: "请选择分类")
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditDiagnosisStartBottomCell.self, for: indexPath)
            cell.bottomClosure = { [weak self] in
                self?.nextAction()
            }
            cell.addClosure = { [weak self] in
                self?.viewModel.add()
            }
            cell.delClosure = {[weak self] in
                self?.viewModel.delete()
            }
            return cell
        }
    }
}

extension EMREditDiagnosisStartController {
    
    func nextAction() {
        
    }
}
