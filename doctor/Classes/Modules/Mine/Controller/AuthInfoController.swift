//
//  AuthInfoController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class AuthInfoController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "认证"
        setUI()
        setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Public Property
    let viewModel = AuthInfoViewModel()
    
    // MARK: - Private Property
    let tableView = UITableView()
}

// MARK: - UI
extension AuthInfoController {
    override func setUI() {
        
        tableView.set(dataSource: self, delegate: self)
        tableView.register(cell: AuthInfoPicCell.self)
        tableView.register(cell: AuthInfoIDCell.self)
        tableView.tableFooterView = getFooterView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func getFooterView() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 120))
        let btn = UIButton(title: "提交", font: .size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(submitAction))
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

extension AuthInfoController {
    @objc func submitAction() {
        
    }
}

// MARK: - Delegate Internal

// MARK: -
// MARK: - UITableViewDataSource, UITableViewDelegate
extension AuthInfoController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSource[indexPath.row]
        switch model.row {
        case .idcard:
            let cell = tableView.dequeue(cell: AuthInfoIDCell.self, for: indexPath)
            cell.imageData = model.images
            return cell
        default:
            let cell = tableView.dequeue(cell: AuthInfoPicCell.self, for: indexPath)
            cell.titleLabel.text = model.row.rawValue
            cell.model = model
            cell.needRefreshClosure = {
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            return cell
        }
    }
}
