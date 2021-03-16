//
//  PersonInfoEditController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//  
//

import UIKit

import ReactiveSwift

class PersonInfoEditController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "编辑资料"
        
        setUI()
        setBinding()
    }
    

    // MARK: - Public Property
    let viewModel = PersonInfoEditViewModel()
    
    // MARK: - Private Property

    let tableView = UITableView()
}

// MARK: - UI
extension PersonInfoEditController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self, rowHeight: 52)
        tableView.register(cell: PersonInfoEditCell.self)
        tableView.register(cell: PersonInfoEditAvatorCell.self)
        tableView.register(cell: PersonInfoFieldCell.self)
        tableView.register(cell: PersonInfoSexCell.self)
        tableView.backgroundColor = .white
        tableView.tableFooterView = getFooterView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func getFooterView() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 120))
        let btn = UIButton(title: "成为认证用户，获得慢痛患者管理服务", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(submitAction))
        btn.zz_setCorner(radius: 4, masksToBounds: true)
        footer.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(42)
            make.right.equalTo(-42)
            make.height.equalTo(42)
        }
        
        return footer
    }
    
    override func setBinding() {
        
    }
}

// MARK: - Action
extension PersonInfoEditController {
    @objc private func submitAction() {
        
    }
}

extension PersonInfoEditController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSource[indexPath.row]
        switch model.row {
        case .avator:
            let cell = tableView.dequeue(cell: PersonInfoEditAvatorCell.self, for: indexPath)
            cell.titleLabel.text = model.row.rawValue
            return cell
        case .sex:
            let cell = tableView.dequeue(cell: PersonInfoSexCell.self, for: indexPath)
            cell.titleLabel.text = model.row.rawValue
            return cell
        case .userName, .realName, .hospital, .dept, .title, .contractNumber, .email, .address, .major, .degree:
            let cell = tableView.dequeue(cell: PersonInfoFieldCell.self, for: indexPath)
            setFieldCell(cell, model: model)
            return cell
        case .workExperience, .trainingExperience, .identity:
            let cell = tableView.dequeue(cell: PersonInfoEditCell.self, for: indexPath)
            setArrowCell(cell, model: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.dataSource[indexPath.row]
        
        switch model.row {
        case .avator:
            UIImagePickerController.showPicker(sourceType: .photoLibrary, from: self, delegate: self)
        case .identity:
            break
        case .trainingExperience:
            push(PersonInfoTrainExpListController())
        case .workExperience:
            push(PersonInfoWorkExpListController())
        default:
            break
        }
    }
}

extension PersonInfoEditController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
extension PersonInfoEditController {
    func setFieldCell(_ cell: PersonInfoFieldCell, model: PersonInfoEditViewModel.RowModel) {
        cell.innerView.leftLabel.text = model.row.rawValue
        if !model.text.string.isEmpty {
            cell.innerView.rightField.text = model.text.string
            cell.innerView.rightField.font = .size(14)
        } else {
            cell.innerView.rightField.text = nil
            cell.innerView.rightField.font = .size(12)
            cell.innerView.rightField.placeHolderString = model.placeholder
        }
    }
    
    func setArrowCell(_ cell: PersonInfoEditCell, model: PersonInfoEditViewModel.RowModel) {
        cell.leftLabel.text = model.row.rawValue
        if !model.text.string.isEmpty {
            cell.rightLabel.text = nil
        } else {
            cell.rightLabel.text = model.placeholder
        }
    }
}
