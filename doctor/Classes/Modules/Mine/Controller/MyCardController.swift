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
     
        nameLabel.text = "王一"
        titleLabel.text = "主治医生"
        
        mobileLabel.text = "138 8888 8888"
        emailLabel.text = "13888888888@qq.com"
        locLabel.text = "青海省西宁市XX路"
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    let cardView = UIView()
    let nameLabel = UILabel(text: " ", font: .boldSize(20), textColor: .c211e59)
    let titleLabel = UILabel(text: " ", font: .size(12), textColor: .c3)
    let deptLabel = UILabel(text: " ", font: .size(12), textColor: .c6)
    
    let mobileLabel = UILabel(text: " ", font: UIFont.PingFangSC.regular.size(10), textColor: .c9)
    let emailLabel = UILabel(text: " ", font: UIFont.PingFangSC.regular.size(10), textColor: .c9)
    let locLabel = UILabel(text: " ", font: UIFont.PingFangSC.regular.size(10), textColor: .c9)
}

// MARK: - UI
extension MyCardController {
    override func setUI() {
        view.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.zz_setCorner(radius: 4, masksToBounds: true)
        cardView.addSubview(nameLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(deptLabel)
        
        let bg1 = cardView.zz_add(subview: UIImageView(image: UIImage(named: "mine_card_icon1")))
        let bg2 = cardView.zz_add(subview: UIImageView(image: UIImage(named: "mine_card_icon2")))
        
        let mobileView = add(subview: mobileLabel, icon: "mine_card_mobile", to: cardView)
        let emailView = add(subview: emailLabel, icon: "mine_card_email", to: cardView)
        let locView = add(subview: locLabel, icon: "mine_card_loc", to: cardView)
        
        let btn = view.zz_add(subview: UIButton(title: "保存到相册", font: UIFont.PingFangSC.regular.size(14), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(save)))
        btn.zz_setCorner(radius: 4, masksToBounds: true)
        
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(228)
        }
        
        bg1.snp.makeConstraints { (make) in
            make.top.equalTo(32)
            make.right.equalTo(-20)
            make.width.height.equalTo(54)
        }
        
        bg2.snp.makeConstraints { (make) in
            make.top.equalTo(92)
            make.left.right.equalToSuperview()
            make.height.equalTo(86)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(32)
            make.left.equalTo(24)
            make.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
            make.height.equalTo(17)
        }
        
        deptLabel.snp.makeConstraints { (make) in
            make.top.height.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
        
        mobileView.snp.makeConstraints { (make) in
            make.top.equalTo(160)
            make.left.equalTo(nameLabel)
        }
        
        emailView.snp.makeConstraints { (make) in
            make.left.equalTo(150)
            make.top.equalTo(mobileView)
            make.right.equalTo(-24)
        }
        
        locView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(emailView.snp.bottom).offset(8)
            make.right.equalTo(-24)
        }
        
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.bottom).offset(40)
            make.left.equalTo(42)
            make.height.equalTo(42)
            make.right.equalTo(-42)
        }
    }
    
    func add(subview: UILabel, icon: String, to view: UIView) -> UIView {
        let tempView = view.zz_add(subview: UIView())
        let icon = tempView.zz_add(subview: UIImageView(image: UIImage(named: icon)))
        tempView.addSubview(subview)
        
        icon.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        subview.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(5)
            make.top.equalTo(icon)
        }
        
        return tempView
    }
}

// MARK: - Action
extension MyCardController {
    @objc func save() {
        UIImageWriteToSavedPhotosAlbum(cardView.zz_snapshotImage(), self, #selector(savedPhotosAlbum(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func savedPhotosAlbum(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error == nil {
            HUD.show(toast: "保存成功")
        }
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

