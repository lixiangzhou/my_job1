//
//  ControllerExtension.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/28.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

extension UIViewController {
    func push(_ controller: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
}

// MARK: - 打开相册和相机（有相册和相机权限验证）
extension UIImagePickerController {
    /// 打开相册和相机（有相册和相机权限验证） 
    /// controller UIImagePickerControllerDelegate & UINavigationControllerDelegate
    static func showPicker<Delegate>(sourceType: UIImagePickerController.SourceType, from controller: UIViewController, delegate: Delegate, allowsEditing: Bool = true) where Delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        AppearanceConfig.setPhotoNavAppearance()
        if sourceType == .camera {  // 相机
            let auth = AVCaptureDevice.authorizationStatus(for: .video)
            switch auth {
            case .notDetermined, .restricted:
                attemptAccessVideo {
                    showCamera(sourceType: sourceType, delegate: delegate, from: controller, allowsEditing: allowsEditing)
                }
            case .authorized:
                showCamera(sourceType: sourceType, delegate: delegate, from: controller, allowsEditing: allowsEditing)
            case .denied:
                deniedProcess(for: .camera, from: controller)
            @unknown default:
                break
            }
        } else {    // 相册
            let auth = PHPhotoLibrary.authorizationStatus()
            switch auth {
            case .notDetermined, .restricted:
                attemptAccessPhoto {
                    showCamera(sourceType: sourceType, delegate: delegate, from: controller, allowsEditing: allowsEditing)
                }
            case .authorized:
                showCamera(sourceType: sourceType, delegate: delegate, from: controller, allowsEditing: allowsEditing)
            case .denied:
                deniedProcess(for: .camera, from: controller)
            @unknown default:
                break
            }
        }
    }
    
    private static func deniedProcess(for sourceType: UIImagePickerController.SourceType, from controller: UIViewController) {
        let msg = "访问\(sourceType == .camera ? "相机" : "相册")需要您的权限"
        UIAlertController.zz_show(fromController: controller, style: .alert, message: msg, actions: [UIAlertAction(title: "同意", style: .default, handler: { (_) in
            DispatchQueue.main.zz_after(0.2) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
        }), UIAlertAction(title: "取消", style: .cancel, handler: nil)], completion: nil)
    }
    
    private static func showCamera<Delegate>(sourceType: UIImagePickerController.SourceType, delegate: Delegate, from controller: UIViewController, allowsEditing: Bool = true) where Delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        let picker = UIImagePickerController()
        picker.delegate = delegate
        picker.sourceType = sourceType
        picker.allowsEditing = allowsEditing
        controller.present(picker)
    }
    
    private static func attemptAccessVideo(success:@escaping () -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            if granted {
                DispatchQueue.main.async {
                    success()
                }
            }
        }
    }
    
    private static func attemptAccessPhoto(success:@escaping () -> Void) {
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                    success()
                }
            }
        }
    }
    
    func dismiss() {
        dismiss(animated: true) {
            AppearanceConfig.setNavAppearance()
        }
    }
}

extension UIAlertController {
    /// 显示 sheet：拍照/从相册选择/取消 controller: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    static func showCameraPhotoSheet<Delegate>(from controller: UIViewController, delegate: Delegate, completion:((UIImagePickerController.SourceType) -> Void)? = nil) where Delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        let action1 = UIAlertAction(title: "拍照", style: .default) { (_) in
            UIImagePickerController.showPicker(sourceType: .camera, from: controller, delegate: delegate)
            completion?(.camera)
        }
        let action2 = UIAlertAction(title: "从相册选择", style: .default) { (_) in
            UIImagePickerController.showPicker(sourceType: .photoLibrary, from: controller, delegate: delegate)
            completion?(.photoLibrary)
        }
        let action3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        UIAlertController.zz_show(fromController: controller, style: .actionSheet, actions: [action1, action2, action3], completion: nil)
    }
    
    /// 显示 sheet：拍照/从相册选择/取消 controller: UIImagePickerControllerDelegate & UINavigationControllerDelegate & TZImagePickerControllerDelegate
    static func showCustomCameraPhotoSheet<Delegate>(from controller: UIViewController, delegate: Delegate, completion:((UIImagePickerController.SourceType) -> Void)? = nil) where Delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate & TZImagePickerControllerDelegate {
        let action1 = UIAlertAction(title: "拍照", style: .default) { (_) in
            UIImagePickerController.showPicker(sourceType: .camera, from: controller, delegate: delegate)
            completion?(.camera)
        }
        let action2 = UIAlertAction(title: "从相册选择", style: .default) { (_) in
            TZImagePickerController.singleCropPresent(from: controller, delegate: delegate)
        }
        let action3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        UIAlertController.zz_show(fromController: controller, style: .actionSheet, actions: [action1, action2, action3], completion: nil)
    }
}

extension LLSegmentViewController {
    @objc func loadSegmentedConfig() {
        layoutContentView()
        loadCtls()
        setUpSegmentStyle()
    }
    
    @objc func layoutContentView() {
        self.layoutInfo.segmentControlPositionType = .top(size: CGSize.init(width: UIScreen.main.bounds.width, height: 40), offset:0)
        self.relayoutSubViews()
    }
    
    @objc func loadCtls() {
    }
    
    @objc func setUpSegmentStyle() {
        let itemStyle = LLSegmentItemTitleViewStyle()
        itemStyle.selectedColor = UIColor.c3
        itemStyle.unSelectedColor = UIColor.c3
        itemStyle.selectedTitleScale = 1
        itemStyle.titleFont = UIFont.boldSize(14)
        itemStyle.itemWidth = UIScreen.main.bounds.width/CGFloat(ctls.count)//如果不指定是自动适配的
        //这里可以继续增加itemStyle的其他配置项... ...
        itemStyle.badgeValueLabelOffset = CGPoint(x: 12, y: -3)
        itemStyle.badgeValueLabelColor = .red
        
        segmentCtlView.backgroundColor = UIColor.white
        
        //        segmentCtlView.separatorLineShowEnabled = true //间隔线显示，默认不显示
        //还有其他配置项：颜色、宽度、上下的间隔...
        
        segmentCtlView.bottomSeparatorStyle = (1, UIColor.cf5f5f5) //分割线
        segmentCtlView.indicatorView.widthChangeStyle = .stationary(baseWidth: 32)//横杆宽度:有默认值
        segmentCtlView.indicatorView.centerYGradientStyle = .bottom(margin: 0)//横杆位置:有默认值
        segmentCtlView.indicatorView.backgroundColor = .c4167f3
        segmentCtlView.indicatorView.zz_setCorner(radius: 1, masksToBounds: true)
        segmentCtlView.indicatorView.shapeStyle = .custom //形状样式:有默认值
        
        var segmentedCtlStyle = LLSegmentedControlStyle()
        segmentedCtlStyle.segmentItemViewClass = LLSegmentItemTitleView.self  //ItemView和ItemViewStyle要统一对应
        segmentedCtlStyle.itemViewStyle = itemStyle
        segmentCtlView.reloadData(ctlViewStyle: segmentedCtlStyle)
    }
}
