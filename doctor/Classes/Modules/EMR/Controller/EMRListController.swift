//
//  EMRListController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit
import ReactiveSwift

class EMRListController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "电子病历"
        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMRListViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension EMRListController {
    override func setUI() {
        setRightBarItem(icon: "nav_right_add", action: #selector(addAction))
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: EMRListCell.self)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 16))
        headerView.backgroundColor = .cf7f6f8
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            
        }
    }
    
    override func setBinding() {
        tableView.reactive.reloadData <~ viewModel.dataSourceProperty.signal.map(value: ())
    }
}

extension EMRListController {
    @objc func addAction() {
        push(EMRAddReuseListController())
    }
}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension EMRListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        let cell = tableView.dequeue(cell: EMRListCell.self, for: indexPath)
        
        cell.timeLabel.text = "患者创建时间：2021-01-15 09:30"
        cell.tagLabel.text = "住院"
        cell.tagLabel.backgroundColor = .c42DC79
        cell.diagnosisLabel.text = "诊断：肩周炎"
        cell.noTitleLabel.text = "病历号："
        cell.noLabel.text = "34141435"
        cell.stateTitleLabel.text = "就诊状态："
        cell.stateLabel.text = "待治疗"
        cell.hospitalTitleLabel.text = "就诊医院："
        cell.hospitalLabel.text = "青海省人民医院疼痛科"
        
        return cell
    }
}
