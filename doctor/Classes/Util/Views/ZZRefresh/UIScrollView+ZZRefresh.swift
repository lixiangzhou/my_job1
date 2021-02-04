//
//  UIScrollView+ZZRefresh.swift
//  UIScrollView+ZZRefresh
//
//  Created by lixiangzhou on 16/10/26.
//  Copyright © 2016年 lixiangzhou. All rights reserved.
//


import UIKit

private var zzRefresh_HeaderKey = "zzRefresh_HeaderKey"
private var zzRefresh_FooterKey = "zzRefresh_FooterKey"

public extension UIScrollView {
    
    var zz_header: ZZRefreshHeader? {
        set {
            self.zz_header?.removeFromSuperview()
            objc_setAssociatedObject(self, &zzRefresh_HeaderKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            guard let header = newValue else {
                return
            }
            addSubview(header)
        }
        
        get {
            return objc_getAssociatedObject(self, &zzRefresh_HeaderKey) as? ZZRefreshHeader
        }
    }
    
    var zz_footer: ZZRefreshFooter? {
        set {
            self.zz_footer?.removeFromSuperview()
            objc_setAssociatedObject(self, &zzRefresh_FooterKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            guard let footer = newValue else {
                return
            }
            addSubview(footer)
        }
        get {
            return objc_getAssociatedObject(self, &zzRefresh_FooterKey) as? ZZRefreshFooter
        }
    }
}

extension UIScrollView {
    var zz_Inset: UIEdgeInsets {
        get {
            if #available(iOS 11, *) {
                return adjustedContentInset
            } else {
                return contentInset
            }
        }
    }
    
    var zz_insetTop: CGFloat {
        set {
            var inset = contentInset
            inset.top = newValue
            if #available(iOS 11, *) {
                inset.top = inset.top - (adjustedContentInset.top - contentInset.top)
            }
            contentInset = inset
        }
        get {
            zz_Inset.top
        }
    }
    
    var zz_insetBottom: CGFloat {
        set {
            var inset = contentInset
            inset.bottom = newValue
            if #available(iOS 11, *) {
                inset.bottom = inset.bottom - (adjustedContentInset.bottom - contentInset.bottom)
            }
            contentInset = inset
        }
        get {
            zz_Inset.bottom
        }
    }
}

