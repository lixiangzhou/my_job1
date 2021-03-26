//
//  EMREditDiagnosisCheckViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisCheckViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            self.dataSourceProperty.value = [
                .title("开具检查项目"),
                .item([]),
                .title("开具检验项目"),
                .item([]),
                .bottom
            ]
        }
    }
    
    func add() {
        var dataSource = dataSourceProperty.value
        dataSourceProperty.value = dataSource
    }
}

extension EMREditDiagnosisCheckViewModel {
    enum RowModel {
        case title(String)
        case item([String])
        case bottom
    }
}
