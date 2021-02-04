//
//  ZZRefreshFooter.swift
//  ZZRefresh
//
//  Created by lixiangzhou on 16/10/27.
//  Copyright © 2016年 lixiangzhou. All rights reserved.
//

import UIKit

open class ZZRefreshFooter: ZZRefreshView {
    
    var height: CGFloat = 40
    
    var refreshDuration: TimeInterval = 0.25
    
    open override var state: ZZRefreshState {
        didSet {
            switch state {
            case .normal, .noMoreData:
                DispatchQueue.main.zz_after(0.75) {
                    UIView.animate(withDuration: self.refreshDuration, animations: {
                        self.scrollView.contentInset = self.originInset
                    })
                }
            case .refreshing:
                UIView.animate(withDuration: refreshDuration, animations: {
                    self.scrollView.zz_insetBottom = self.height
                })
            default: break
            }
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let offsetY = scrollView.contentOffset.y + scrollView.zz_insetBottom
        let width = scrollView.bounds.width
        
        // 控件上拉时离底部的距离
        var distance: CGFloat = 0
        if scrollView.frame.height > scrollView.contentSize.height {
            distance =  -offsetY
        } else {
            distance = scrollView.contentSize.height - scrollView.frame.height - offsetY
        }
        
        var y = max(scrollView.contentSize.height, scrollView.frame.height)
        
        var additionHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            additionHeight = scrollView.adjustedContentInset.bottom
        }
        
        let footerHeight = self.height + additionHeight
        
        var height: CGFloat = 0.0
        switch style {
        case .top:
            if notFull {  // 不满一屏幕的情况
                if state == .refreshing {
                    y = y - footerHeight //scrollView.contentSize.height
                } else {
                    y = scrollView.frame.height
                }
                height = footerHeight
            } else {
                height = footerHeight//min(abs(distance), footerHeight)
            }
            frame = CGRect(x: 0, y: y, width: width, height: height)
        case .bottom:
            if notFull {  // 不满一屏幕的情况
                if state == .refreshing {
                    y = y - footerHeight
                } else {
                    // 和满屏的情况一样
                    y += distance < -footerHeight ? -distance - footerHeight : 0
                }
                height = footerHeight//min(abs(distance), footerHeight)
            } else {
                y += distance < -footerHeight ? -distance - footerHeight : 0
                height = footerHeight//min(abs(distance), footerHeight)
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
        case .scaleToFill:
            if notFull, state == .refreshing {
                y = y - footerHeight
                height = footerHeight
            } else {
                height = abs(distance)
            }
            frame = CGRect(x: 0, y: y, width: width, height: height)
        }
        
//        print(offsetY, y)
        
        if state == .refreshing || distance > 0 {
            return
        }
        
        if scrollView.isDragging {
            if (state == .normal || state == .releaseRefreshing) && -distance < footerHeight {
                state = .willRefreshing
            } else if state == .willRefreshing && -distance > footerHeight {
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
    
    func endRefreshWithNoMoreData() {
        state = .noMoreData
    }
    
    // 屏幕的情况
    private var notFull: Bool {
        return scrollView.contentSize.height < scrollView.frame.height
    }
}
