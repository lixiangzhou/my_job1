//
//  ZZRefreshHeader.swift
//  ZZRefresh
//
//  Created by lixiangzhou on 16/10/27.
//  Copyright © 2016年 lixiangzhou. All rights reserved.
//

import UIKit

open class ZZRefreshHeader: ZZRefreshView {
    
    var height: CGFloat = 50
    
    var refreshDuration: TimeInterval = 0.25

    open override var state: ZZRefreshState {
        didSet {
            switch state {
            case .normal:
                UIView.animate(withDuration: refreshDuration, animations: {
                    self.scrollView.contentInset = self.originInset
                })
            case .refreshing:
                UIView.animate(withDuration: refreshDuration, animations: {
                    self.scrollView.zz_insetTop = self.height
                })
            default: break
            }
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let offsetY = scrollView.contentOffset.y + scrollView.zz_insetTop
        let width = scrollView.bounds.width
        
        let headerHeight = self.height
        
        // 处理 style
        switch style {
        case .bottom:
            frame = CGRect(x: 0, y: -headerHeight, width: width, height: headerHeight)
        case .scaleToFill:
            var height: CGFloat = min(headerHeight, abs(min(offsetY, 0)))
            let y = min(offsetY, 0);
            height = offsetY < 0 ? abs(offsetY) : 0
            frame = CGRect(x: 0, y: y, width: width, height: height)
        case .top:
            let y = offsetY < -headerHeight ? offsetY : -headerHeight
            frame = CGRect(x: 0, y: y, width: width, height: headerHeight)
        }
        
        // 处理状态变化
        if offsetY > 0 || state == .refreshing {
            return
        }
        
//        print(offsetY)
        
        if scrollView.isDragging {
            if (state == .normal || state == .releaseRefreshing) && -offsetY < headerHeight {
                state = .willRefreshing
            } else if state == .willRefreshing && -offsetY >= headerHeight {
                state = .releaseRefreshing
            }
        } else if state == .willRefreshing {
            toNormalStatus()
        } else if state == .releaseRefreshing {
            state = .refreshing
        }
    }
    
    // 自定义刷新控件时重写此方法
    open override func setupUI() {  }
}
