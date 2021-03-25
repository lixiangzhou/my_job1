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
            RowModel(text: Text(), row: .avator),
            RowModel(text: Text(), row: .userName),
            RowModel(text: Text(), row: .realName),
            RowModel(text: Text(), row: .sex),
            RowModel(text: Text(), row: .identity),
            RowModel(text: Text(), row: .hospital),
            RowModel(text: Text(), row: .dept),
            RowModel(text: Text(), row: .title),
            RowModel(text: Text(), row: .contractNumber),
            RowModel(text: Text(), row: .email),
            RowModel(text: Text(), row: .address),
            RowModel(text: Text(), row: .major),
            RowModel(text: Text(), row: .degree),
            RowModel(text: Text(), row: .workExperience),
            RowModel(text: Text(), row: .trainingExperience)
        ]
    }()
    
    override func commonCellConfig() -> LeftRightConfigViewConfig {
        LeftRightConfigViewConfig(leftPaddingRight: 0, leftFont: .size(14), rightFont: .size(14), rightPaddingLeft: 8, rightPaddingLeftEdge: 110, hasBottomLine: true, bottomLineColor: .cf5f5f5, bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
    }
}

extension PersonInfoEditViewModel {
    struct RowModel {
        var text: Text
        var row: Row
        
        var placeholder: String {
            func input(_ string: String, sufix: String? = nil) -> String {
                "请输入\(string)\(sufix ?? "")"
            }
            
            switch row {
            case .avator, .sex:
                return ""
            case .userName, .realName, .address:
                return input(row.rawValue)
            case .hospital, .dept, .major, .degree:
                return input(row.rawValue, sufix: "名称")
            case .email:
                return input("邮箱地址")
            case .contractNumber:
                return input("电话号码")
            case .title, .identity, .workExperience, .trainingExperience:
                return "待完善"
            }
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
        case workExperience = "工作经历"
        case trainingExperience = "教育培训经历"
    }
}
