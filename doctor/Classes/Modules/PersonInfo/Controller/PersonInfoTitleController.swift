//
//  PersonInfoTitleController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/22.
//  
//

import UIKit

class PersonInfoTitleController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "选择职称"
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    let dataSource = ["院长", "副院长", "主任", "副主任", "主治医生", "其他"]
    let tableView = UITableView()
    var selectClosure: ((String) -> Void)?
}

// MARK: - UI
extension PersonInfoTitleController {
    override func setUI() {
        tableView.set(dataSource: self, delegate: self, rowHeight: 44)
        tableView.register(cell: PersonInfoTitleFieldCell.self)
        tableView.register(cell: PersonInfoTitleTxtCell.self)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension PersonInfoTitleController {
    @objc func addAction() {
        push(PersonInfoTrainExpAddController())
    }
}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension PersonInfoTitleController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let txt = dataSource[indexPath.row]
        if indexPath.row == dataSource.count - 1 {
            let cell = tableView.dequeue(cell: PersonInfoTitleFieldCell.self, for: indexPath)
            cell.txtField.delegate = self
            return cell
        } else {
            let cell = tableView.dequeue(cell: PersonInfoTitleTxtCell.self, for: indexPath)
            cell.txtLabel.text = txt
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != dataSource.count - 1 {
            selectClosure?(dataSource[indexPath.row])
            pop()
        }
    }
}

extension PersonInfoTitleController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txt = textField.text, !txt.isEmpty {
            selectClosure?(txt)
            pop()
            return true
        } else {
            return false
        }
    }
}
