//
//  PatientHospitalAppointmentApplyViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//

import UIKit
import ReactiveSwift

class PatientHospitalAppointmentApplyViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    var selectIndexPath = IndexPath()
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            
//            var dataSource = [RowModel]()
//            self.dataSourceProperty.value = dataSource
            self.dataSourceProperty.value = [
                .space,
                .text(left: "姓名", right: "名字"),
                .text(left: "性别", right: "女"),
                .text(left: "年龄", right: "50岁"),
                .text(left: "就诊时间", right: "2021-01-15"),
                .text(left: "患者来源", right: "门诊"),
                .text(left: "联系电话", right: "123 4567 8901"),
                .text(left: "门诊医生", right: "王一"),
                .text(left: "门诊诊断", right: "腰间盘突出"),
                .action,
                .option(title: "本医院住院", left: "入院时间", right: Text()),
                .option(title: "转其他医院", left: "医院", right: Text()),
                .bottom
            ]
        }
    }
    
}

extension PatientHospitalAppointmentApplyViewModel {
    enum RowModel {
        case text(left: String, right: String)
        case action
        case option(title: String, left: String, right: Text)
        case space
        case bottom
    }
    
}
