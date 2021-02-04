//
//  BasicExtension.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/6/18.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

func beginIgnoreInteration() {
    UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
}

func endIgnoreInteration() {
    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
}

func ignoreEvents(_ action: () -> Void) {
    beginIgnoreInteration()
    action()
    endIgnoreInteration()
}

extension TimeInterval {
    func toTime(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return date.zz_string(withDateFormat: format)
    }
    
    var date: Date {
        return Date(timeIntervalSince1970: self / 1000)
    }
}


func getAge(_ birth: TimeInterval?) -> Int? {
    if let birth = birth {
        let birthDate = Date(timeIntervalSince1970: birth / 1000)
        let date = Date()
        
        var age = date.zz_year - birthDate.zz_year
        if (birthDate.zz_month > date.zz_month) || (birthDate.zz_month == date.zz_month && birthDate.zz_day > date.zz_day) {
            age -= 1
        }
        return age
    } else {
        return nil
    }
}

extension Collection where Iterator.Element: ModelProtocol {
    
    func tojson() -> [[String: Any]?] {
        return self.map{ $0.toJSON() }
    }
    
    func tojsonString(prettyPrint: Bool = false) -> String? {
        
        let anyArray = self.toJSON()
        if JSONSerialization.isValidJSONObject(anyArray) {
            do {
                let jsonData: Data
                if prettyPrint {
                    jsonData = try JSONSerialization.data(withJSONObject: anyArray, options: [.prettyPrinted])
                } else {
                    jsonData = try JSONSerialization.data(withJSONObject: anyArray, options: [])
                }
                return String(data: jsonData, encoding: .utf8)
            } catch {
                
            }
        } else {
            
        }
        return nil
    }
}

protocol ScaledNumber {
    var scaledHeight: CGFloat { get }
    var scaledWidth: CGFloat { get }
}

extension Double: ScaledNumber {
    var scaledHeight: CGFloat {
        CGFloat(self).scaledHeight
    }
    
    var scaledWidth: CGFloat {
        CGFloat(self).scaledWidth
    }
}

extension CGFloat: ScaledNumber {
    var scaledHeight: CGFloat {
        self / CGFloat(667.0) * UIScreen.zz_height
    }
    
    var scaledWidth: CGFloat {
        self / CGFloat(375.0) * UIScreen.zz_width
    }
}
