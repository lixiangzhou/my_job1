//
//  AuthInfoPicItemView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/16.
//  
//

import UIKit

class AuthInfoPicItemView: BaseView {
    let imgView = UIImageView()
    let delBtn = UIButton(imageName: "mine_auth_pic_del")
    let addView = ImageTitleView()
    
    func setImageData(_ data: AuthInfoViewModel.ImageData) {
        if let img = data.image {
            showImage(img)
        } else {
            showAdd()
        }
    }
    
    func showAdd() {
        imgView.isHidden = true
        delBtn.isHidden = true
        addView.isHidden = false
        imgView.image = nil
    }
    
    func showImage(_ image: UIImage) {
        imgView.isHidden = false
        delBtn.isHidden = false
        addView.isHidden = true
        
        imgView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView.imgView.image = UIImage(named: "mine_auth_pic")
        addView.titleLabel.text = "添加证件照"
        
        addView.backgroundColor = .cf6f8ff
        addView.config = .init(imageSize: CGSize(width: 40, height: 40), verticalHeight1: 17, verticalHeight2: 4, titleLeft: 0, titleRight: 0, titleFont: .size(12), titleColor: .c4167f3)
        imgView.zz_setCorner(radius: 4, masksToBounds: true)
        addView.zz_setCorner(radius: 4, masksToBounds: true)
        
        imgView.contentMode = .scaleAspectFill
        
        addSubview(addView)
        addSubview(imgView)
        addSubview(delBtn)
        
        showAdd()
        
        imgView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(delBtn.snp.centerY)
            make.right.equalTo(delBtn.snp.centerX)
        }
        
        addView.snp.makeConstraints { (make) in
            make.edges.equalTo(imgView)
        }
        
        delBtn.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
