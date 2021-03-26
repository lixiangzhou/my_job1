//
//  EMREditDiagnosisPlanController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisPlanController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditDiagnosisPlanViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditDiagnosisPlanController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        
        tableView.register(cell: EMREditCommonTitleCell.self)
        tableView.register(cell: EMREditCommonArrowCell.self)
        tableView.register(cell: EMREditCommonTitleCell.self)
        tableView.register(cell: EMREditCommonTxtCell.self)
        tableView.register(cell: EMREditCommonSpaceCell.self)
        tableView.register(cell: EMREditCommonSepCell.self)
        tableView.register(cell: EMREditCommonAddCell.self)
        tableView.register(cell: EMREditDiagnosisPlanBottomCell.self)
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
extension EMREditDiagnosisPlanController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case let .title(title: title, isBig: isBig, top: top, bottom: bottom):
            let cell = tableView.dequeue(cell: EMREditCommonTitleCell.self, for: indexPath)
            cell.titleLabel.text = title
            cell.titleLabel.font = isBig ? UIFont.boldSize(16) : UIFont.boldSize(14)
            cell.setTopBottomOffset(top, bottom)
            return cell
        case let .arrow(left: left, right: right):
            let cell = tableView.dequeue(cell: EMREditCommonArrowCell.self, for: indexPath)
            cell.titleLabel.text = left
            cell.setRight(text: right, placeholder: "")
            return cell
        case let .text(left: left, right: right):
            let cell = tableView.dequeue(cell: EMREditCommonTxtCell.self, for: indexPath)
            cell.leftLabel.text = left
            cell.rightLabel.text = right.string
            return cell
        case let .space(height: height, color: color):
            let cell = tableView.dequeue(cell: EMREditCommonSpaceCell.self, for: indexPath)
            cell.height = height
            cell.contentView.backgroundColor = color
            return cell
        case .sep:
            return tableView.dequeue(cell: EMREditCommonSepCell.self, for: indexPath)
        case .add:
            let cell = tableView.dequeue(cell: EMREditCommonAddCell.self, for: indexPath)
            cell.addClosure = {
                
            }
            return cell
        case let .desc(desc):
            let cell = tableView.dequeue(cell: EMREditCommonBigRightCell.self, for: indexPath)
            cell.rightLabel.text = desc
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditDiagnosisPlanBottomCell.self, for: indexPath)
            cell.bottomClosure = { [weak self] in
                self?.confirmAction()
            }
            return cell
        }
    }
}

extension EMREditDiagnosisPlanController {
    
    func confirmAction() {
        
    }
}
