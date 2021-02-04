//
//  MineTopView.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//  
//

import UIKit

class MineTopView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: UIScreen.zz_navHeight + navPannelTopPadding + pannelHeight + navPannelBottomPadding + bottomLineHeight))
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    let titleLabel = UILabel(text: "我的", font: .boldSize(20), textColor: .white, textAlignment: .center)
    var pannelView = UIView()
    let loginView = LoginView()
    let infoView = InfoView()
    
    let favView = ImageTitleView()
    let consultView = ImageTitleView()
    
    let padding: CGFloat = 16
    let navPannelTopPadding: CGFloat = 16
    let pannelHeight: CGFloat = 174
    let navPannelBottomPadding: CGFloat = 24
    let bottomLineHeight: CGFloat = 8
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension MineTopView {
    private func setUI() {
        backgroundColor = .white
        
        setTopBgView()
        setPannelView()
        setBottomView()
        
        addBottomLine(color: .cf8f8f8, height: bottomLineHeight)
    }
    
    func setTopBgView() {
        zz_add(subview: UIView(), frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 104 + UIScreen.zz_navHeight), bgColor: .c4167f3)
        
        zz_add(subview: titleLabel, frame: CGRect(x: 0, y: UIScreen.zz_nav_statusHeight, width: UIScreen.zz_width, height: 44))
    }
    
    func setPannelView() {
        pannelView.frame = CGRect(x: padding, y: titleLabel.zz_maxY + padding, width: UIScreen.zz_width - padding * 2, height: pannelHeight)
        
        pannelView.backgroundColor = .white
        pannelView.zz_setCorner(radius: 8, masksToBounds: true)
        addSubview(pannelView)
        pannelView.addShadow(topOffset: 86)
        
        loginView.frame = CGRect(x: 0, y: 0, width: pannelView.zz_width, height: 92)
        infoView.frame = loginView.frame
        pannelView.addSubview(loginView)
        pannelView.addSubview(infoView)
    }
    
    func setBottomView() {
        let sepView = pannelView.zz_add(subview: UIView(frame: CGRect(x: padding, y: loginView.zz_maxY, width: pannelView.zz_width - padding * 2, height: 1), bgColor: .cf5f5f5))
        
        let config = ImageTitleView.Config(imageSize: CGSize(width: 24, height: 24), verticalHeight1: 0, verticalHeight2: 8, titleLeft: 0, titleRight: 0, titleFont: .size(12), titleColor: .c3)
        favView.config = config
        consultView.config = config
        
        favView.titleLabel.text = "我的收藏"
        consultView.titleLabel.text = "知识资讯"
        
        let bottomView = pannelView.zz_add(subview: UIView(frame: CGRect(x: 0, y: sepView.zz_maxY, width: pannelView.zz_width, height: pannelHeight - sepView.zz_maxY)))
        
        bottomView.addSubview(favView)
        bottomView.addSubview(consultView)
        
        let bottomCenterView = bottomView.zz_add(subview: UIView())
        
        bottomCenterView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        favView.snp.makeConstraints { (make) in
            make.top.equalTo(padding)
            make.bottom.equalTo(-padding)
            make.right.equalTo(bottomCenterView).offset(-40)
        }
        
        consultView.snp.makeConstraints { (make) in
            make.top.equalTo(padding)
            make.bottom.equalTo(-padding)
            make.left.equalTo(bottomCenterView).offset(40)
        }
    }
}

// MARK: - Action
extension MineTopView {
    
}

// MARK: - Helper
extension MineTopView {
    class LoginView: BaseView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            let iconView = RoundOptionView(frame: CGRect(x: 16, y: 16, width: 60, height: 60), radius: 30, roundColor: .cf4f5f6, roundingCorners: .allCorners)
            addSubview(iconView)
            iconView.addShadow(cornerRadius: 30)
            
            zz_add(subview: UILabel(text: "点击登录/注册", font: .boldSize(16), textColor: .c3), frame: CGRect(x: iconView.zz_maxX + 16, y: 35, width: 150, height: 22))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class InfoView: BaseView {
        let iconView = UIImageView(frame: CGRect(x: 16, y: 16, width: 60, height: 60))
        let nameLabel = UILabel(text: "金小小", font: .boldSize(16), textColor: .c3)
        let titleLabel = UILabel(text: "主治医生", font: .size(12), textColor: .c3)
        var applyBtn: UIButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            
            iconView.zz_setCircle()
            addSubview(iconView)
            iconView.addShadow(cornerRadius: 30)
            
            addSubview(nameLabel)
            addSubview(titleLabel)
            
            applyBtn = UIButton(title: "申请认证", font: .size(10), titleColor: .white, backgroundColor: .c4167f3, target: self, action: #selector(applyAction))
            applyBtn.zz_setCorner(radius: 8, masksToBounds: true)
            
            addSubview(applyBtn)
            
            nameLabel.snp.makeConstraints { (make) in
                make.top.equalTo(26)
                make.left.equalTo(iconView.snp.right).offset(16)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(nameLabel)
                make.left.equalTo(nameLabel.snp.right).offset(8)
                make.right.lessThanOrEqualTo(-16)
            }
            
            applyBtn.snp.makeConstraints { (make) in
                make.top.equalTo(nameLabel.snp.bottom).offset(6)
                make.left.equalTo(nameLabel)
                make.width.equalTo(60)
                make.height.equalTo(16)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func applyAction() {
            
        }
    }
}

// MARK: - Other
extension MineTopView {
    
}

// MARK: - Public
extension MineTopView {
    
}
