//
//  ConsultListController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class ConsultListController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationStyle(.allWhite)
    }

    // MARK: - Public Property
    let viewModel = ConsultListViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension ConsultListController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: ConsultListCell.self)
        
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

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension ConsultListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        let cell = tableView.dequeue(cell: ConsultListCell.self, for: indexPath)
        cell.iconView.backgroundColor = .orange
        cell.titleLabel.text = "来了！中国新冠病毒疫苗上市全民免费"
        cell.midLabel.text = "新闻 2021.01.16"
        cell.dzLabel.text = "点赞100"
        cell.readLabel.text = "阅读100"
        
        cell.dzLabel.snpUpdateWidth(addition: 2)
        cell.readLabel.snpUpdateWidth(addition: 2)
        
        cell.bottomLine.isHidden = indexPath.row == viewModel.dataSourceProperty.value.count - 1
        return cell
    }
}
