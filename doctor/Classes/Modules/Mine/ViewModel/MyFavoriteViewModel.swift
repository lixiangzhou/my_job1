//
//  MyFavoriteViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/14.
//

import UIKit
import ReactiveSwift

class MyFavoriteViewModel: BaseViewModel {
    let dataSourceProperty = MutableProperty<[Int]>([Int]())
    
    let modeProperty = MutableProperty<Mode>(.normal)
    
    func getData() {
//        dataSourceProperty
        DispatchQueue.main.zz_after(0.5) { [weak self] in
            self?.dataSourceProperty.value = [1, 2, 3, 4, 5, 6, 7]
        }
    }
    
    func delete() {
        
    }
}

extension MyFavoriteViewModel {
    enum Mode {
        case edit
        case normal
    }
}
