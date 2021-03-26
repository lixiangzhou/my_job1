//
//  EMREditDiagnosisComfirmItemCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditDiagnosisComfirmItemCell: UITableViewCell {
    
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
    var needRefreshClosure: (() -> Void)?
    var imageDatas = [ImageData]() {
        didSet {
            let range = 0...imageDatas.count
            
            let paddingY: CGFloat = 2
            let w = (UIScreen.zz_width - emrEditLeftWidth - 12 - 16) / 3
            let h: CGFloat = 80
            
            picView.zz_removeAllSubviews()
            
            for i in range {
                let row = CGFloat(i / 3)
                let col = CGFloat(i % 3)
                let x = col * (w + 1)
                let y = row * (h + paddingY)
                if i == imageDatas.count {
                    addView.frame = CGRect(x: x, y: y, width: w, height: h)
                    picView.addSubview(addView)
                } else {
    //                let imgView = UIImageView(frame: CGRect(x: x, y: y, width: w, height: h))
    //                imgView.zz_setCorner(radius: 4, masksToBounds: true)
                    let imgView = EMREditPicView(frame: CGRect(x: x, y: y, width: w, height: h))
                    imgView.delBtn.addTarget(self, action: #selector(delAction), for: .touchUpInside)
                    imgView.delBtn.tag = i
                    if let img = imageDatas[i].image {
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
    
    let titleLabel = UILabel(font: .size(14), textColor: .c3)
    let picView = UIView()
    let addView = EMREditPicView()
    
    // MARK: - Private Property
    let txtView = ZZGrowTextView()
}

// MARK: - UI
extension EMREditDiagnosisComfirmItemCell {
    private func setUI() {
        contentView.addSubview(titleLabel)
        
        setTxtView(txtView)
        txtView.config = .init(minHeight: 37, maxHeight: 37)
        contentView.addSubview(txtView)
        contentView.addSubview(picView)
        
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(16)
            make.height.equalTo(22)
        }
        
        txtView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        picView.snp.makeConstraints { (make) in
            make.top.equalTo(txtView.snp.bottom).offset(1)
            make.left.equalTo(12)
            make.right.equalTo(-16)
            make.height.equalTo(80)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension EMREditDiagnosisComfirmItemCell {
    @objc func addAction() {
        UIImagePickerController.showPicker(sourceType: .photoLibrary, from: self.zz_controller!, delegate: self)
    }
    
    @objc func delAction(_ sender: UIView) {
        imageDatas.remove(at: sender.tag)
        needRefreshClosure?()
    }
}

// MARK: - Delegate
extension EMREditDiagnosisComfirmItemCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let m = ImageData()
            m.image = img
            imageDatas.append(m)
            needRefreshClosure?()
        }
        picker.dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        picker.dismiss()
    }
}
