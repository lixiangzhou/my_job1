//
//  MsgListController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit
import ReactiveSwift

class MsgListController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationStyle(.allWhite)
    }

    // MARK: - Public Property
    let viewModel = MsgListViewModel()
    
    // MARK: - Private Property
    let searchView = TodoTopView()
    let tableView = UITableView()
}

// MARK: - UI
extension MsgListController {
    override func setUI() {
        searchView.addTypeView(false)
        view.addSubview(searchView)
        
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: MsgListCell.self)
        
        tableView.headerRefreshClosure = { [weak self] in
            self?.viewModel.getData()
        }
        
        view.addSubview(tableView)
        
        searchView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-UIScreen.zz_tabBarHeight)
        }
    }
    
    override func setBinding() {
        viewModel.dataSourceProperty.signal.observeValues { [weak self] (models) in
            self?.tableView.reloadData()
            
            self?.tableView.endRefreshHeader()
        }
    }
}

// MARK: - Action
extension MsgListController {
    
}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension MsgListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        let cell = tableView.dequeue(cell: MsgListCell.self, for: indexPath)
//        cell.iconView.image =
        cell.nameLabel.text = "李先生"
        cell.timeLabel.text = "今天"
        cell.contentLabel.text = "处理内容：" + "待完成化验检测"
        cell.finishTimeLabel.text = "完成时间：" + "2021-01-15 18:00 前"
        cell.bottomLine.isHidden = indexPath.row == viewModel.dataSourceProperty.value.count - 1
        return cell
    }
}


// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension MsgListController {
    
}

// MARK: - Other
extension MsgListController {
    
}

// MARK: - Public
extension MsgListController {
    
}

