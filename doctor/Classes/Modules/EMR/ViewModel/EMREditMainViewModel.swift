//
//  EMREditMainViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//

import UIKit
import ReactiveSwift

class EMREditMainViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            self.dataSourceProperty.value = [
                .top,
                .middle(item: Item(part: nil, time1: nil, time2: nil)),
                .bottom
            ]
        }
    }
    
    func add() {
        var dataSource = dataSourceProperty.value
        dataSource.insert(.middle(item: Item(part: nil, time1: nil, time2: nil)), at: dataSource.count - 1)
        dataSourceProperty.value = dataSource
    }
    
    func clean() {
        dataSourceProperty.value = [
            .top,
            .middle(item: Item(part: nil, time1: nil, time2: nil)),
            .bottom
        ]
    }
}

extension EMREditMainViewModel {
    enum RowModel {
        case top
        case middle(item: Item)
        case bottom
    }
    
    struct Item {
        var part: String?
        var time1: String?
        var time2: String?
    }
}
