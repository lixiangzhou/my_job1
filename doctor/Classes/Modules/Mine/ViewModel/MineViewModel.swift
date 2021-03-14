//
//  MineViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//

import UIKit

class MineViewModel: BaseViewModel {
    lazy var dataSource: [RowModel] = {
        [
            .init(type: .myCard, icon: "mine_card", config: commonIconCellConfig()),
            .init(type: .feedback, icon: "mine_feedback", config: commonIconCellConfig()),
            .init(type: .setting, icon: "mine_setting", config: lastIconCellConfig())
        ]
    }()
    
    override func lastIconCellConfig() -> LeftRightConfigViewConfig {
        LeftRightConfigViewConfig(leftView: UIImageView(), leftViewSize: CGSize(width: 18, height: 18), leftPaddingRight: 8, leftFont: .size(14), hasBottomLine: false)
    }
    
    override func commonIconCellConfig() -> LeftRightConfigViewConfig {
        LeftRightConfigViewConfig(leftView: UIImageView(), leftViewSize: CGSize(width: 18, height: 18), leftPaddingRight: 8, leftFont: .size(14), hasBottomLine: true, bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
    }
}

extension MineViewModel {
    struct RowModel {
        let type: RowType
        let icon: String
        let config: LeftRightConfigViewConfig
    }
    
    enum RowType: String {
        case myCard = "我的名片"
        case feedback = "意见反馈"
        case setting = "设置"
    }
}
