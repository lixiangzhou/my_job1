//
//  EMREditHPIViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//

import UIKit
import ReactiveSwift

class EMREditHPIViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            self.dataSourceProperty.value = [
                .top,
                .title("头部左侧疼痛问题", 8),
                .arrow(title: "晨起疼痛程度", text: Text(), shortTop: true, hasX: true),
                .arrow(title: "疼痛最重的时间段", text: Text(), hasX: false),
                .arrow(title: "疼痛性质", text: Text(), hasX: true),
                .checkbox(title: "是否有外院就诊史", select: true),
                .sep,
                .title("头部左侧疼痛问题", 16),
                .arrow(title: "晨起疼痛程度", text: Text(), shortTop: true, hasX: true),
                .arrow(title: "疼痛最重的时间段", text: Text(), hasX: false),
                .arrow(title: "疼痛性质", text: Text(), hasX: true),
                .bottom
            ]
        }
    }
}

extension EMREditHPIViewModel {
    enum RowModel {
        case top
        case title(String, CGFloat)
        case sep
        case checkbox(title: String, select: Bool)
        case arrow(title: String, text: Text, shortTop: Bool = false, hasX: Bool)
        case bottom
    }
}
