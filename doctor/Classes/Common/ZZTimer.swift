//
//  ZZTimer.swift
//  healthcare_doctor
//
//  Created by 李向洲 on 2020/7/10.
//  Copyright © 2020 LXZ. All rights reserved.
//

import Foundation

class ZZTimer {
    var interval: TimeInterval
    var actionClosure: () -> Void
    
    init(interval: TimeInterval = 5, actionClosure: @escaping () -> Void) {
        self.interval = interval
        self.actionClosure = actionClosure
    }
    
    var timer: Timer?
    
    func start(_ instant: Bool = true) {
        if instant {
            actionClosure()
        }
        stop()
        timer = Timer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func timerAction() {
        actionClosure()
    }
    
    func keepTimer() {
        if timer == nil {
            start()
        }
    }
}
