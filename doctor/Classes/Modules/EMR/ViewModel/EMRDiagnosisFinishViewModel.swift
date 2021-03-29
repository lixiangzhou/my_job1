//
//  EMRDiagnosisFinishViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//

import UIKit
import ReactiveSwift

class EMRDiagnosisFinishViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    var selectIndexPath = IndexPath()
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            
            var dataSource = [RowModel]()
            
            dataSource.append(.top(model: String()))
            
            dataSource.append(contentsOf: self.getTop())
            
            dataSource.append(contentsOf: self.getStandard())
            
            dataSource.append(contentsOf: self.getScaleItems())
            
            dataSource.append(.bottom)
            
            self.dataSourceProperty.value = dataSource
        }
    }
    
    func getTop() -> [RowModel] {
        [
            .text(left: "医生", right: "名字"),
            .text(left: "病历号", right: "345678"),
            .text(left: "诊断", right: "腰间盘突出"),
            .space(height: 12, color: .white),
            .space(height: 8, color: .cfbfbfb),
        ]
    }
    
    func getStandard() -> [RowModel] {
        [
            .title(title: "诊疗标准"),
            .text(left: "表格", right: "NRS疼痛评分"),
            .text(left: "标准", right: "NRS < 3"),
            .text(left: "现结果", right: "5"),
            .text(left: "达标结果", right: "5", rightColor: .cFF5050),
            .space(height: 12, color: .white),
            .space(height: 8, color: .cfbfbfb),
        ]
    }
    
    func getScaleItems() -> [RowModel] {
        [
            .title(title: "颈部疼痛调查表"),
            .item(model: String(), position: .start),
            .item(model: String(), position: .mid),
            .item(model: String(), position: .end),
            .space(height: 8, color: .white),
        ]
    }
}

extension EMRDiagnosisFinishViewModel {
    enum RowModel {
        case top(model: Any)
        case title(title: String)
        case text(left: String, right: String, rightColor: UIColor = .c3)
        case item(model: Any, position: Position)
        case space(height: CGFloat, color: UIColor)
        case bottom
    }
    
    enum Position {
        case start
        case mid
        case end
    }
}
