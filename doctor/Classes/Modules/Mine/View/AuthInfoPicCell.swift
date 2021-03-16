//
//  AuthInfoPicCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class AuthInfoPicCell: UITableViewCell {
    
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
    let titleLabel = UILabel(text: " ", font: .boldSize(16), textColor: .c3)
    var needRefreshClosure: (() -> Void)?
    var model: AuthInfoViewModel.RowModel! {
        didSet {
            let images = model.images
            let range = 0...images.count
            
            let paddingY: CGFloat = 2
            let w = (UIScreen.zz_width - 16 * 2 - 2) * 0.5
            let h: CGFloat = 107
            
            picView.zz_removeAllSubviews()
            
            for i in range {
                let row = CGFloat(i / 2)
                let x = i & 1 == 0 ? 0 : w + 2
                let y = row * (h + paddingY)
                if i == images.count {
                    addView.frame = CGRect(x: x, y: y, width: w, height: h)
                    picView.addSubview(addView)
                } else {
    //                let imgView = UIImageView(frame: CGRect(x: x, y: y, width: w, height: h))
    //                imgView.zz_setCorner(radius: 4, masksToBounds: true)
                    let imgView = AuthInfoPicItemView(frame: CGRect(x: x, y: y, width: w, height: h))
                    imgView.delBtn.addTarget(self, action: #selector(delAction), for: .touchUpInside)
                    imgView.delBtn.tag = i
                    if let img = images[i].image {
                        imgView.showImage(img)
                    }
                    picView.addSubview(imgView)
                }
            }
            
            picView.snp.updateConstraints { (make) in
                make.height.equalTo(addView.zz_maxY)
            }
        }
    }
    
    // MARK: - Private Property
    private var collectionView: UICollectionView!
    private let picView = UIView()
    private let addView = AuthInfoPicItemView()
    
}

// MARK: - UI
extension AuthInfoPicCell {
    private func setUI() {
        let xxIcon = UIImageView(image: UIImage(named: "mine_auth_xx"))
        
        contentView.addSubview(xxIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(picView)
        
        addView.imgView.image = UIImage(named: "mine_auth_pic")
        addView.addView.titleLabel.text = "添加证件照"
        
        let w = (UIScreen.zz_width - 16 * 2 - 2) * 0.5
        let h: CGFloat = 107

        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
        
        xxIcon.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(xxIcon.snp.right).offset(8)
        }
        
        picView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(107)
            make.bottom.equalTo(-8)
        }
    }
}

// MARK: - Action
extension AuthInfoPicCell {
    @objc func addAction() {
        UIImagePickerController.showPicker(sourceType: .photoLibrary, from: self.zz_controller!, delegate: self)
    }
    
    @objc func delAction(_ sender: UIView) {
        model.images.remove(at: sender.tag)
        needRefreshClosure?()
    }
}

// MARK: - Delegate
extension AuthInfoPicCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let m = AuthInfoViewModel.ImageData()
            m.image = img
            model.images.append(m)
            needRefreshClosure?()
        }
        picker.dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        picker.dismiss()
    }
}

// MARK: - Public
extension AuthInfoPicCell {
}

