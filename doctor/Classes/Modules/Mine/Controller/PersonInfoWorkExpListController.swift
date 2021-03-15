//
//  PersonInfoWorkExpListController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class PersonInfoWorkExpListController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "工作经历"
        setUI()
        setBinding()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Public Property
    let viewModel = PersonInfoWorkExpListViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension PersonInfoWorkExpListController {
    override func setUI() {
        setRightBarItem(title: "添加", action: #selector(addAction))
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: PersonInfoWorkExpListCell.self)
        
        tableView.headerRefreshClosure = { [weak self] in
            self?.viewModel.getData()
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setBinding() {
        viewModel.dataSourceProperty.signal.observeValues { [weak self] (models) in
            self?.tableView.reloadData()
            self?.tableView.endRefreshHeader()
        }
    }
}

extension PersonInfoWorkExpListController {
    @objc func addAction() {
        push(PersonInfoWorkExpAddController())
    }
}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension PersonInfoWorkExpListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        let cell = tableView.dequeue(cell: PersonInfoWorkExpListCell.self, for: indexPath)
        
        cell.hospitalLabel.text = "青海人民医院"
        cell.deptLabel.text = "疼痛科"
        cell.durationLabel.text = "2010-09-01——2010-09-01"
        cell.titleLabel.text = "主治医生"
        cell.descLabel.text = "1.注意负责疼痛科注意负责疼痛科注意负责疼痛科注意负责疼痛科\n2.注意负责疼痛科注意负责疼痛科注意负责疼痛科注意负责疼痛科"
        
        cell.bottomLine.isHidden = indexPath.row == viewModel.dataSourceProperty.value.count - 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
