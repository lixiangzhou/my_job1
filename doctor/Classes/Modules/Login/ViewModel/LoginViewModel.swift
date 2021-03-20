//
//  LoginViewModel.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/20.
//

import UIKit
import ReactiveSwift

class LoginViewModel: BaseViewModel {
    var timeInterval: TimeInterval = 0
    override init() {
        super.init()
        didEnterBackgroundNotificationSignal.observeValues { [weak self] (_) in
            guard let self = self else { return }
            self.timeInterval = self.count > 0 ? Date().timeIntervalSince1970 : 0
        }
        
        didBecomeActiveNotificationSignal.observeValues { [weak self] (_) in
            guard let self = self else { return }
            if self.timeInterval > 0 && self.count > 0 {
                self.timeInterval = Date().timeIntervalSince1970 - self.timeInterval
                self.count = max(self.count - Int(self.timeInterval), 0)
            } else {
                self.timeInterval = 0
            }
        }
    }
    
    var count = 60
    var timer: Timer?
    
    func getCode(mobile: String, completion: @escaping (Bool) -> Void) {
    }
    
    func login(key: String, pwd: String?, captcha: String?, actionView: UIView, completion: @escaping (Bool) -> Void) {
    }
    
    func getCodeAndUpdateUI(mobile: String, timeLabel: UILabel, codeBtn: UIButton, codeView: InputFieldView) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        getCode(mobile: mobile) { [weak self] isSuccess in
            UIApplication.shared.endIgnoringInteractionEvents()
            if isSuccess {
                self?.startCodeTimer(timeLabel: timeLabel, codeBtn: codeBtn, codeView: codeView)
            }
        }
    }
    
    func startCodeTimer(timeLabel: UILabel, codeBtn: UIButton, codeView: InputFieldView) {
        timeLabel.isHidden = false
        codeBtn.isHidden = true
        timeLabel.text = "60s"
        count = 60
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            guard let self = self else { timer.invalidate(); return }
            self.count -= 1
            if self.count < 0 {
                timeLabel.isHidden = true
                codeBtn.isHidden = false
                let newTitle = "重新发送验证码"
                let size = newTitle.zz_size(withLimitWidth: 200, fontSize: 14)
                codeBtn.setTitle(newTitle, for: .normal)
                codeBtn.setTitleColor(.c9, for: .normal)
                codeBtn.frame = CGRect(origin: .zero, size: size)
                codeView.rightViewSize = size;
                timer.invalidate()
            } else {
                timeLabel.text = String(format: "%2ds", self.count)
            }
        })
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        invalidateTimer()
    }
}
