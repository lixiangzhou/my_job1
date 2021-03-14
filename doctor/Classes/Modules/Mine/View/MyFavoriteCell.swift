//
//  MyFavoriteCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class MyFavoriteCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    let selectBtn = UIButton(imageName: "mine_fav_unsel", selectedImageName: "mine_fav_sel")
    let iconView = UIImageView()
    let titleLabel = UILabel(text: " ", font: UIFont.PingFangSC.medium.size(16), textColor: .c3, numOfLines: 2)
    
    let midLabel = UILabel(text: " ", font: UIFont.PingFangSC.regular.size(12), textColor: .c9)
    let bottomLabel = UILabel(text: " ", font: UIFont.PingFangSC.regular.size(12), textColor: .c9)
    
    let pannelView = UIView()
    
    var bottomLine: UIView!
    var selectClosure: (() -> Void)?
    
    var mode: MyFavoriteViewModel.Mode = .normal {
        didSet {
            let offset: Int
            switch mode {
            case .edit:
                offset = 40
            case .normal:
                offset = 0
            }
            
            pannelView.snp.updateConstraints { (make) in
                make.left.equalTo(offset)
            }
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    // MARK: - Private Property
}

// MARK: - UI
extension MyFavoriteCell {
    private func setUI() {
        backgroundColor = .white
        
        contentView.addSubview(selectBtn)
        
        contentView.addSubview(pannelView)
        iconView.zz_setCorner(radius: 4, masksToBounds: true)
        pannelView.addSubview(iconView)
        pannelView.addSubview(titleLabel)
        pannelView.addSubview(midLabel)
        pannelView.addSubview(bottomLabel)
        
        bottomLine = contentView.addBottomLine(left: 16, right: 16, height: 1)
     
        selectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        pannelView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.bottom.equalTo(-16)
            make.height.equalTo(90)
            make.width.equalTo(118)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(16)
            make.right.equalTo(-16)
        }
        
        midLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(bottomLabel.snp.top).offset(-4)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(iconView)
        }
        
        layoutIfNeeded()
    }
}

// MARK: - Action
extension MyFavoriteCell {
    @objc private func selectAction() {
        selectClosure?()
    }
}
