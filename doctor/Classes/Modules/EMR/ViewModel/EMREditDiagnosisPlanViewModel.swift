//
//  EMREditDiagnosisPlanViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//

import UIKit
import ReactiveSwift

class EMREditDiagnosisPlanViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            var dataSource = [RowModel]()
            dataSource.append(.title(title: "诊疗计划", isBig: true, top: 12, bottom: 0))
            dataSource.append(.title(title: "药物治疗", isBig: false, top: 8, bottom: 0))
            
            dataSource.append(contentsOf: self.getDrug())
            dataSource.append(.space(height: 16, color: .white))
            dataSource.append(.sep)
            dataSource.append(contentsOf: self.getDrug())
            dataSource.append(.add)
            dataSource.append(.space(height: 8, color: .cf8f8f8))
            
            
            dataSource.append(.title(title: "有创手术治疗", isBig: false, top: 16, bottom: 0))
            dataSource.append(contentsOf: self.getOp())
            dataSource.append(.space(height: 16, color: .white))
            dataSource.append(.space(height: 8, color: .cf8f8f8))
            
            dataSource.append(.title(title: "行为管理", isBig: false, top: 16, bottom: 0))
            dataSource.append(contentsOf: self.getOp())
            dataSource.append(.add)
            
            dataSource.append(.bottom(Text()))
            
            self.dataSourceProperty.value = dataSource
        }
    }
    
    func add() {
        var dataSource = dataSourceProperty.value
        dataSourceProperty.value = dataSource
    }
    
    func getDrug() -> [RowModel] {
        
        return [
            .arrow(left: "药物1", right: Text("西乐葆")),
            .text(left: "规格", right: Text("1mgX20片/盒")),
            .arrow(left: "用法", right: Text()),
            .text(left: "剂量", right: Text("0.2mg")),
            .text(left: "发药量", right: Text("3盒")),
            .arrow(left: "持续服药时间", right: Text()),
            .arrow(left: "开始服药时间", right: Text("2021-01-15 09:30")),
        ]
    }
    
    func getOp() -> [RowModel] {
        
        return [
            .arrow(left: "治疗", right: Text("冲击波")),
            .text(left: "药物配比", right: Text("1 ：1")),
            .text(left: "治疗部位", right: Text("颈椎")),
            .arrow(left: "开始服药时间", right: Text("2021-01-15 09:30")),
        ]
    }
    
    func getBehavior() -> [RowModel] {
        return [
            .arrow(left: "名称", right: Text("体重管理")),
            .text(left: "说明", right: Text("请参考以下标准合理控制体重男性标准体重=身高(cm)-105=标准体重(kg)女性:身高(cm)-100=标准体重(kg)实测体重与标准体重正负10%以内的范围属于正常；与标准体重正负10%-20%者称为体重过重或过轻；超过标准体重正负 20%以上为肥胖或体重不足。")),
            .text(left: "推送频次", right: Text("3次")),
            .arrow(left: "开始推送时间", right: Text("2021-01-15 09:30")),
        ]
    }
}

extension EMREditDiagnosisPlanViewModel {
    enum RowModel {
        case title(title: String, isBig: Bool, top: CGFloat, bottom: CGFloat)
        case arrow(left: String, right: Text)
        case text(left: String, right: Text)
        case space(height: CGFloat, color: UIColor)
        case sep
        case add
        case desc(String)
        case bottom(Text)
    }
}
