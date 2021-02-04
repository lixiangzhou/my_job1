//
//  BaseViewModel.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/28.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

class BaseViewModel {
    deinit {
        print("DEINIT => \(self)")
    }
}

let PageSize = 20
class BasePageViewModel: BaseViewModel {
    var current = 1
    var total = 0

    var hasMorePage: Bool {
        return current * PageSize < total
    }
    
    func getNewData() {
        current = 1
        getData()
    }
    
    func getMoreData() {
        current += 1
        getData()
    }
    
    func getData() {
    }
    
}
