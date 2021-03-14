//
//  ConsultListViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//

import UIKit
import ReactiveSwift

class ConsultListViewModel: BaseViewModel {

    let dataSourceProperty = MutableProperty<[Int]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.5) {
            self.dataSourceProperty.value = [1, 2, 3, 4, 5, 6]
        }
    }
}
