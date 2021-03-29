//
//  PatientDiagnosisFinishController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit
import ReactiveSwift

class PatientDiagnosisFinishController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "诊断完成"
        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = PatientDiagnosisFinishViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension PatientDiagnosisFinishController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: PatientDiagnosisFinishTopCell.self)
        tableView.register(cell: PatientCommonTitleCell.self)
        tableView.register(cell: PatientCommonSpaceCell.self)
        tableView.register(cell: PatientCommonBottomCell.self)
        tableView.register(cell: PatientCommonScaleNormalCell.self)
        tableView.register(cell: PatientCommonScaleStartCell.self)
        tableView.register(cell: PatientCommonLeftRightTextCell.self)
        
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
extension PatientDiagnosisFinishController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case let .top(model: model):
            let cell = tableView.dequeue(cell: PatientDiagnosisFinishTopCell.self, for: indexPath)
            cell.iconView.backgroundColor = .blue
            cell.nameLabel.text = "积分卡"
            cell.ageLabel.text = "32岁"
            cell.sexLabel.text = "女"
            cell.idLabel.text = "身份证号：12345678900985"
            return cell
        case let .title(title: title):
            let cell = tableView.dequeue(cell: PatientCommonTitleCell.self, for: indexPath)
            cell.titleLabel.text = title
            cell.titleLabel.font = .boldSize(16)
            return cell
        case let .space(height: height, color: color):
            let cell = tableView.dequeue(cell: PatientCommonSpaceCell.self, for: indexPath)
            cell.height = height
            cell.spaceView.backgroundColor = color
            return cell
        case let .text(left: left, right: right, rightColor: rightColor):
            let cell = tableView.dequeue(cell: PatientCommonLeftRightTextCell.self, for: indexPath)
            cell.leftLabel.text = left
            cell.rightLabel.text = right
            cell.rightLabel.textColor = rightColor
            return cell
        case let .item(model: model, position: position):
            switch position {
            case .start:
                let cell = tableView.dequeue(cell: PatientCommonScaleStartCell.self, for: indexPath)
                cell.leftTimeLabel.text = "10:10\n2021-10-10"
                cell.inputStateLabel.text = "已填写"
                cell.diagnosisStateLabel.text = "住院第1天"
                cell.inputPersonLabel.text = "王八"
                cell.submitTimeLabel.text = "2020-02-16 09:30"
                cell.inputStateLabel.text = "2分"
                cell.resultLabel.text = "重度XXX"
                return cell
            case .mid, .end:
                let cell = tableView.dequeue(cell: PatientCommonScaleNormalCell.self, for: indexPath)
                cell.leftTimeLabel.text = "10:10\n2021-10-10"
                cell.inputStateLabel.text = "已填写"
                cell.diagnosisStateLabel.text = "住院第1天"
                cell.inputPersonLabel.text = "王八"
                cell.submitTimeLabel.text = "2020-02-16 09:30"
                cell.inputStateLabel.text = "2分"
                cell.improveLabel.text = "50%"
                cell.standardLabel.text = "治疗改善率<75%"
                cell.resultLabel.text = "未达标"
                let isEnd = position == .end
                cell.leftBottomLine.isHidden = isEnd
                return cell
            }
        case .bottom:
            let cell = tableView.dequeue(cell: PatientCommonBottomCell.self, for: indexPath)
            cell.bottomClosure = { [weak self] in
                
            }
            return cell
        }
    }
}


