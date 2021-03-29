//
//  PatientHospitalAppointmentApplyController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit
import ReactiveSwift

class PatientHospitalAppointmentApplyController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "住院预约申请"
        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = PatientHospitalAppointmentApplyViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension PatientHospitalAppointmentApplyController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: PatientCommonSpaceCell.self)
        tableView.register(cell: PatientHospitalAppointmentApplyActionCell.self)
        tableView.register(cell: PatientCommonTitleCell.self)
        tableView.register(cell: PatientCommonBottomCell.self)
        tableView.register(cell: PatientCommonLeftRightTextCell.self)
        tableView.register(cell: PatientHospitalAppointmentApplyOptionCell.self)
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
extension PatientHospitalAppointmentApplyController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case .space:
            let cell = tableView.dequeue(cell: PatientCommonSpaceCell.self, for: indexPath)
            cell.height = 12
            cell.spaceView.backgroundColor = .white
            return cell
        case let .text(left: left, right: right):
            let cell = tableView.dequeue(cell: PatientCommonLeftRightTextCell.self, for: indexPath)
            cell.leftLabel.text = left
            cell.rightLabel.text = right
            return cell
        case let .option(title: title, left: left, right: right):
            let cell = tableView.dequeue(cell: PatientHospitalAppointmentApplyOptionCell.self, for: indexPath)
            cell.titleLabel.text = title
            cell.detailLeftLabel.text = left
            cell.detailRightLabel.set(txt: right, placeholder: "请选择")
            cell.showOption = indexPath == viewModel.selectIndexPath
            return cell
        case .action:
            let cell = tableView.dequeue(cell: PatientHospitalAppointmentApplyActionCell.self, for: indexPath)
            
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: PatientCommonBottomCell.self, for: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        viewModel.selectIndexPath = indexPath
        switch model {
        case .option:
            tableView.reloadData()
        default:
            break
        }
    }
}


