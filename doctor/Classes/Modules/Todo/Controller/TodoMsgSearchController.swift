//
//  TodoMsgSearchController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class TodoMsgSearchController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "搜索"
        setUI()
        setBinding()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationStyle(.allWhite)
    }

    // MARK: - Public Property
    let viewModel = TodoMsgSearchViewModel()
    // MARK: - Private Property
    let topView = UIView()
    let searchView = UITextField()
    
    let tableView = UITableView()
}

// MARK: - UI
extension TodoMsgSearchController {
    override func setUI() {
        setTopView()
        setTableView()
    }
    
    func setTopView() {
        view.addSubview(topView)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
        let leftImgView = leftView.zz_add(subview: UIImageView(frame: CGRect(x: 8, y: 0, width: 32, height: 32))) as! UIImageView
        leftImgView.image = nil
        searchView.leftView = leftView
        searchView.leftViewMode = .always
        searchView.backgroundColor = .cfbfbfb
        searchView.clearButtonMode = .whileEditing
        searchView.font = .size(12)
        searchView.placeHolderString = "搜索患者姓名"
        searchView.zz_setCorner(radius: 16, masksToBounds: true)
        searchView.returnKeyType = .search
        
        topView.addSubview(searchView)
        
        let cancelBtn = topView.zz_add(subview: UIButton(title: "取消", font: .size(14), titleColor: .c3, target: self, action: #selector(cancelAction))) as! UIButton
        cancelBtn.adjustsImageWhenHighlighted = false
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(cancelBtn.snp.left).offset(-4)
            make.top.equalTo(8)
            make.bottom.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(searchView)
            make.right.equalToSuperview()
            make.width.equalTo(cancelBtn.zz_width + 32)
        }
    }
    
    func setTableView() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: TodoMsgSearchCell.self)
        
        tableView.headerRefreshClosure = { [weak self] in
            self?.viewModel.getData()
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
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
extension TodoMsgSearchController {
    @objc func cancelAction() {
        pop()
    }
}

// MARK: - Network
extension TodoMsgSearchController {
    
}

// MARK: - Delegate Internal

// MARK: -
extension TodoMsgSearchController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        let cell = tableView.dequeue(cell: TodoMsgSearchCell.self, for: indexPath)
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
extension TodoMsgSearchController {
    
}

// MARK: - Other
extension TodoMsgSearchController {
    
}

// MARK: - Public
extension TodoMsgSearchController {
    
}

