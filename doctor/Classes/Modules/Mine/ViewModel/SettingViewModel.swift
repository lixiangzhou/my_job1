//
//  SettingViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//

import UIKit

class SettingViewModel: BaseViewModel {
    enum RowType: String {
        case about = "关于我们"
        case privacyPolicy = "隐私政策"
        case serviceTerms = "服务条款"
        case contactUs = "联系我们"
    }
    
    struct RowModel {
        let type: RowType
        let config: LeftRightConfigViewConfig
    }
    
    var dataSource = [RowModel]()
    
    override init() {
        super.init()
        
        dataSource += [
            RowModel(type: .about, config: commonCellConfig()),
            RowModel(type: .privacyPolicy, config: commonCellConfig()),
            RowModel(type: .serviceTerms, config: commonCellConfig()),
            RowModel(type: .contactUs, config: commonCellConfig())
        ]
    }
    
    override func commonCellConfig() -> LeftRightConfigViewConfig {
        return LeftRightConfigViewConfig(leftPaddingRight: 0, leftFont: .size(14), bottomLineLeftPadding: 16, bottomLineRightPadding: 16)
    }
}
