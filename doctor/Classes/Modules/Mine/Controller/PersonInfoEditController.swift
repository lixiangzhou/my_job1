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
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setBinding() {
        
    }
}

// MARK: - Action
extension PersonInfoEditController {
    
    @objc private func avatorAction() {
        view.endEditing(true)
        TZImagePickerController.singleCropPresent(from: self, delegate: self)
    }
    
    @objc private func nameAction() {
        view.endEditing(true)
        
    }
    
    @objc private func sexAction() {
        view.endEditing(true)
    }
    
    @objc private func hospitalAction() {
        view.endEditing(true)
        
    }
    
    @objc private func departmentAction() {
        view.endEditing(true)
        
    }
    
    @objc private func titleAction() {
        view.endEditing(true)
        
    }
    
    @objc private func specialtiesAction() {
        view.endEditing(true)
        
    }
    
    @objc private func careerPortfolioAction() {
        view.endEditing(true)
    }
    
    @objc private func emailAction() {
        view.endEditing(true)
        
    }

    @objc private func finishAction(_ sender: UIButton) {
        
    }
}

extension PersonInfoEditController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSource[indexPath.row]
        if model.row == .avator {
            let cell = tableView.dequeue(cell: PersonInfoEditAvatorCell.self, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeue(cell: PersonInfoEditCell.self, for: indexPath)
            cell.config = model.config
            cell.leftLabel.text = model.row.rawValue
            cell.rightLabel.text = model.showText
            cell.rightLabel.textColor = model.textColor
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.dataSource[indexPath.row]
        
    }
}


extension PersonInfoEditController: TZImagePickerControllerDelegate, PHAssetsProcessProtocol {
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        if let img = photos.first {
//            uploadImage(img)
        }
    }
}

// MARK: - Helper
extension PersonInfoEditController {
    
}
