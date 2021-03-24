//
//  PatientManagerListViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/23.
//

import UIKit
import ReactiveSwift

class PatientManagerListViewModel: BasePageViewModel {
    let dataSourceProperty = MutableProperty<[PatientManagerListModel]>([])
    
    var title = ""
    var count = 0
    
    override func getData() {
        DispatchQueue.main.zz_after(0.25) {
            
            let attr1 = "就诊状态：".attribute(font: .size(14), color: .c3).mutable
            attr1.append("待门诊复诊".attribute(font: .boldSize(14), color: .cFF5050))
            
            let attr2 = "6病室8床".attribute(font: .size(12), color: .c6)
            let attr3 = "入院时间：2021-01-12".attribute(font: .size(12), color: .c6)
            
            var models = [PatientManagerListModel]()
            for _ in 0..<20 {
                models.append(PatientManagerListModel(timeString: "患者创建时间：2021-01-15 09:30", stateAttributeString: attr1, topBottomAttributeStrings: [attr2, attr3], midStrings: ["医生：李大大", "护士：董笑笑", "病历号：4731934174", "诊断：肩周炎"], actionModels: ["治疗", "完善病历"]))
            }
            
            self.dataSourceProperty.value = models
        }
    }
}

extension PatientManagerListViewModel {
    
    enum Weekday: String, CaseIterable {
        case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
        static func random<G: RandomNumberGenerator>(using generator: inout G) -> Weekday {
             return Weekday.allCases.randomElement(using: &generator)!
        }
    
        static func random() -> Weekday {
            var g = SystemRandomNumberGenerator()
            return Weekday.random(using: &g)
        }
    }
    
    var attributeTitle: NSAttributedString {
//        title = Weekday.random().rawValue
        count = Int.random(in: 0...20)
        
        let attr = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.size(14)])
        if count > 0 {
            attr.append(NSAttributedString(string: "(\(count))", attributes: [NSAttributedString.Key.font: UIFont.size(12)]))
        }
        return attr
    }
    
    var selectAttributeTitle: NSAttributedString {
        let attr = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSize(14)])
        if count > 0 {
            attr.append(NSAttributedString(string: "\(count)", attributes: [NSAttributedString.Key.font: UIFont.boldSize(12)]))
        }
        return attr
    }
}

