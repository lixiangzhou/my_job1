//
//  TZImagePickerControllerExtension.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/9/4.
//  Copyright © 2019 sphr. All rights reserved.
//

import Foundation
import TZImagePickerController

extension TZImagePickerController {
    @discardableResult
    static func commonPresent(from controller: UIViewController?, maxCount: Int, selectedModels:  NSMutableArray? = nil, delegate: TZImagePickerControllerDelegate?) -> TZImagePickerController {
        let vc = TZImagePickerController(maxImagesCount: maxCount, delegate: delegate)!
        vc.allowTakeVideo = false
        vc.allowPickingVideo = false
        vc.allowTakePicture = false
        vc.naviBgColor = .blue
        if let selectedModels = selectedModels {
            vc.selectedModels = selectedModels
        }
        vc.showSelectBtn = maxCount > 1
        
        vc.photoPreviewPageUIConfigBlock = { _, _, _, _, _, _, originalPhotoButton, originalPhotoLabel, _, _, _ in
            originalPhotoButton?.alpha = 0
        }
        vc.photoPickerPageUIConfigBlock = { _, _, previewButton, originalPhotoButton, originalPhotoLabel, _ , _, _, _ in
            previewButton?.isHidden = true
            originalPhotoButton?.isHidden = true
            originalPhotoLabel?.isHidden = true
        }
        controller?.present(vc)
        return vc
    }
    
    static func singleCropPresent(from controller: UIViewController?, crop: Bool = true, delegate: TZImagePickerControllerDelegate?) {
        let vc = commonPresent(from: controller, maxCount: 1, delegate: delegate)
        if crop {
            let wh = UIScreen.zz_width
            vc.allowCrop = crop
            vc.cropRect = CGRect(x: 0, y: (UIScreen.zz_height - wh) * 0.5, width: wh, height: wh)
        }
    }
}
