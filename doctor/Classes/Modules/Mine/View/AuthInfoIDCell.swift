//
//  AuthInfoIDCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class AuthInfoIDCell: UITableViewCell {
    
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
    
    var imageData = [AuthInfoViewModel.ImageData]() {
        didSet {
            let idImage1 = imageData[0]
            let idImage2 = imageData[1]
            
            idCardView1.setImageData(idImage1)
            idCardView2.setImageData(idImage2)
        }
    }
    
    let idCardView1 = AuthInfoPicItemView()
    let idCardView2 = AuthInfoPicItemView()
    
    var currentView: AuthInfoPicItemView!
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension AuthInfoIDCell {
    private func setUI() {
        let xxIcon = UIImageView(image: UIImage(named: "mine_auth_xx"))
        let titleLabel = UILabel(text: "身份资料实名认证", font: .boldSize(16), textColor: .c3)
        let descLabel = UILabel(text: "添加身份凭证，如执业医师执照、目前职位的工牌，有利于扩散你的人脉和提高个人信誉。", font: .size(14), textColor: .c6)
        contentView.addSubview(xxIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        
        let w = (UIScreen.zz_width - 16 * 2 - 2) * 0.5
        
        idCardView1.addView.titleLabel.text = "上传身份证正面"
        idCardView2.addView.titleLabel.text = "上传身份证国徽面"
        
        idCardView1.addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(idCardAddAction1)))
        idCardView2.addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(idCardAddAction2)))
        
        idCardView1.delBtn.addTarget(self, action: #selector(idCardDeleteAction1), for: .touchUpInside)
        idCardView2.delBtn.addTarget(self, action: #selector(idCardDeleteAction2), for: .touchUpInside)
        
        contentView.addSubview(idCardView1)
        contentView.addSubview(idCardView2)
        
        let titleLabel2 = UILabel(text: "服务认证", font: .boldSize(16), textColor: .c3)
        let descLabel2 = UILabel(text: "服务认证通过后，您可再次进行患者管理，为其提供咨询服务、诊疗、评估、量表填写等服务，宝林医生平台助您轻松打造个人品牌。", font: .size(14), textColor: .c6)
        contentView.addSubview(titleLabel2)
        contentView.addSubview(descLabel2)
        
        xxIcon.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(xxIcon.snp.right).offset(8)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(xxIcon)
        }
        
        idCardView1.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(2)
            make.left.equalTo(16)
            make.width.equalTo(w)
            make.height.equalTo(107)
        }
        
        idCardView2.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.width.height.equalTo(idCardView1)
        }
        
        titleLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(idCardView1.snp.bottom).offset(8)
            make.left.equalTo(16)
        }
        
        descLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel2)
            make.top.equalTo(titleLabel2.snp.bottom).offset(4)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension AuthInfoIDCell {
    @objc private func idCardAddAction1() {
        currentView = idCardView1
        UIImagePickerController.showPicker(sourceType: .photoLibrary, from: self.zz_controller!, delegate: self)
    }
    
    @objc private func idCardAddAction2() {
        currentView = idCardView2
        UIImagePickerController.showPicker(sourceType: .photoLibrary, from: self.zz_controller!, delegate: self)
    }
    
    @objc private func idCardDeleteAction1() {
        imageData[0].image = nil
        idCardView1.showAdd()
    }
    
    @objc private func idCardDeleteAction2() {
        imageData[1].image = nil
        idCardView2.showAdd()
    }
}

// MARK: - Delegate
extension AuthInfoIDCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            currentView.showImage(img)
            if currentView == idCardView1 {
                imageData[0].image = img
            } else {
                imageData[1].image = img
            }
        }
        picker.dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        picker.dismiss()
    }
}

// MARK: - Other
extension AuthInfoIDCell {
    
}

// MARK: - Public
extension AuthInfoIDCell {
    
}
