//
//  TodoMsgSearchViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//

import Foundation
import ReactiveSwift

class TodoMsgSearchViewModel: BaseViewModel {

    let dataSourceProperty = MutableProperty<[Int]>([])
    
    func getData() {
        DispatchQueue.main.zz_after(0.3) {
            self.dataSourceProperty.value = [1, 2, 3, 4, 5, 6]
        }
    }
}
