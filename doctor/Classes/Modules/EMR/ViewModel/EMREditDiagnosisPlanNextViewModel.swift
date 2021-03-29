//
//  EMREditDiagnosisPlanNextViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisPlanNextViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    var selectIndexPath = IndexPath()
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            
            self.dataSourceProperty.value = [
                .title,
                .diagnosis,
                .hospital,
                .toOtherHospital,
                .finish,
                .bottom
            ]
        }
    }
    
    func showDiagnosis(_ show: Bool) {
        
    }
    
    
}

extension EMREditDiagnosisPlanNextViewModel {
    enum RowModel: String {
        case title = "下一步诊疗计划"
        case diagnosis = "复诊"
        case hospital = "本医院住院"
        case toOtherHospital = "转其他医院"
        case finish = "诊断完成"
        case bottom = ""
    }
}
