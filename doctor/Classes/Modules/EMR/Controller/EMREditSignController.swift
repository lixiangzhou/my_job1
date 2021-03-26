//
//  EMREditSignController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit
import ReactiveSwift

class EMREditSignController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditSignViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditSignController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        
        tableView.register(cell: EMREditCommonTopCell.self)
        tableView.register(cell: EMREditCommonArrowCell.self)
        tableView.register(cell: EMREditCommonFieldCell.self)
        tableView.register(cell: EMREditSignCell.self)
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
extension EMREditSignController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case .top:
            let cell = tableView.dequeue(cell: EMREditCommonTopCell.self, for: indexPath)
            cell.hasX = false
            cell.titleLabel.text = "生命体征"
            return cell
        case let .arrow(left: left, text: txt):
            let cell = tableView.dequeue(cell: EMREditCommonArrowCell.self, for: indexPath)
            cell.hasX = false
            cell.titleLabel.text = left
            cell.setRight(text: txt, placeholder: "请选择")
            return cell
        case let .field(left: left, text: txt):
            let cell = tableView.dequeue(cell: EMREditCommonFieldCell.self, for: indexPath)
            cell.hasX = false
            cell.titleLabel.attributedText = left
            cell.fieldView.text = txt.string
            cell.fieldView.attributedPlaceholder = "请输入".attribute(font: .size(12), color: .c9)
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditSignCell.self, for: indexPath)
            cell.bottomClosure = { [weak self] in
                self?.nextAction()
            }
            return cell
        }
    }
}

extension EMREditSignController {
    
    func nextAction() {
        
    }
}
