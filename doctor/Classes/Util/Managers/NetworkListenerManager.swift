//
//  NetworkListenerManager.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/11/26.
//  Copyright © 2019 sphr. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire

let (networkReachabilitySignal, networkReachabilityObserver) = Signal<Bool, Never>.pipe()
let (requestStartSignal, requestStartObserver) = Signal<(), Never>.pipe()

struct NetworkListenerManager {
    static let shared = NetworkListenerManager()
    
    private init() {}
    
    let networkReachabilityManager = NetworkReachabilityManager.default!
    
    func startNetworkReachabilityToast() {
        networkReachabilityManager.startListening { (status) in
        
            switch status {
            case .notReachable, .unknown:
                networkReachabilityObserver.send(value: false)
            case .reachable:
                networkReachabilityObserver.send(value: true)
            }
        }
        
        networkReachabilitySignal.sample(on: requestStartSignal).skipRepeats().filter { !$0 }.observeValues { (_) in
            HUD.show(toast: "当前无网络连接", fromTop: true)
        }
    }
}
