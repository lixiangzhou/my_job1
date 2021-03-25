//
//  EMREditViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//

import UIKit

class EMREditViewModel: BaseViewModel {
    var selectIndexPath = IndexPath(row: 0, section: 0)
    
    lazy var dataSource: [GroupModel] = {
        [
            GroupModel(info: .home, models: getHomeModels(), isOpen: true),
            GroupModel(info: .diagnosis, models: getHomeModels(), isOpen: false),
        ]
    }()
    
    func prepareSubControllerFor(_ controller: UIViewController) {
        for g in dataSource {
            for m in g.models {
                controller.addChild(m.controller)
            }
        }
    }
}

extension EMREditViewModel {
    
    func getHomeModels() -> [RowModel] {
        [
            RowModel(item: .basic, controller: EMREditBasicController()),
            RowModel(item: .main, controller: EMREditMainController()),
            RowModel(item: .nsr, controller: EMREditNSRController()),
            RowModel(item: .hpi, controller: EMREditHPIController()),
            RowModel(item: .ph, controller: EMREditPHController()),
            RowModel(item: .allergic, controller: EMREditAllergicController()),
            RowModel(item: .familly, controller: EMREditFamillyController()),
            RowModel(item: .personal, controller: EMREditPersonalController()),
            RowModel(item: .zkct, controller: EMREditZKCTController()),
        ]
    }
    
    struct GroupModel {
        let info: EMRInfo
        var models: [RowModel]
        var isOpen: Bool
    }
    
    struct RowModel {
        let item: EMRInfoItem
        let controller: BaseController
//        var isSelect: Bool = false
    }
    
    enum EMRInfo: String {
        case home = "病历首页"
        case diagnosis = "诊疗记录"
    }
    
    enum EMRInfoItem: String {
        case basic = "基本信息"
        case main = "主述"
        case nsr = "NSR评分"
        case hpi = "现病史"
        case ph = "既往史"
        case allergic = "过敏史"
        case familly = "家族史"
        case personal = "个人史"
        case zkct = "专科查体"
    }
}
