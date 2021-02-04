//
//  NetworkConfig.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/30.
//  Copyright © 2019 sphr. All rights reserved.
//

import Foundation

let _initialContext = Context.develop

var context = _initialContext

var APP_SERVE_URL: URL {
    return URL(string: context.baseURL)!
}

enum Context: Equatable {
    case release
    case develop
    case test
    case demo
    case other(String)
}

extension Context {
    var baseURL: String {
        switch self {
        case .release:
            return "http://www.lightheart.com.cn/lightheart-gateway-service"
        case .test:
            return "http://bj.lightheart.com.cn/healthcare-test"
        case .develop:
            return "http://bj.lightheart.com.cn/healthcare-dev"
        case .demo:
            return "http://service.lightheart.com.cn"
        case let .other(url):
            return url
        }
    }
}

extension Context {
    var intValue: Int {
        switch self {
        case .release: return 1
        case .develop: return 2
        case .test: return 3
        case .demo: return 4
        case .other: return 5
        }
    }
    
    static func from(value: Int) -> Self {
        switch value {
        case 1: return .release
        case 2: return .develop
        case 3: return .test
        case 4: return .demo
        default: return .other("http://172.21.20.247:3301")
        }
    }
}

