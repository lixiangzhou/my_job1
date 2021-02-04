//
//  AppSetupConfig.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/31.
//  Copyright © 2019 sphr. All rights reserved.
//

import Foundation

let didEnterBackgroundNotificationSignal = NotificationCenter.default.reactive.notifications(forName: UIApplication.didEnterBackgroundNotification)
let didBecomeActiveNotificationSignal = NotificationCenter.default.reactive.notifications(forName: UIApplication.didBecomeActiveNotification)

struct AppSetupConfig {
    static func config() {
        AppearanceConfig.config()
        AppActivityIndicatorConfig.config()
        IQKBManager.setup()
//        LoginManager.shared.setup()
//        NetworkListenerManager.shared.startNetworkReachabilityToast()
    }
}

