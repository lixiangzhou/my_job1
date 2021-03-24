//
//  EMRAddReuseListController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit
import ReactiveSwift

class EMRAddReuseListController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "新建病历"
        setUI()
        setBinding()
        viewModel.getData()
    }

    // MARK: - Public Property
    let viewModel = EMRListViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
    
    let confirmBtn = UIButton(title: "确定", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(confirmAction))
}

// MARK: - UI
extension EMRAddReuseListController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: EMRAddReuseListCell.self)
        let headerView = getHeaderView()
        
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        
        confirmBtn.zz_setCorner(radius: 4, masksToBounds: true)
        view.addSubview(confirmBtn)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.left.equalTo(42)
            make.right.equalTo(-42)
            make.height.equalTo(42)
            make.bottom.equalToSuperview()
        }
    }
    
    func getHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 16 * 2 + 25))
        header.backgroundColor = .cf7f6f8
        
        header.zz_add(subview: UILabel(text: "可选择复用已有病历信息", font: .boldSize(18), textColor: .c3), frame: CGRect(x: 16, y: 16, width: 200, height: 25))
        
        let skipBtn = header.zz_add(subview: UIButton(title: "跳过", font: .size(14), titleColor: .c4167f3, target: self, action: #selector(skipAction)))
        
        skipBtn.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        return header
    }
    
    override func setBinding() {
        tableView.reactive.reloadData <~ viewModel.dataSourceProperty.signal.map(value: ())
    }
}

extension EMRAddReuseListController {
    @objc func skipAction() {
        push(EMREditController())
    }

    @objc func confirmAction() {
        
    }

}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension EMRAddReuseListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceProperty.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSourceProperty.value[indexPath.row]
        let cell = tableView.dequeue(cell: EMRAddReuseListCell.self, for: indexPath)
        
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
        
        cell.pannelBorderView.isHidden = indexPath.row & 1 == 0
        
        return cell
    }
}
