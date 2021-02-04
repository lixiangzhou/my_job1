//
//  MineController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class MineController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationStyle(.transparency)
    }

    // MARK: - Public Property
    let viewModel = MineViewModel()
    // MARK: - Private Property
    let tableView = UITableView()
    let topView = MineTopView()
}

// MARK: - UI
extension MineController {
    override func setUI() {
        hideNavigation = true
        
        view.addSubview(topView)
        
        tableView.set(dataSource: self, delegate: self, rowHeight: 52)
        tableView.register(cell: MineCell.self)
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
//            make.bottom.equalTo(-UIScreen.zz_tabBarHeight)
        }
        
    }
}

// MARK: - Action
extension MineController {
    
}

// MARK: - Delegate Internal

// MARK: -
extension MineController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: MineCell.self, for: indexPath)
        let model = viewModel.dataSource[indexPath.row]
        cell.config = model.config
        cell.leftLabel.text = model.type.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.dataSource[indexPath.row]
        
        switch data.type {
        case .myCard:
            break
        case .feedback:
            break
        case .setting:
            break
        }
    }
}
