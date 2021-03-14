//
//  FeedBackController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class FeedBackController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "意见反馈"
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    let tableView = UITableView()
    let viewModel = FeedBackViewModel()
}

// MARK: - UI
extension FeedBackController {
    override func setUI() {
        view.backgroundColor = .white
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: FeedBackDescCell.self)
        tableView.register(cell: FeedBackPicCell.self)
        tableView.register(cell: FeedBackContactCell.self)
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Action
extension FeedBackController {
    
}

// MARK: - Delegate Internal

// MARK: -
extension FeedBackController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeue(cell: FeedBackDescCell.self, for: indexPath)
            cell.txtView.txtDidChangeClosure = { [weak self] txt in
                self?.viewModel.descString = txt
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeue(cell: FeedBackPicCell.self, for: indexPath)
            cell.addClosure = { [weak self] in
                self?.viewModel.images = cell.images
                tableView.reloadData()
            }
            cell.deleteClosure = { [weak self] in
                self?.viewModel.images = cell.images
                tableView.reloadData()
            }
            return cell
        } else {
            let cell = tableView.dequeue(cell: FeedBackContactCell.self, for: indexPath)
            cell.submitClosure = { [weak self] contact in
                self?.viewModel.contact = contact
                self?.submit()
            }
            return cell
        }
    }
}

// MARK: - Public
extension FeedBackController {
    func submit() {
        viewModel.submint {
        }
    }
}

