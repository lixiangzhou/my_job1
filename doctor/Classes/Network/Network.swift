//
//  Network.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/29.
//  Copyright © 2019 sphr. All rights reserved.
//

import Foundation
import Moya
import ReactiveSwift
import HandyJSON
import SwiftyJSON

let MainQueueProvider = MoyaProvider<MultiTarget>(plugins: getPlugin())
let CustomQueueProvider = MoyaProvider<MultiTarget>(callbackQueue: DispatchQueue(label: "lxz.custom"), plugins: getPlugin())

enum Provider {
    case mainQueue
    case customQueue
    
    var provider: MoyaProvider<MultiTarget> {
        switch self {
        case .mainQueue:
            return MainQueueProvider
        case .customQueue:
            return CustomQueueProvider
        }
    }
}

// MARK: -

private func getPlugin() -> [PluginType] {
    let activityPlugin = NetworkActivityPlugin { (type: NetworkActivityChangeType, target: TargetType) in
        executeInMain {
            switch type {
            case .began:
                AppActivityIndicatorConfig.requestCount.value += 1
            case .ended:
                AppActivityIndicatorConfig.requestCount.value -= 1
            }
        }
    }
    let senderPlugin = NetworkSimpleSenderPlugin()
    
    switch context {
    case .release:
        return [activityPlugin, senderPlugin]
    default:
//        return [activityPlugin, senderPlugin]
        let logPlugin = NetworkSimpleLoggerPlugin()
        return [logPlugin, activityPlugin, senderPlugin]
    }
}


// MARK: -
extension TargetType {
    var baseURL: URL { return APP_SERVE_URL }
    
    var sampleData: Data {
        return "sampleData".data(using: .utf8)!
    }
    
    var headers: [String : String]? {
        return defaultHeaders
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            return JSONEncoding.default
        case .get:
            return URLEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    var method: Moya.Method {
        return .post
    }
}

var defaultHeaders: [String: String] {
    let token = LoginManager.shared.tempToken ?? tokenProperty.value
    return ["client_type": "2",
            "os_type": "1",
            "token": token,
            "version": "1.0.0"]
}

extension TargetType {
    // MARK: -
    func rac_responseModel<Model: ModelProtocol>(_ type: Model.Type, actionView: UIView? = nil, autoShowLoading: Bool = false, autoShowError: Bool = true, provider: Provider = .mainQueue) -> SignalProducer<Model?, Never> {
        return rac_response(type, actionView: actionView, autoShowError: autoShowError, provider: provider).map { self.getModel(type, responseModel: $0) }
    }
    
    func rac_response<Model: ModelProtocol>(_ type: Model.Type, actionView: UIView? = nil, autoShowLoading: Bool = false, autoShowError: Bool = true, provider: Provider = .mainQueue) -> SignalProducer<ResponseModel<Model>, Never> {
        processActionViewBegin(actionView)
        showLoading(autoShowLoading)
        if !NetworkListenerManager.shared.networkReachabilityManager.isReachable {
            processActionViewEnd(actionView)
            hideLoding(autoShowLoading)
            HUD.show(toast: "当前网络不可用，请检查网络！", fromTop: true)
            return SignalProducer<ResponseModel<Model>, Never>(value: ResponseModel<Model>(.failure(MoyaError.underlying(NetworkError.noNet, nil))))
        }
        
        return SignalProducer<ResponseModel<Model>, Never> { observer, lifetime in
            let cancellableToken = provider.provider.request(MultiTarget(self)) { (result) in
                self.processActionViewEnd(actionView)
                self.hideLoding(autoShowLoading)
                switch result {
                case let .success(resp):
                    observer.send(value: self.getResponseModel(type, autoShowError, resp))
                    observer.sendCompleted()
                case let .failure(error):
                    observer.send(value: ResponseModel<Model>(.failure(error)))
                    observer.sendCompleted()
                }
            }
            
            lifetime.observeEnded {
                cancellableToken.cancel()
            }
        }
    }
    
    // MARK: -
    func responseModel<Model: ModelProtocol>(_ type: Model.Type, actionView: UIView? = nil, autoShowLoading: Bool = false, autoShowError: Bool = true, provider: Provider = .mainQueue, completion: ((Model?) -> Void)? = nil) {
        response(type, actionView: actionView, autoShowError: autoShowError, provider: provider) { completion?(self.getModel(type, responseModel: $0)) }
    }
    
    func response<Model: ModelProtocol>(_ type: Model.Type, actionView: UIView? = nil, autoShowLoading: Bool = false, autoShowError: Bool = true, provider: Provider = .mainQueue, completion: @escaping (ResponseModel<Model>) -> Void) {
        processActionViewBegin(actionView)
        showLoading(autoShowLoading)
        response(provider) { (result) in
            self.processActionViewEnd(actionView)
            self.hideLoding(autoShowLoading)
            switch result {
            case .success(let resp):
                completion(self.getResponseModel(type, autoShowError, resp))
            case .failure(let error):
                completion(ResponseModel<Model>(.failure(error)))
            }
        }
    }
    
    func response(_ provider: Provider = .mainQueue, _ completion: @escaping Moya.Completion) {
        if NetworkListenerManager.shared.networkReachabilityManager.isReachable {
            provider.provider.request(MultiTarget(self), completion: completion)
        } else {
            HUD.show(toast: "当前网络不可用，请检查网络！", fromTop: true)
            completion(Result<Moya.Response, MoyaError>.failure(.underlying(NetworkError.noNet, nil)))
        }
    }
    
    // MARK: - 内部辅助方法
    /// 获取后台返回的数据结构模型
    private func getResponseModel<Model: ModelProtocol>(_ type: Model.Type, _ autoShowError: Bool, _ resp: Response) -> ResponseModel<Model> {
        var responseModel = ResponseModel<Model>(.success(resp))
        let json = try? JSONSerialization.jsonObject(with: resp.data, options: .allowFragments) as? [String: Any]
        JSONDeserializer.update(object: &responseModel, from: json)
        
        if responseModel.isReLoginCode {
            if responseModel.code != "000008" {
                DispatchQueue.main.zz_after(0.25) {
                    HUD.show(toast: "该账号已在其他设备登录")
                }
            }
            tokenProperty.value = ""
        } else if autoShowError {
            HUD.showError(BoolString(responseModel), fromTop: true)
        }
        return responseModel
    }
    
    /// 通过 后台返回的数据结构模型 获取 结果模型
    private func getModel<Model: ModelProtocol>(_ type: Model.Type, responseModel: ResponseModel<Model>) -> Model? {
        switch responseModel.originResult {
        case .success:
            if responseModel.success {
                return responseModel.result
            } else {
                return nil
            }
        case .failure:
            return nil
        }
    }
    
    private func processActionViewBegin(_ actionView: UIView?) {
        executeInMain {
            actionView?.isUserInteractionEnabled = false
        }
    }
    
    private func processActionViewEnd(_ actionView: UIView?) {
        executeInMain {
            actionView?.isUserInteractionEnabled = true
        }
    }
    
    private func showLoading(_ autoShowLoading: Bool) {
        if autoShowLoading {
            HUD.showLoding()
        }
    }
    
    private func hideLoding(_ autoShowLoading: Bool) {
        if autoShowLoading {
            HUD.hideLoding()
        }
    }
}

/// 响应模型
struct ResponseModel<Content: ModelProtocol>: ModelProtocol  {
    // MARK: - 后台返回的数据结构
    
    var success: Bool = false
    var code: String = ""
    var message: String?
    var result: Content?
    /// 毫秒
    var timestamp: TimeInterval = 0
    
    /// 原始结果
    var originResult: Result<Moya.Response, MoyaError>
    
    var isNoNetError: Bool {
        switch originResult {
        case .success:
            return false
        case let .failure(error):
            switch error {
            case let .underlying(e, _):
                return e is NetworkError
            default:
                return false
            }
        }
    }
    
    init(_ result: Result<Moya.Response, MoyaError>) {
        self.originResult = result
    }
    
    init() {
        originResult = .failure(MoyaError.requestMapping("不要使用这个初始化方法"))
    }
}

struct PageModel<Item: ModelProtocol>: ModelProtocol {
    var total = 0
    var size = 0
    var current = 1
    
    var records = [Item]()
}

extension ResponseModel {
    var isReLoginCode: Bool {
        let set = Set<String>(arrayLiteral: "000002", "000008", "000007", "000006")
        return set.contains(code)
    }
}

extension String: ModelProtocol { }
extension Int: ModelProtocol { }
extension Bool: ModelProtocol { }
extension Double: ModelProtocol { }
extension Array: ModelProtocol { }
extension Dictionary: ModelProtocol { }
struct None: ModelProtocol { }

struct BoolString {
    var isSuccess: Bool
    var toast: String = ""
    var isNoNetError: Bool
}
extension BoolString {
    init<Content: ModelProtocol>(_ resp: ResponseModel<Content>) {
        self.toast = resp.message ?? ""
        self.isSuccess = resp.success
        self.isNoNetError = resp.isNoNetError
    }
}

enum NetworkError: Error {
    case noNet
}

// MARK: - Plugins
struct NetworkSimpleLoggerPlugin: PluginType {
    private let loggerId = "Loger"
    
    private let dateFormatter = DateFormatter()
    
    var filterPaths = Set<String>()
    
    private let requestSeparatorLine = "============================== Request =============================="
    private let responseSeparatorLine = "############################### Response #############################"
    private let printOverLine = "--------------------------------------------------------"
    
    init() {
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        filter(target) {
            print(requestSeparatorLine)
            outputItems(logNetworkRequest(request.request as URLRequest?))
            print(printOverLine)
        }
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        filter(target) {
            print(responseSeparatorLine)
            print(printOverLine)
            if case .success(let response) = result {
                outputItems(logNetworkResponse(response, data: response.data, target: target))
            } else {
                outputItems(logNetworkResponse(nil, data: nil, target: target))
            }
        }
    }
    
    private func outputItems(_ items: [String]) {
        items.forEach { reversedPrint(", ", terminator: "\n", items: $0) }
    }
    
    var date: String {
        return dateFormatter.string(from: Date())
    }
    
    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }
    
    func logNetworkRequest(_ request: URLRequest?) -> [String] {
        var output = [String]()
        var string = ""
        if let httpMethod = request?.httpMethod {
            string += "\(httpMethod) "
        }
        string += (request?.description ?? "(invalid request)")
        
        if let headers = request?.allHTTPHeaderFields {
            string += "\nRequest Headers:\n\(headers)"
        }
        
        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            string += "\nRequest Body:\n\(stringOutput)"
        }
        
        output += [format(loggerId, date: date, identifier: "Request", message: string)]
        
        
        return output
    }
    
    func logNetworkResponse(_ response: Moya.Response?, data: Data?, target: TargetType) -> [String] {
        guard let response = response else {
            return [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }
        let resultString = String(data: response.data , encoding: .utf8) ?? ""
        
        var result: Any = resultString
        if let data = resultString.data(using: .utf8), let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            result = json
        }
        
        return [format(loggerId, date: date, identifier: "Response", message: "Status Code: \(response.statusCode) \n\(response.request?.httpMethod ?? "NoMethod") \(response.request?.url?.absoluteString ?? "")\n\(result)")]
    }
    
    func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            print(item, separator: separator, terminator: terminator)
        }
    }
    
    func filter(_ target: TargetType, log: () -> Void) {
        if !filterPaths.contains(target.path) {
            log()
        }
    }
}

struct NetworkSimpleSenderPlugin: PluginType {
    public func willSend(_ request: RequestType, target: TargetType) {
        requestStartObserver.send(value: ())
    }
}


func executeInMain(_ task: @escaping () -> Void) {
    if Thread.isMainThread {
        task()
    } else {
        DispatchQueue.main.async {
            task()
        }
    }
}
