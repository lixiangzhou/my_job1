//
//  SettingController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class SettingController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "设置"
        
        setUI()
    }
    
    // MARK: - Public Property
    // MARK: - Private Property
    private let tableView = UITableView()
    private let viewModel = SettingViewModel()
}

// MARK: - UI
extension SettingController {
    override func setUI() {
        view.addSubview(tableView)
        
        tableView.register(cell: TextTableViewCell.self)
        tableView.set(dataSource: self, delegate: self, rowHeight: 52)
        tableView.backgroundColor = .white
        tableView.tableFooterView = getFooterView()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func getFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 220))
//        let btn = footerView.zz_add(subview: UIButton(title: "退出登录", font: .size(18), titleColor: .cf, backgroundColor: .c4158a5, target: self, action: #selector(logoutAction)))
//        btn.zz_setCorner(radius: 5, masksToBounds: true)
//        btn.snp.makeConstraints { (make) in
//            make.top.left.equalTo(15)
////            make.right.equalTo(-15)
//            make.width.equalTo(UIScreen.zz_width - 30)
//            make.bottom.equalToSuperview()
//        }
        return footerView
    }
}

// MARK: - Action
extension SettingController {
    @objc private func logoutAction() {
        LoginManager.shared.logout()
    }
}

// MARK: - Delegate Internal

// MARK: -
extension SettingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: TextTableViewCell.self, for: indexPath)
        let model = viewModel.dataSource[indexPath.row]
        cell.config = model.config
        cell.leftLabel.text = model.type.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.dataSource[indexPath.row]
        
        switch data.type {
        case .about:
            break
        case .privacyPolicy:
            break
        case .serviceTerms:
            break
        case .contactUs:
            break
        }
    }
}
