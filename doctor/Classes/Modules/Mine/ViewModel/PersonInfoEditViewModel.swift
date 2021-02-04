//
//  PersonInfoEditViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//

import UIKit
import ReactiveSwift

class PersonInfoEditViewModel: BaseViewModel {
    lazy var dataSource: [RowModel] = {
        [
            RowModel.init(text: nil, row: .avator, config: commonCellConfig()),
            RowModel.init(text: nil, row: .userName, config: commonCellConfig()),
            RowModel.init(text: nil, row: .realName, config: commonCellConfig()),
            RowModel.init(text: nil, row: .sex, config: commonCellConfig()),
            RowModel.init(text: nil, row: .identity, config: commonCellConfig()),
            RowModel.init(text: nil, row: .hospital, config: commonCellConfig()),
            RowModel.init(text: nil, row: .dept, config: commonCellConfig()),
            RowModel.init(text: nil, row: .title, config: commonCellConfig()),
            RowModel.init(text: nil, row: .contractNumber, config: commonCellConfig()),
            RowModel.init(text: nil, row: .email, config: commonCellConfig()),
            RowModel.init(text: nil, row: .address, config: commonCellConfig()),
            RowModel.init(text: nil, row: .major, config: commonCellConfig()),
            RowModel.init(text: nil, row: .degree, config: commonCellConfig()),
            RowModel.init(text: nil, row: .remark, config: commonCellConfig()),
            RowModel.init(text: nil, row: .workExperience, config: commonCellConfig()),
            RowModel.init(text: nil, row: .trainingExperience, config: commonCellConfig())
        ]
    }()
    
    override func commonCellConfig() -> LeftRightConfigViewConfig {
        LeftRightConfigViewConfig(leftPaddingRight: 0, leftFont: .size(14), rightFont: .size(14), rightPaddingLeft: 8, rightPaddingLeftEdge: 110, hasBottomLine: true, bottomLineColor: .cf5f5f5, bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
    }
}

extension PersonInfoEditViewModel {
    struct RowModel {
        var text: String?
        var row: Row
        var config: LeftRightConfigViewConfig
        
        var showText: String {
            text ?? "待完善"
        }
        
        var textColor: UIColor {
            text != nil ? UIColor.c3 : UIColor.c26d765
        }
    }
    
    enum Row: String {
        case avator = "头像"
        case userName = "用户名"
        case realName = "真实姓名"
        case sex = "性别"
        case identity = "身份"
        case hospital = "医院"
        case dept = "科室"
        case title = "职称"
        case contractNumber = "联系电话"
        case email = "邮箱"
        case address = "地址"
        case major = "专业"
        case degree = "学位"
        case remark = "备注"
        case workExperience = "工作经历"
        case trainingExperience = "教育培训经历"
    }
    
}
