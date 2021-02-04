//
//  ZZHud.swift
//  ZZLib
//
//  Created by lixiangzhou on 2017/9/5.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

// MARK: - Custom
public extension ZZHud {
    
    /// 显示文本信息
    ///
    /// - Parameters:
    ///   - message: 文本信息
    ///   - font: 文本字体
    ///   - color: 文本颜色
    ///   - backgroundColor: 背景色
    ///   - cornerRadius: 圆角
    ///   - showDuration: 显示时间
    ///   - hudAlpha: hud alpha 值
    ///   - contentInset： hud内容距离四边的距离
    ///   - position: 显示位置
    ///   - offsetY: 在显示位置的基础上偏移的距离
    ///   - toView: 文本信息要显示到的View
    func show(message: String,
              font: UIFont = UIFont.systemFont(ofSize: 14),
              color: UIColor = UIColor.white,
              backgroundColor: UIColor,
              cornerRadius: CGFloat,
              showDuration: TimeInterval,
              hudAlpha: CGFloat = 1,
              contentInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
              position: ZZHudPosition = .center,
              offsetY: CGFloat = 0,
              toView: UIView) {
        let msgLabel = hudLabel(message: message, font: font, color: color)
        show(toast: msgLabel, toView: toView, hudCornerRadius: cornerRadius, hudBackgroundColor: backgroundColor, hudAlpha: hudAlpha, contentInset: contentInset, position: position, offsetY: offsetY, showDuration: showDuration)
    }
    
    /// 显示文本信息
    ///
    /// - Parameters:
    ///   - message: 文本信息
    ///   - font: 文本字体
    ///   - color: 文本颜色
    ///   - backgroundColor: 背景色
    ///   - cornerRadius: 圆角
    ///   - showDuration: 显示时间
    ///   - hudAlpha: hud alpha 值
    ///   - contentInset： hud内容距离四边的距离
    ///   - position: 显示位置
    ///   - offsetY: 在显示位置的基础上偏移的距离
    ///   - toView: 文本信息要显示到的View
    static func show(message: String,
                     font: UIFont = UIFont.systemFont(ofSize: 14),
                     color: UIColor = UIColor.white,
                     backgroundColor: UIColor,
                     cornerRadius: CGFloat,
                     showDuration: TimeInterval,
                     hudAlpha: CGFloat = 1,
                     contentInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                     position: ZZHudPosition = .center,
                     offsetY: CGFloat = 0,
                     toView: UIView) {
        ZZHud.shared.show(message: message, font: font, color: color, backgroundColor: backgroundColor, cornerRadius: cornerRadius, showDuration: showDuration, hudAlpha: hudAlpha, contentInset: contentInset, position: position, offsetY: offsetY, toView: toView)
    }
    
    
    /// 显示图片
    ///
    /// - Parameters:
    ///   - icon: 图片
    ///   - size: 图片大小
    ///   - cornerRadius: 图片圆角
    ///   - toView: 图片要添加到的View
    func show(icon: UIImage,
              size: CGSize = CGSize.zero,
              cornerRadius: CGFloat = 0,
              toView: UIView) {
        let iconView = hudImageView(icon: icon, size: size, cornerRadius: cornerRadius)
        show(toast: iconView, toView: toView, hudCornerRadius: 5, hudBackgroundColor: UIColor.white, hudAlpha: 1)
    }

    /// 显示图片
    ///
    /// - Parameters:
    ///   - icon: 图片
    ///   - size: 图片大小
    ///   - cornerRadius: 图片圆角
    ///   - toView: 图片要添加到的View
    static func show(icon: UIImage,
              size: CGSize = CGSize.zero,
              cornerRadius: CGFloat = 0,
              toView: UIView) {
        ZZHud.shared.show(icon: icon, size: size, cornerRadius: cornerRadius, toView: toView)
    }
    
    /// 显示图片和文本，图片在上，文本在下
    ///
    /// - Parameters:
    ///   - message: 文本信息
    ///   - font: 文本字体
    ///   - color: 文本颜色
    ///   - icon: 图片
    ///   - imageSize: 图片大小
    ///   - cornerRadius: 图片圆角
    ///   - padding: 图片和文本的间距
    ///   - toView: 图片要添加到的View
    func show(message: String,
              font: UIFont = UIFont.systemFont(ofSize: 14),
              color: UIColor = UIColor.black,
              icon: UIImage,
              imageSize: CGSize = CGSize.zero,
              cornerRadius: CGFloat = 0,
              padding: CGFloat = 10,
              toView: UIView) {
        let iconView = hudImageView(icon: icon, size: imageSize, cornerRadius: cornerRadius)
        let msgLabel = hudLabel(message: message, font: font, color: color)
        
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: max(iconView.bounds.width, msgLabel.bounds.width), height: iconView.bounds.height + msgLabel.bounds.height + padding))
        contentView.addSubview(iconView)
        contentView.addSubview(msgLabel)
        
        iconView.frame.origin.x = (contentView.frame.width - iconView.frame.width) * 0.5
        
        msgLabel.frame.origin.x = (contentView.frame.width - msgLabel.frame.width) * 0.5
        msgLabel.frame.origin.y = iconView.frame.maxY + padding
        
        show(toast: contentView, toView: toView, hudBackgroundColor: UIColor.white)
    }
    
    /// 显示图片和文本，图片在上，文本在下
    ///
    /// - Parameters:
    ///   - message: 文本信息
    ///   - font: 文本字体
    ///   - color: 文本颜色
    ///   - icon: 图片
    ///   - imageSize: 图片大小
    ///   - cornerRadius: 图片圆角
    ///   - padding: 图片和文本的间距
    ///   - toView: 图片要添加到的View
    static func show(message: String,
              font: UIFont = UIFont.systemFont(ofSize: 14),
              color: UIColor = UIColor.black,
              icon: UIImage,
              imageSize: CGSize = CGSize.zero,
              cornerRadius: CGFloat = 0,
              padding: CGFloat = 10,
              toView: UIView) {
        ZZHud.shared.show(message: message, font: font, color: color, icon: icon, imageSize: imageSize, cornerRadius: cornerRadius, padding: padding, toView: toView)
    }
    
    /// 显示UIActivityIndicatorViewStyle加载，，隐藏时调用 hideLoading
    ///
    /// - Parameters:
    ///   - style: UIActivityIndicatorViewStyle加载样式
    ///   - toView: 加载视图要添加到的View
    func showActivity(style: UIActivityIndicatorView.Style = .gray, toView: UIView) {
        let activityView = UIActivityIndicatorView(style: style)
        activityView.startAnimating()
        show(loading: activityView, toView: toView, hudBackgroundColor: UIColor.clear)
    }
    
    /// 显示UIActivityIndicatorViewStyle加载，隐藏时调用 hideLoading
    ///
    /// - Parameters:
    ///   - style: UIActivityIndicatorViewStyle加载样式
    ///   - toView: 加载视图要添加到的View
    static func showActivity(style: UIActivityIndicatorView.Style = .gray, toView: UIView) {
        ZZHud.shared.showActivity(style: style, toView: toView)
    }
}

// MARK: - HUD Key Model

/// Hud显示位置
///
/// - top: 最顶部
/// - center: 中间
/// - bottom: 最底部
public enum ZZHudPosition {
    case top
    case center
    case bottom
}

public class ZZHUDView: UIView {
    enum HUDType {
        case toast
        case loading
    }
    var hudType = HUDType.toast
}

/// Toast & LoadingHud
public class ZZHud {
    public static let shared = ZZHud()
    
    /// Toast 是否可以重复叠加，如果为 false，会移除原来的 toast
    public var canToastOverlay = true
    
    /// toast 文本的最大距离
    public var stringMaxWidth = UIScreen.main.bounds.width - 140
    
    private init() { }
    
    /// 默认的显示动画
    public var defaultShowAnimation: CAAnimation = {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.duration = 0.25
        anim.fromValue = 0
        anim.toValue = 1
        anim.isRemovedOnCompletion = false
        anim.fillMode = CAMediaTimingFillMode.forwards
        return anim
    }()
    
    /// 默认的隐藏动画
    public var defaultHideAnimation: CAAnimation = {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.duration = 0.25
        anim.fromValue = 1
        anim.toValue = 0
        anim.isRemovedOnCompletion = false
        anim.fillMode = CAMediaTimingFillMode.forwards
        return anim
    }()
}

// MARK: - Core Method
public extension ZZHud {
    
    /// 显示toast
    ///
    /// - Parameters:
    ///   - hud: toast视图
    ///   - toView: toast视图所在的View
    ///   - hudCornerRadius: toast视图的cornerRadius
    ///   - hudBackgroundColor: toast视图的backgroundColor
    ///   - hudAlpha: toast视图的alpha
    ///   - contentInset: toast视图所在的View的contentInset
    ///   - position: toast视图显示的位置
    ///   - offsetY: toast视图显示的位置的垂直偏移量
    ///   - showDuration: toast视图显示时长
    ///   - showAnimation: toast视图显示动画
    ///   - hideAnimation: toast视图隐藏动画
    func show(toast hud: UIView,
              toView: UIView,
              hudCornerRadius: CGFloat = 0,
              hudBackgroundColor: UIColor = .black,
              hudAlpha: CGFloat = 1,
              contentInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
              position: ZZHudPosition = .center,
              offsetY: CGFloat = 0,
              showDuration: TimeInterval = 2,
              showAnimation: (() -> CAAnimation)? = nil,
              hideAnimation: (() -> CAAnimation)? = nil) {
        
        var showAnim: CAAnimation? = showAnimation?() ?? defaultShowAnimation
        let hideAnim = hideAnimation?() ?? defaultHideAnimation
        
        if !toastCanOverlay(toView) {
            if toView.zz_toastCount > 0 { // 已经存在 toast 移除原来的 toast
                removeToasts(in: toView)
                showAnim = nil
            }
            toView.zz_toastCount += 1
        }
        
        let hudView = wrap(hud,
                           cornerRadius: hudCornerRadius,
                           backgroundColor: hudBackgroundColor,
                           alpha: hudAlpha,
                           contentInset: contentInset)
        hudView.hudType = .toast
        
        add(hud: hudView, toView: toView, position: position, offsetY: offsetY)
        
        toastAnimate(hud: hudView, showDuration: showDuration, showAnimation: showAnim, hideAnimation: hideAnim)
    }
    
    /// 显示loading
    ///
    /// - Parameters:
    ///   - hud: loading视图
    ///   - toView: loading视图所在的View
    ///   - hudCornerRadius: loading视图的cornerRadius
    ///   - hudBackgroundColor: loading视图的backgroundColor
    ///   - hudAlpha: loading视图的alpha
    ///   - contentInset: loading视图的contentInset
    ///   - position: loading视图显示的位置
    ///   - offsetY: loading视图显示的位置的垂直偏移量
    ///   - animation: loading视图显示的动画
    func show(loading hud: UIView,
              toView: UIView,
              hudCornerRadius: CGFloat = 0,
              hudBackgroundColor: UIColor = .black,
              hudAlpha: CGFloat = 1,
              contentInset: UIEdgeInsets = .zero,
              position: ZZHudPosition = .center,
              offsetY: CGFloat = 0,
              animation: (() -> CAAnimation)? = nil) {
        if toView.zz_loadingCount == 0 {
            let hudView = wrap(hud,
                               cornerRadius: hudCornerRadius,
                               backgroundColor: hudBackgroundColor,
                               alpha: hudAlpha,
                               contentInset: contentInset)
            
            hudView.hudType = .loading
            add(hud: hudView, toView: toView, position: position, offsetY: offsetY)
            
            let showAnim = animation?() ?? defaultShowAnimation
            showLoading(hud: hudView, showAnimation: showAnim)
        }
        toView.zz_loadingCount += 1
    }
    
    /// 显示loading
    ///
    /// - Parameters:
    ///   - hud: loading视图
    ///   - toView: loading视图所在的View
    ///   - hudCornerRadius: loading视图的cornerRadius
    ///   - hudBackgroundColor: loading视图的backgroundColor
    ///   - hudAlpha: loading视图的alpha
    ///   - contentInset: loading视图的contentInset
    ///   - position: loading视图显示的位置
    ///   - offsetY: loading视图显示的位置的垂直偏移量
    static func show(loading hud: UIView,
                     toView: UIView,
                     hudCornerRadius: CGFloat = 0,
                     hudBackgroundColor: UIColor = .black,
                     hudAlpha: CGFloat = 1,
                     contentInset: UIEdgeInsets = .zero,
                     position: ZZHudPosition = .center,
                     offsetY: CGFloat = 0,
                     animation: (() -> CAAnimation)? = nil) {
        ZZHud.shared.show(loading: hud,
                                 toView: toView,
                                 hudCornerRadius: hudCornerRadius,
                                 hudBackgroundColor: hudBackgroundColor,
                                 hudAlpha: hudAlpha,
                                 contentInset: contentInset,
                                 position: position,
                                 offsetY: offsetY,
                                 animation: animation)
    }
    
    /// 隐藏view的loading
    ///
    /// - Parameters:
    ///   - view: loading视图所在的View
    ///   - animation: loading视图显示的动画
    ///   - loadingId: loading视图的id
    func hideLoading(for view: UIView,
                     animation: (() -> CAAnimation)? = nil) {
        var count = view.zz_loadingCount
        if count > 0 {
            count -= 1
            
            if count == 0 {
                for sub in view.subviews where sub is ZZHUDView && (sub as! ZZHUDView).hudType == .loading {
                    sub.hideLoading(animation: animation)
                }
            }
            view.zz_loadingCount = count
        }
    }
    
    /// 隐藏view的loading
    ///
    /// - Parameters:
    ///   - view: loading视图所在的View
    ///   - animation: loading视图显示的动画
    static func hideLoading(for view: UIView,
                            animation: (() -> CAAnimation)? = nil) {
        ZZHud.shared.hideLoading(for: view, animation: animation)
    }
}


// MARK: - Helper
public extension ZZHud {
    
    /// 显示toast 动画
    ///
    /// - Parameters:
    ///   - hud: toast视图
    ///   - showDuration:  toast视图显示时长
    ///   - showAnimation: toast视图显示动画
    ///   - hideAnimation: toast视图隐藏动画
    private func toastAnimate(hud: UIView,
                              showDuration: TimeInterval,
                              showAnimation: CAAnimation?,
                              hideAnimation: CAAnimation) {
        var duration = max(0, showDuration)
        
        if let showAnimation = showAnimation {
            duration += showAnimation.duration
            hud.layer.add(showAnimation, forKey: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: { [weak hud] in
            hud?.layer.add(hideAnimation, forKey: nil)
            hud?.perform(#selector(UIView.removeFromSuperview), with: nil, afterDelay: hideAnimation.duration, inModes: [RunLoop.Mode.common])
        })
    }
    
    
    /// 移除view上的toast
    /// - Parameter view: view
    private func removeToasts(in view: UIView) {
        for sub in view.subviews where sub is ZZHUDView && (sub as! ZZHUDView).hudType == .toast {
            sub.removeFromSuperview()
        }
        view.zz_toastCount = 0
    }
    
    /// 显示loading
    ///
    /// - Parameters:
    ///   - hud: loading视图
    ///   - showAnimation: toast视图显示动画
    private func showLoading(hud: UIView,
                             showAnimation: CAAnimation) {
        hud.layer.add(showAnimation, forKey: nil)
    }
    
    /// 把hud添加到视图上
    ///
    /// - Parameters:
    ///   - hud: hud
    ///   - toView: hud将添加到的视图
    ///   - position: hud在toView的位置
    ///   - offsetY: hud在toView位置的偏移量
    private func add(hud: UIView,
                     toView: UIView,
                     position: ZZHudPosition,
                     offsetY: CGFloat) {
        var hudFrame = hud.frame
        let toViewFrame = toView.bounds
        
        let hudX = (toViewFrame.width - hudFrame.width) * 0.5
        
        switch position {
        case .center:
            hudFrame.origin = CGPoint(x: hudX, y: (toViewFrame.height - hudFrame.height) * 0.5)
        case .top:
            hudFrame.origin = CGPoint(x: hudX, y: 0)
        case .bottom:
            hudFrame.origin = CGPoint(x: hudX, y: toViewFrame.height - hudFrame.height)
        }
        
        hudFrame.origin.y += offsetY
        hud.frame = hudFrame
        toView.addSubview(hud)
    }
    
    /// 把hud包装成ZZView
    ///
    /// - Parameter hud: 要包装的hud
    /// - Parameter cornerRadius: 包装好的hud的cornerRadius
    /// - Parameter backgroundColor: 包装好的hud的backgroundColor
    /// - Parameter alpha: 包装好的hud的alpha
    /// - Parameter contentInset: 要包装的hud的contentInset
    /// - Returns: 包装好的hud
    private func wrap(_ hud: UIView,
                      cornerRadius: CGFloat,
                      backgroundColor: UIColor,
                      alpha: CGFloat,
                      contentInset: UIEdgeInsets) -> ZZHUDView {
        let hudView = ZZHUDView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: contentInset.left + contentInset.right + hud.bounds.width,
                                           height: contentInset.top + contentInset.bottom + hud.bounds.height))
        
        hud.frame.origin.x = contentInset.left
        hud.frame.origin.y = contentInset.top
        
        hudView.layer.cornerRadius = min(hudView.bounds.width * 0.5, cornerRadius)
        hudView.backgroundColor = backgroundColor
        hudView.alpha = alpha
        
        hudView.addSubview(hud)
        return hudView
    }
    
    /// 快速创建hud要用到的Label
    ///
    /// - Parameters:
    ///   - message: 文本信息
    ///   - font: 文本字体
    ///   - color: 文本颜色
    /// - Returns: 创建好的Label
    private func hudLabel(message: String,
                          font: UIFont,
                          color: UIColor) -> UILabel {
        let hudLabel = UILabel()
        hudLabel.font = font
        hudLabel.textColor = color
        hudLabel.text = message
        hudLabel.numberOfLines = 0
        hudLabel.frame = (message as NSString).boundingRect(with: CGSize(width: stringMaxWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return hudLabel
    }
    
    /// 快速创建hud要用到的ImageView
    ///
    /// - Parameters:
    ///   - icon: 图片
    ///   - size: 图片大小
    ///   - cornerRadius: 图片圆角
    /// - Returns: 创建好的ImageView
    private func hudImageView(icon: UIImage,
                              size: CGSize,
                              cornerRadius: CGFloat) -> UIImageView {
        let hudImageView = UIImageView()
        if size == .zero {
            hudImageView.frame.size = icon.size
        } else {
            hudImageView.frame.size = size
        }
        
        hudImageView.image = icon
        
        let r = min(size.width, size.height) * 0.5
        var radius = max(0, cornerRadius)
        radius = min(r, radius)
        hudImageView.layer.cornerRadius = radius
        return hudImageView
    }
    
    private func toastCanOverlay(_ view: UIView) -> Bool {
        view.canToastOverlay ?? ZZHud.shared.canToastOverlay
    }
}

// MARK: - ZZHud
public extension UIView {
    /// 隐藏
    ///
    /// - Parameter animation: 隐藏loading动画，如果为nil，使用默认的隐藏动画
    func hideLoading(animation: (() -> CAAnimation)? = nil) {
        let hideAnimation = animation?() ?? ZZHud.shared.defaultHideAnimation
        layer.add(hideAnimation, forKey: nil)
        perform(#selector(UIView.removeFromSuperview), with: nil, afterDelay: hideAnimation.duration, inModes: [RunLoop.Mode.common])
    }
}


public extension UIView {
    
    /// 后一个toast是否可以叠加到前一个toast
    var canToastOverlay: Bool? {
        set { objc_setAssociatedObject(self, &canToastOverlayKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
        get { objc_getAssociatedObject(self, &canToastOverlayKey) as? Bool }
    }
}

private var toastCountKey = "toastCountKey"
private var loadingCountKey = "loadingCountKey"
private var canToastOverlayKey = "canToastOverlayKey"

extension UIView {
    fileprivate var zz_toastCount: Int {
        set { objc_setAssociatedObject(self, &toastCountKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
        get { objc_getAssociatedObject(self, &toastCountKey).flatMap { $0 as? Int } ?? 0 }
    }
    
    fileprivate var zz_loadingCount: Int {
        set { objc_setAssociatedObject(self, &loadingCountKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
        get { objc_getAssociatedObject(self, &loadingCountKey).flatMap { $0 as? Int } ?? 0 }
    }
}
