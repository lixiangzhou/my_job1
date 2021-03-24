//
//  EMREditController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit

class EMREditController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "填写完善病历"
        setUI()
        viewModel.prepareSubControllerFor(self)
    }

    // MARK: - Public Property
    let viewModel = EMREditViewModel()
    // MARK: - Private Property
    let tableView = UITableView()
    let containerView = UIView()
}

// MARK: - UI
extension EMREditController {
    override func setUI() {
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        
        tableView.backgroundColor = .cf8f8f8
        tableView.set(dataSource: self, delegate: self, rowHeight: 33)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 16))
        tableView.register(cell: EMREditCell.self)
        tableView.bounces = false
        view.addSubview(tableView)
        
        tableView.addShadow()
//        tableView.addShadow(color: UIColor.black.withAlphaComponent(0.3), cornerRadius: 4)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(84)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(tableView.snp.right)
        }
    }
}

// MARK: - Action
extension EMREditController {
    @objc func headerAction(_ sender: UIButton) {
        
    }
}

// MARK: - Network
extension EMREditController {
    
}

// MARK: - Delegate Internal

// MARK: -
extension EMREditController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = viewModel.dataSource[section]
        return group.isOpen ? group.models.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSource[indexPath.section].models[indexPath.row]
        let cell = tableView.dequeue(cell: EMREditCell.self, for: indexPath)
        cell.txtLabel.text = model.item.rawValue
        
        let isSelect = indexPath == viewModel.selectIndexPath
        cell.txtLabel.textColor = isSelect ? UIColor.c4167f3 : UIColor.c3
        cell.leftLine.isHidden = !isSelect
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectIndexPath = indexPath
        
        let model = viewModel.dataSource[indexPath.section].models[indexPath.row]
        containerView.subviews.forEach { $0.removeFromSuperview() }
        containerView.addSubview(model.controller.view)
        
        model.controller.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.reloadSections(IndexSet([indexPath.section]), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let group = viewModel.dataSource[section]
        let view = UIView()
        view.backgroundColor = group.isOpen ? UIColor.white : UIColor.cf7f6f8
        let btn = ZZImagePositionButton(title: group.info.rawValue, font: .size(14), titleColor: .c3, imageName: "todo_top_arrow_down", backgroundColor: .clear, target: self, action: #selector(headerAction), imgPosition: ZZImagePositionButton.ZZImagePosition.right, leftPadding: 0, middlePadding: 2, rightPadding: 0)
        btn.tag = section
        if group.isOpen {
            btn.imageView?.transform = .init(rotationAngle: CGFloat.pi)
        }
        view.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
}


// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension EMREditController {
    
}

// MARK: - Other
extension EMREditController {
    
}

// MARK: - Public
extension EMREditController {
    
}

