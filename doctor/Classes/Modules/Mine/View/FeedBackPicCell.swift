//
//  FeedBackPicCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//  
//

import UIKit

class FeedBackPicCell: UITableViewCell {
    
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
    
    // MARK: - Private Property
    
    var collectionView: UICollectionView!
    
    var images = [UIImage]()
    
    var addClosure: (() -> Void)?
    var deleteClosure: (() -> Void)?
    
    private let padding: CGFloat = 10
    private let column: CGFloat = 4
    private var itemWH: CGFloat {
        (UIScreen.zz_width - 32 - (padding * (column - 1))) / column
    }
}

// MARK: - UI
extension FeedBackPicCell {
    private func setUI() {
        contentView.backgroundColor = .white
        let titleLabel = contentView.zz_add(subview: UILabel(text: "上传图片", font: UIFont.PingFangSC.medium.size(16), textColor: .c3))
        
        
        let itemWH = self.itemWH
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: FeedBackPicItemCell.self)
        collectionView.backgroundColor = .white
        contentView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(16)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(itemWH)
            make.bottom.equalTo(-4)
        }
    }
}

extension FeedBackPicCell: UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: FeedBackPicItemCell.self, for: indexPath)
        if indexPath.row != images.count {
            cell.iconView.image = images[indexPath.row]
            cell.iconView.backgroundColor = .white
            cell.iconView.contentMode = .scaleAspectFill
            cell.deleteBtn.isHidden = false
        } else {
            cell.iconView.image = UIImage(named: "mine_feedback_add")
            cell.iconView.backgroundColor = .cf6f8ff
            cell.iconView.contentMode = .center
            cell.deleteBtn.isHidden = true
        }
        
        cell.deleteClosure = { [weak self] in
            self?.images.remove(at: indexPath.row)
            collectionView.reloadData()
            self?.deleteClosure?()
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count {
            UIImagePickerController.showPicker(sourceType: .photoLibrary, from: self.zz_controller!, delegate: self)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options) { [weak self] img, _ in
                if let img = img {
                    self?.addImage(img)
                }
            }
            picker.dismiss()
        }
    }
    
    private func addImage(_ image: UIImage) {
        images.append(image)
        collectionView.reloadData()
        
        let row: CGFloat = ceil(CGFloat(images.count + 1) / 4.0)
        let height = itemWH * row + (row - 1) * padding
        
        collectionView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        addClosure?()
    }
}



extension FeedBackPicCell {
    class FeedBackPicItemCell: UICollectionViewCell {
        let iconView = UIImageView()
        let deleteBtn = UIButton(imageName: "mine_pic_delete", hilightedImageName: "mine_pic_delete")
        var deleteClosure: (() -> Void)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.backgroundColor = .white
            iconView.zz_setCorner(radius: 4, masksToBounds: true)
            contentView.addSubview(iconView)
            
            deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
            contentView.addSubview(deleteBtn)
            
            iconView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            deleteBtn.snp.makeConstraints { (make) in
                make.top.right.equalToSuperview()
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc private func deleteAction() {
            deleteClosure?()
        }
    }
}

// MARK: - Action
extension FeedBackPicCell {
    @objc func addAction() {
        addClosure?()
    }
}
