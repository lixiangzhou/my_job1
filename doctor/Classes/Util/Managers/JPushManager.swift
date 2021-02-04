//
//  JPushManager.swift
//  healthcare_doctor
//
//  Created by 李向洲 on 2020/10/14.
//  Copyright © 2020 LXZ. All rights reserved.
//

import Foundation

class JPushManager: NSObject {
    static let shared = JPushManager()
    
    private override init() { }
    
    func setup(with options: [UIApplication.LaunchOptionsKey: Any]?) {
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue) |  Int(JPAuthorizationOptions.sound.rawValue) |  Int(JPAuthorizationOptions.badge.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        let channel = context == .release ? "Publish Channel" : "Dev Channel"
        let apsForProduction = context == .release
        //6e374945e4b959562517e9cd
        JPUSHService.setup(withOption: options, appKey: "27ebab34ca5f2c6057fdceec", channel:channel , apsForProduction: apsForProduction)
    }
    
    func login() {
//        if let mobile = doctorInfoProperty.value?.mobile {
//            JPUSHService.setAlias(mobile + "_2", completion: { (code, alias, req) in
//                print("JPUSH setAlias completion", code, alias ?? "", req)
//            }, seq: 0)
//        }
    }
    
    func logout() {
        JPUSHService.deleteAlias({ (code, alias, req) in
            print("JPUSH deleteAlias completion", code, alias ?? "", req)
        }, seq: 0)
    }
}

/// MARK: -JPUSHRegisterDelegate
extension JPushManager: JPUSHRegisterDelegate {
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]!) {
        print(#function, status, info as Any)
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        print(#function)
        
        if notification.request.trigger is UNPushNotificationTrigger {
            // 从通知界面直接进入应用
        } else {
            // 从通知设置界面进入应用
        }
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        print(#function)
        
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(notification.request.content.userInfo)
        }
        completionHandler(Int(JPAuthorizationOptions.alert.rawValue))
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        print(#function)
        
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(response.notification.request.content.userInfo)
        }
        completionHandler();
    }
    
}
