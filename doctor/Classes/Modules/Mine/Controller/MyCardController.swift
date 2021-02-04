//
//  MyCardController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//  
//

import UIKit

class MyCardController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我的名片"
        setUI()
     
        hospitalLabel.text = "青海省人民医院"
        hospitalIconView.backgroundColor = .red
        nameLabel.text = "王一"
        titleLabel.text = "主治医生"
        
        mobileLabel.text = "138 8888 8888"
        emailLabel.text = "13888888888@qq.com"
        locLabel.text = "青海省西宁市XX路"
        
        
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    let hospitalLabel = UILabel(text: " ", font: .size(16), textColor: .c3)
    let hospitalIconView = UIImageView()
    let nameLabel = UILabel(text: " ", font: .boldSize(20), textColor: .c3)
    let titleLabel = UILabel(text: " ", font: .size(12), textColor: .c3)
    
    let mobileLabel = UILabel(text: " ", font: UIFont.PingFangSC.light.size(12), textColor: .c6)
    let emailLabel = UILabel(text: " ", font: UIFont.PingFangSC.light.size(12), textColor: .c6)
    let locLabel = UILabel(text: " ", font: UIFont.PingFangSC.light.size(12), textColor: .c6)
}

// MARK: - UI
extension MyCardController {
    override func setUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "", target: self, action: #selector(shareAction))
        
        let cardView = view.zz_add(subview: UIView(), bgColor: .white)
        cardView.zz_setCorner(radius: 4, masksToBounds: true)
        cardView.zz_setBorder(color: .cf5f5f5, width: 1)
        cardView.addShadow(color: UIColor(white: 0, alpha: 0.05))
        
        cardView.addSubview(hospitalIconView)
        cardView.addSubview(hospitalLabel)
        cardView.addSubview(nameLabel)
        cardView.addSubview(titleLabel)
        
        let mobileView = add(subview: mobileLabel, icon: "", to: cardView)
        let emailView = add(subview: emailLabel, icon: "", to: cardView)
        let locView = add(subview: locLabel, icon: "", to: cardView)
        
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        hospitalIconView.snp.makeConstraints { (make) in
            make.top.equalTo(hospitalLabel)
            make.right.equalTo(-16)
            make.size.equalTo(CGSize(width: 70, height: 90))
        }
        
        hospitalLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(24)
            make.right.equalTo(hospitalIconView.snp.left).offset(-16)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hospitalLabel.snp.bottom).offset(16)
            make.left.right.equalTo(hospitalLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.right.equalTo(hospitalLabel)
        }
        
        mobileView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalTo(hospitalLabel)
        }
        
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(mobileView.snp.bottom).offset(8)
            make.left.equalTo(hospitalLabel)
            make.right.equalTo(-16)
        }
        
        locView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(8)
            make.left.equalTo(hospitalLabel)
            make.right.equalTo(-16)
            make.bottom.equalTo(-24)
        }
    }
    
    func add(subview: UILabel, icon: String, to view: UIView) -> UIView {
        let tempView = view.zz_add(subview: UIView())
        let icon = tempView.zz_add(subview: UIImageView(image: UIImage(named: icon)))
        tempView.addSubview(subview)
        
        icon.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.bottom.greaterThanOrEqualToSuperview()
        }
        
        subview.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(10)
            make.top.right.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        return tempView
    }
}

// MARK: - Action
extension MyCardController {
    @objc func shareAction() {
        print(#function)
    }
}

// MARK: - Network
extension MyCardController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension MyCardController {
    
}

// MARK: - Other
extension MyCardController {
    
}

// MARK: - Public
extension MyCardController {
    
}

