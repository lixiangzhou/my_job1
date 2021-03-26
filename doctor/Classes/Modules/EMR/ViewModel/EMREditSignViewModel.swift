//
//  EMREditSignViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//

import UIKit
import ReactiveSwift

class EMREditSignViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[RowModel]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            self.dataSourceProperty.value = [
                .top,
                .field(left: self.getLeft(big: "I", small: "(度)"), text: Text()),
                .field(left: self.getLeft(big: "P", small: "(次/分)"), text: Text()),
                .field(left: self.getLeft(big: "R", small: "(次/分)"), text: Text()),
                .field(left: self.getLeft(big: "Bp", small: "(mmHg)"), text: Text()),
                .arrow(left: "疼痛评分", text: Text()),
                .bottom
            ]
        }
    }
    
    func getLeft(big: String, small: String) -> NSAttributedString {
        let attr = big.attribute(font: .size(14), color: .c3).mutable
        attr.append(small.attribute(font: .size(10), color: .c9))
        return attr
    }
}

extension EMREditSignViewModel {
    enum RowModel {
        case top
        case field(left: NSAttributedString, text: Text)
        case arrow(left: String, text: Text)
        case bottom
    }
}
