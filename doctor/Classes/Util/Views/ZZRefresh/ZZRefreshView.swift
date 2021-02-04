//
//  ZZRefreshView.swift
//  ZZRefresh
//
//  Created by lixiangzhou on 16/10/26.
//  Copyright © 2016年 lixiangzhou. All rights reserved.
//

import UIKit

open class ZZRefreshView: UIView {
    // MARK: - 公共属性
    public var style = ZZRefreshViewPositionStyle.bottom
    
    public var actionClosure: (() -> Void)?
    
    public func update(progress: CGFloat) { print(progress) }
    
    public var originInset = UIEdgeInsets.zero
        
    open var state: ZZRefreshState = ZZRefreshState.normal {
        didSet {
            if state == oldValue {
                return
            }
            
            switch state {
            case .normal:
                break;
            case .willRefreshing:
                break
            case .refreshing:
                if let target = target, let action = action {
                    _ = target.perform(action)
                }
                actionClosure?()
            case .releaseRefreshing:
                break
            case .noMoreData:
                break
            }
        }
    }
    
    // MARK: - 公共方法
    public func beginRefreshing() {
        state = .refreshing
    }
    
    public func endRefreshing() {
        toNormalStatus()
    }
    
    public func toNormalStatus() {
        DispatchQueue.main.zz_after(1) {
            self.state = .normal
        }
    }
    
    // MARK: - 生命周期方法
    public init(target: AnyObject? = nil, action: Selector? = nil, style: ZZRefreshViewPositionStyle = .bottom) {
        super.init(frame: CGRect.zero)
        self.target = target
        self.action = action
        self.style = style
        
        setupUI()
    }
    
    public init(style: ZZRefreshViewPositionStyle = .bottom, action: (() -> Void)?) {
        super.init(frame: CGRect.zero)
        self.style = style
        self.actionClosure = action
        
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    deinit {
        print("Refresh deinit")
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        if newSuperview == nil || newSuperview is UIScrollView == false {
            return
        }
        
        let scrollView = newSuperview as! UIScrollView
        
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        originInset = scrollView.zz_Inset
    }
    
    // 自定义刷新控件时重写此方法
    open func setupUI() {  }
    
    // MARK: - 辅助属性
    var scrollView: UIScrollView! {
        return superview as! UIScrollView
    }
    
    // MARK: - 私有属性
    private weak var target: AnyObject?
    private var action: Selector?
}
