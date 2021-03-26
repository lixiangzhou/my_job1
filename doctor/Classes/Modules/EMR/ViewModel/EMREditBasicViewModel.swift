//
//  EMREditBasicViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//

import UIKit
import ReactiveSwift

class EMREditBasicViewModel: BaseViewModel {
    lazy var dataSource: [GroupModel<RowModel>] = {
        [
            GroupModel(title: "患者基本信息", list: [
                RowModel(text: Text(), row: .name),
                RowModel(text: Text(), row: .sex),
                RowModel(text: Text(), row: .idNo),
                RowModel(text: Text(), row: .nation),
                RowModel(text: Text(), row: .contractNumber),
                RowModel(text: Text(), row: .address),
            ]),
            GroupModel(title: "为便于研究，以下信息建议完整填写", list: [
                RowModel(text: Text(), row: .height),
                RowModel(text: Text(), row: .weight),
                RowModel(text: Text(), row: .marriage),
                RowModel(text: Text(), row: .education),
                RowModel(text: Text(), row: .major),
                RowModel(text: Text(), row: .income),
            ])
//            RowModel(text: Text(), row: .avator),
//            RowModel(text: Text(), row: .userName),
//            RowModel(text: Text(), row: .realName),
//            RowModel(text: Text(), row: .sex),
//            RowModel(text: Text(), row: .identity),
//            RowModel(text: Text(), row: .hospital),
//            RowModel(text: Text(), row: .dept),
//            RowModel(text: Text(), row: .title),
//            RowModel(text: Text(), row: .contractNumber),
//            RowModel(text: Text(), row: .email),
//            RowModel(text: Text(), row: .address),
//            RowModel(text: Text(), row: .major),
//            RowModel(text: Text(), row: .degree),
//            RowModel(text: Text(), row: .workExperience),
//            RowModel(text: Text(), row: .trainingExperience)
        ]
    }()
    
    override func commonCellConfig() -> LeftRightConfigViewConfig {
        LeftRightConfigViewConfig(leftPaddingRight: 0, leftFont: .size(14), rightFont: .size(14), rightPaddingLeft: 8, rightPaddingLeftEdge: 110, hasBottomLine: true, bottomLineColor: .cf5f5f5, bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
    }
}

extension EMREditBasicViewModel {
    
    struct RowModel {
        var text: Text
        var row: Row
        
        var placeholder: String {
            switch row {
            case .sex:
                return ""
            case .name:
                return "请输入您的真实姓名"
            case .idNo, .contractNumber:
                return "请输入您的真实号码"
            case .height, .weight:
                return "请输入"
            case .nation, .address, .major, .marriage, .education, .income:
                return "待完善"
            }
        }
    }
    
    enum Row: String {
        case name = "姓名"
        case sex = "性别"
        case idNo = "身份证号"
        case nation = "名族"
        case contractNumber = "联系电话"
        case address = "地址"
        
        case height = "身高(cm)"
        case weight = "体重(kg)"
        case marriage = "婚姻状况"
        case education = "教育程度"
        case major = "职业"
        case income = "收入"
    }
    
}
