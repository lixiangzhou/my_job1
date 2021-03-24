//
//  EMRAddReuseListViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//

import UIKit
import ReactiveSwift

class EMRAddReuseListViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[Int]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.25) {
            
            var models = [Int]()
            for i in 0..<20 {
                models.append(i)
            }
            
            self.dataSourceProperty.value = models
        }
    }
}
