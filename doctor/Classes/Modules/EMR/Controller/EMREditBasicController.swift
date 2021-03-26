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

    let tableView = UITableView(frame: .zero, style: .grouped)
}

// MARK: - UI
extension EMREditBasicController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self, rowHeight: 52)
        tableView.register(cell: EMREditCommonFieldCell.self)
        tableView.register(cell: EMREditCommonArrowCell.self)
        tableView.register(cell: EMREditBasicSexCell.self)
        tableView.backgroundColor = .white
        tableView.tableFooterView = getFooterView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func getFooterView() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 120))
        let btn = UIButton(title: "下一页", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(nextAction))
        btn.zz_setCorner(radius: 4, masksToBounds: true)
        btn.frame = CGRect(x: 53, y: 40, width: UIScreen.zz_width - 53 * 2 - 84 - 4, height: 42)
        
        footer.addSubview(btn)
        
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
            let cell = tableView.dequeue(cell: EMREditCommonArrowCell.self, for: indexPath)
            cell.titleLabel.text = model.row.rawValue
            cell.setRight(text: model.text, placeholder: model.placeholder, placeholderColor: .c26d765)
            cell.hasX = indexPath.section == 0
            cell.bottomLine.isHidden = model.row == .address
            
            return cell
        default:
            let cell = tableView.dequeue(cell: EMREditCommonFieldCell.self, for: indexPath)
            cell.hasX = indexPath.section == 0
            cell.titleLabel.text = model.row.rawValue
            cell.fieldView.text = model.text.string
            cell.fieldView.attributedPlaceholder = model.placeholder.attribute(font: .size(12), color: .c9)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 34))
            view.zz_add(subview: UILabel(text: "患者基本信息", font: .boldSize(16), textColor: .c3), frame: CGRect(x: 12, y: 12, width: 100, height: 22))
            return view
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 32))
            let bgView = view.zz_add(subview: UIView(), frame: CGRect(x: 12, y: 0, width: UIScreen.zz_width, height: 32), bgColor: .cfbfbfb)
            bgView.zz_add(subview: UIImageView(image: UIImage(named: "emr_attention")), frame: CGRect(x: 8, y: 11, width: 12, height: 12))
            bgView.zz_add(subview: UILabel(text: "为便于研究，以下信息建议完整填写", font: .size(12), textColor: .cFF5050), frame: CGRect(x: 26, y: 7, width: 200, height: 17))
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 34
        } else {
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.01
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

