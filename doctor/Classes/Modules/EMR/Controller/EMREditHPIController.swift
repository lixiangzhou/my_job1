//
//  EMREditHPIController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit
import ReactiveSwift

class EMREditHPIController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditHPIViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditHPIController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        
        tableView.register(cell: EMREditCommonTopCell.self)
        tableView.register(cell: EMREditCommonArrowCell.self)
        tableView.register(cell: EMREditHPISepCell.self)
        tableView.register(cell: EMREditHPITitleCell.self)
        tableView.register(cell: EMREditHPICheckBoxCell.self)
        tableView.register(cell: EMREditHPIBottomCell.self)
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
extension EMREditHPIController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case .top:
            let cell = tableView.dequeue(cell: EMREditCommonTopCell.self, for: indexPath)
            cell.titleLabel.text = "现病史（必填）"
            return cell
        case .sep:
            return tableView.dequeue(cell: EMREditHPISepCell.self, for: indexPath)
        case let .title(title, offset):
            let cell = tableView.dequeue(cell: EMREditHPITitleCell.self, for: indexPath)
            cell.titleLabel.text = title
            cell.setTopOffset(offset)
            return cell
        case let .arrow(title: title, text: txt, shortTop: shortTop, hasX: hasX):
            let cell = tableView.dequeue(cell: EMREditCommonArrowCell.self, for: indexPath)
            cell.titleLabel.text = title
            setLabelText(label: cell.rightLabel, txt: txt)
            cell.setTitleTopOffset(shortTop ? 8 : 16)
            cell.hasX = hasX
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditHPIBottomCell.self, for: indexPath)
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
        case let .checkbox(title: title, select: select):
            let cell = tableView.dequeue(cell: EMREditHPICheckBoxCell.self, for: indexPath)
            cell.titleLabel.text = title
            return cell
        }
    }
}

extension EMREditHPIController {
    func cleanAction() {
        
    }
    
    func submitAction() {
        
    }
    
    func nextAction() {
        
    }
}

extension EMREditHPIController {
    func setLabelText(label: UILabel, txt: Text) {
        if txt.string.isEmpty {
            label.font = .size(12)
            label.text = "请选择"
            label.textColor = .c9
        } else {
            label.font = .size(14)
            label.text = txt.string
            label.textColor = .c3
        }
    }
}
