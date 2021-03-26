//
//  EMREditDiagnosisComfirmController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisComfirmController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMREditDiagnosisConfirmViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMREditDiagnosisComfirmController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        
        tableView.register(cell: EMREditCommonTitleCell.self)
        tableView.register(cell: EMREditDiagnosisComfirmScaleCell.self)
        tableView.register(cell: EMREditDiagnosisComfirmItemCell.self)
        tableView.register(cell: EMREditDiagnosisComfirmBottomCell.self)
        tableView.register(cell: EMREditCommonGrowTxtViewCell.self)
        tableView.register(cell: EMREditDiagnosisPositionCell.self)
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
extension EMREditDiagnosisComfirmController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        switch model {
        case let .title(title: title, isBig: isBig, top: top, bottom: bottom):
            let cell = tableView.dequeue(cell: EMREditCommonTitleCell.self, for: indexPath)
            cell.titleLabel.text = title
            cell.titleLabel.font = isBig ? UIFont.boldSize(16) : UIFont.size(14)
            cell.setTopBottomOffset(top, bottom)
            return cell
        case let .scale(name: name, score: score, degree: degree, isFinished: isFinished):
            let cell = tableView.dequeue(cell: EMREditDiagnosisComfirmScaleCell.self, for: indexPath)
            cell.titleLabel.text = name
            cell.rightLabel.text = isFinished ? "已填写" : "待完善"
            cell.rightLabel.textColor = isFinished ? .c3 : .c26d765
            cell.scoreLabel.text = "评分 : \(score)分"
            cell.degreeLabel.text = "结果 : \(degree)"
            return cell
            
        case let .item(title: title, txt: txt, imgs: imgs):
            let cell = tableView.dequeue(cell: EMREditDiagnosisComfirmItemCell.self, for: indexPath)
            cell.titleLabel.text = title
            cell.imageDatas = imgs
            cell.needRefreshClosure = { [weak self] in
//                tableView.beginUpdates()
                let range = indexPath.row...indexPath.row
                self?.viewModel.dataSourceProperty.value.replaceSubrange(range, with: [.item(title: title, txt: txt, imgs: cell.imageDatas)])
//                tableView.endUpdates()
            }
            return cell
        case let .item2(left: left, right: right):
            let cell = tableView.dequeue(cell: EMREditDiagnosisPositionCell.self, for: indexPath)
            cell.leftLabel.set(txt: left, placeholder: "请选择部位")
            cell.rightLabel.set(txt: right, placeholder: "请选择分类")
            return cell
        case let .txt(txt):
            let cell = tableView.dequeue(cell: EMREditCommonGrowTxtViewCell.self, for: indexPath)
            return cell
        case .bottom:
            let cell = tableView.dequeue(cell: EMREditDiagnosisComfirmBottomCell.self, for: indexPath)
            cell.bottomClosure = { [weak self] in
                self?.confirmAction()
            }
            return cell
        }
    }
}

extension EMREditDiagnosisComfirmController {
    
    func confirmAction() {
        
    }
}
