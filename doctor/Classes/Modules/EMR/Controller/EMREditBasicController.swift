//
//  EMREditBasicController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit
import ReactiveSwift

class EMREditBasicController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setBinding()
    }
    

    // MARK: - Public Property
    let viewModel = EMREditBasicViewModel()
    
    // MARK: - Private Property

    let tableView = UITableView()
}

// MARK: - UI
extension EMREditBasicController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self, rowHeight: 52)
        tableView.register(cell: EMREditBasicFieldCell.self)
        tableView.register(cell: EMREditBasicArrowCell.self)
        tableView.register(cell: EMREditBasicSexCell.self)
        tableView.backgroundColor = .white
        tableView.tableFooterView = getFooterView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func getFooterView() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 120))
        let btn = UIButton(title: "下一页", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(nextAction))
        btn.zz_setCorner(radius: 4, masksToBounds: true)
        footer.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(55)
            make.right.equalTo(-55)
            make.height.equalTo(42)
        }
        
        return footer
    }
    
    override func setBinding() {
        
    }
}

// MARK: - Action
extension EMREditBasicController {
    @objc private func nextAction() {
        
    }
}

extension EMREditBasicController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSource[indexPath.section].list[indexPath.row]
        switch model.row {
        
        case .sex:
            let cell = tableView.dequeue(cell: EMREditBasicSexCell.self, for: indexPath)
            return cell
        case .nation, .address, .major, .marriage, .education, .income:
            let cell = tableView.dequeue(cell: EMREditBasicArrowCell.self, for: indexPath)
            setArrowCell(cell, model: model)
            cell.hasX = indexPath.section == 0
            return cell
        default:
            let cell = tableView.dequeue(cell: EMREditBasicFieldCell.self, for: indexPath)
            setFieldCell(cell, model: model)
            cell.hasX = indexPath.section == 0
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = viewModel.dataSource[indexPath.row]
        
    }
}

extension EMREditBasicController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        print(info)
        if let img = info[UIImagePickerController.InfoKey.editedImage] {
            print(img)
        }
        picker.dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        picker.dismiss()
    }
}


// MARK: - Helper
extension EMREditBasicController {
    func setFieldCell(_ cell: EMREditBasicFieldCell, model: EMREditBasicViewModel.RowModel) {
        cell.titleLabel.text = model.row.rawValue
        cell.fieldView.text = model.text.string
        cell.fieldView.font = .size(14)
        cell.fieldView.attributedPlaceholder = NSAttributedString(string: model.placeholder, attributes: [NSAttributedString.Key.font: UIFont.size(12), NSAttributedString.Key.foregroundColor: UIColor.c9])
    }
    
    func setArrowCell(_ cell: EMREditBasicArrowCell, model: EMREditBasicViewModel.RowModel) {
        cell.titleLabel.text = model.row.rawValue
        if !model.text.string.isEmpty {
            cell.rightLabel.text = model.text.string
            cell.rightLabel.textColor = .c3
        } else {
            cell.rightLabel.text = model.placeholder
            cell.rightLabel.textColor = .c26d765
        }
    }
}

