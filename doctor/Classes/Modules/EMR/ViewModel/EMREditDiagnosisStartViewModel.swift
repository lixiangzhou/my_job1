//
//  EMREditDiagnosisStartViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisStartViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            self.dataSourceProperty.value = [
                .top,
                .item(left: Text(), right: Text()),
                .bottom
            ]
        }
    }
    
    func add() {
        var dataSource = dataSourceProperty.value
        dataSource.insert(.item(left: Text(), right: Text()), at: dataSource.count - 1)
        dataSourceProperty.value = dataSource
    }
    
    func delete() {
        if dataSourceProperty.value.count <= 3 {
            return
        }
        dataSourceProperty.value.remove(at: dataSourceProperty.value.count - 2)
    }
}

extension EMREditDiagnosisStartViewModel {
    enum RowModel {
        case top
        case item(left: Text, right: Text)
        case bottom
    }
}
