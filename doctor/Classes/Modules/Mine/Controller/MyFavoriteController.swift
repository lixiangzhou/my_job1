//
//  MyFavoriteController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit
import ReactiveSwift

class MyFavoriteController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我的收藏"
        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    let tableView = UITableView()
    let viewModel = MyFavoriteViewModel()
    private let bottomBtn = UIButton(title: "确定（0）", font: .boldSize(18), titleColor: .white, backgroundColor: .cf94336, target: self, action: #selector(finishAction))
    var rightBtn: UIButton!
}

// MARK: - UI
extension MyFavoriteController {
    override func setUI() {
        rightBtn = setRightBarItem(title: "编辑", action: #selector(editAction))
        view.backgroundColor = .white
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: MyFavoriteCell.self)
        view.addSubview(tableView)
        
        bottomBtn.zz_setCorner(radius: 4, masksToBounds: true)
        bottomBtn.isHidden = true
        view.addSubview(bottomBtn)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setBinding() {
        tableView.reactive.reloadData <~ viewModel.dataSourceProperty.signal.map(value: ())
    }
}

// MARK: - Action
extension MyFavoriteController {
    @objc private func finishAction() {
        
        
        
    }
    
    @objc private func editAction() {
        switch viewModel.modeProperty.value {
        case .normal:
            viewModel.modeProperty.value = .edit
            rightBtn.setTitle("完成", for: .normal)
            
            bottomBtn.isHidden = false
            
            tableView.snp.remakeConstraints { (make) in
                make.top.left.right.equalToSuperview()
            }
            
            bottomBtn.snp.remakeConstraints { (make) in
                make.top.equalTo(tableView.snp.bottom)
                make.left.equalTo(42)
                make.right.equalTo(-42)
                make.height.equalTo(42)
                make.bottomOffsetFrom(self)
            }
        case .edit:
            viewModel.modeProperty.value = .normal
            rightBtn.setTitle("编辑", for: .normal)
            
            bottomBtn.isHidden = true
            
            tableView.snp.remakeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        tableView.reloadData()
    }
}

// MARK: - Delegate Internal

// MARK: -
extension MyFavoriteController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: MyFavoriteCell.self, for: indexPath)
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        
        cell.iconView.backgroundColor = .orange
        
        cell.titleLabel.text = "来了！中国新冠病毒疫苗上市全民免费市全民免费市全民免费"
        cell.midLabel.text = "新闻 2021.01.16"
        cell.bottomLabel.text = "收藏于 2021.01.16 10:00"
        cell.bottomLine.isHidden = indexPath.row == viewModel.dataSourceProperty.value.count - 1
        cell.mode = viewModel.modeProperty.value
        
        cell.selectClosure = { [weak self] in
            
        }
        
        return cell
    }
}
