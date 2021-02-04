//
//  UploadApi.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//

import Foundation
import Moya

enum FileType: String {
    case auth // 认证图片
    case avator // 头像
}

struct FileData {
    var data: Data
    var name: String
}

enum UploadApi {
    case upload(datas: [FileData], type: FileType)
}

extension UploadApi: TargetType {
    var path: String {
        switch self {
        case .upload:
            return "/lightheart-file-service/file/HWUploadImage"
        }
    }
    
    var task: Task {
        switch self {
        case let .upload(datas: datas, type: type):
            var formDatas = [MultipartFormData]()
            for file in datas {
                formDatas.append(MultipartFormData(provider: .data(file.data), name: "files", fileName: file.name, mimeType: "image/jpeg"))
            }
            let path = "\(2)_\(111)/\(type.rawValue)/\(Date().zz_string(withDateFormat: "yyyyMMdd"))"
            let params: [String: Any] = ["path": path, "contentType": "image/jpg"]
            return .uploadCompositeMultipart(formDatas, urlParameters: params)
        }
    }
    
    var method: Moya.Method {
        return .post
    }
}

func uploadPhotos(_ photos: [UIImage], targetSize: Int, maxWidth: CGFloat, maxHeight: CGFloat, type: FileType, actionView: UIView? = nil, autoShowLoading: Bool = true, completionInMain: Bool = true, completion: @escaping (FilesModel?) -> Void) {
    var values = [UIImage]()
    if autoShowLoading {
        HUD.showLoding()
    }
    DispatchQueue.global().async {
        // 1. 压缩图片
        for img in photos {
            if let resizeImage = UIImage(data: img.zz_resetToSize(targetSize, maxWidth: maxWidth, maxHeight: maxWidth)) {
                values.append(resizeImage)
            }
        }
        
        // 2. 上传图片
        var datas = [FileData]()
        for (idx, img) in values.enumerated() {
            datas.append(FileData(data: img.jpegData(compressionQuality: 1)!, name: "img\(idx).jpg"))
        }
        
        UploadApi.upload(datas: datas, type: type).response(FilesModel.self, actionView: actionView, autoShowLoading: false, autoShowError: false, provider: .customQueue) { (resp) in
            if completionInMain {
                executeInMain {
                    if autoShowLoading {
                        HUD.hideLoding()
                    }
                    HUD.showError(BoolString(resp), in: UIViewController.topController?.view)
                    completion(resp.result)
                }
            } else {
                completion(resp.result)
            }
        }
    }
}

struct FilesModel: ModelProtocol {
    var host = ""
    var result = [String]()
    
    var urls: [String] {
        var rs = [String]()
        for item in result {
            rs.append("\(host)/\(item)")
        }
        return rs
    }
}

//extension String {
//    /// 添加 host
//    var hostedUrlString: String {
//        if hasPrefix("http") {
//            return self
//        }
//        return CommonManager.shared.config.filePrefix + "/" + self
//    }
//    
//    var hostedUrl: URL? {
//        URL(string: hostedUrlString)
//    }
//    
//    var scaledUrlString: String {
//        let suffix = "?x-oss-process=image/resize,p_40"
//        if hasPrefix("http") {
//            return self + suffix
//        }
//        return CommonManager.shared.config.filePrefix + "/" + self + suffix
//    }
//    
//    var scaledUrl: URL? {
//        URL(string: scaledUrlString)
//    }
//}

protocol PHAssetsProcessProtocol {
    func getImage(_ info: [UIImagePickerController.InfoKey : Any]) -> UIImage?
}

extension PHAssetsProcessProtocol {
    func getImage(_ info: [UIImagePickerController.InfoKey : Any]) -> UIImage? {
        var image: UIImage?
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options) { img, _ in
                image = img
            }
        }
        return image
    }
}

