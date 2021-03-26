//
//  EMREditDiagnosisConfirmViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisConfirmViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            self.dataSourceProperty.value = [
                .title(title: "确认诊断", isBig: true, top: 12, bottom: 0),
                .title(title: "填写诊断量表", isBig: false, top: 8, bottom: 0),
                .scale(name: "腰椎间盘突出症诊断量表", score: 2, degree: "轻度", isFinished: true),
                .scale(name: "下腰痛障碍调查问卷", score: 2, degree: "轻度", isFinished: false),
                .item(title: "腰椎MRI", txt: Text(), imgs: []),
                .item(title: "C-反应蛋白", txt: Text(), imgs: []),
                .title(title: "其他", isBig: false, top: 16, bottom: 4),
                .txt(Text()),
                .title(title: "请选择确认诊断结果", isBig: false, top: 16, bottom: 0),
                .item2(left: Text(), right: Text()),
                .bottom
            ]
        }
    }
    
    func add() {
        var dataSource = dataSourceProperty.value
        dataSourceProperty.value = dataSource
    }
}

extension EMREditDiagnosisConfirmViewModel {
    enum RowModel {
        case title(title: String, isBig: Bool, top: CGFloat, bottom: CGFloat)
        case scale(name: String, score: Int, degree: String, isFinished: Bool)
        case item(title: String, txt: Text, imgs: [ImageData])
        case txt(Text)
        case item2(left: Text, right: Text)
        case bottom
    }
}
