//
//  AuthInfoViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//

import UIKit

class AuthInfoViewModel: BaseViewModel {
    var dataSource = [
        RowModel(row: .idcard, images: [ImageData(), ImageData()]),
        RowModel(row: .qualification, images: []),
        RowModel(row: .practice, images: []),
        RowModel(row: .title, images: []),
        RowModel(row: .photo, images: []),
    ]
    
    override init() {
        super.init()
        
        
    }
}

extension AuthInfoViewModel {
    class RowModel {
        var row: Row
        var images: [ImageData]
        init(row: Row, images: [ImageData]) {
            self.row = row
            self.images = images
        }
    }
    
    class ImageData {
        var image: UIImage?
        var url: String?
    }
    
    enum Row: String {
        case idcard = "身份资料实名认证"
        case qualification = "医生资格证"
        case practice = "医生执业证"
        case title = "医生职称证"
        case photo = "正面照"
    }
}
