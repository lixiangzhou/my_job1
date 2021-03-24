//
//  EMRListViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//

import UIKit
import ReactiveSwift

class EMRListViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[Int]>([])
    
    override func getData() {
        DispatchQueue.main.zz_after(0.25) {
            
            var models = [Int]()
            for _ in 0..<20 {
                models.append(i)
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

