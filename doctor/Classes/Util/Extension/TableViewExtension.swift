//
//  TableViewExtension.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/5/28.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit
import ReactiveSwift

extension UITableView {
    func set(dataSource: UITableViewDataSource? = nil, delegate: UITableViewDelegate? = nil, separatorStyle: UITableViewCell.SeparatorStyle = .none, rowHeight: CGFloat = UITableView.automaticDimension) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.separatorStyle = separatorStyle
        self.rowHeight = rowHeight
    }
    
    func register<T: UITableViewCell>(cell: T.Type) {
        register(cell, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

protocol IDView {
}

extension IDView {
    static var identifier: String { return "\(self)" }
}

extension UITableViewCell: IDView {}
extension UICollectionViewCell: IDView {}

extension UIScrollView {

}


extension UIScrollView {
    func beginRefresh() {
        mj_header?.beginRefreshing()
    }
    
    var headerRefreshClosure: (() -> Void)? {
        set {
            if newValue != nil {
                mj_header = RefreshHeader(refreshingBlock: newValue!)
            } else {
                mj_header = nil
            }
        }
        
        get {
            mj_header?.refreshingBlock
        }
    }
    
    var footerRefreshClosure: (() -> Void)? {
        set {
            if newValue != nil {
                mj_footer = RefreshFooter(refreshingBlock: newValue!)
            } else {
                mj_footer = nil
            }
        }
        
        get {
            mj_footer?.refreshingBlock
        }
    }
    
    func removeFooter() {
        mj_footer = nil
    }
    
    func endRefreshHeader() {
        mj_header?.endRefreshing()
    }
    
    func endRefreshFooter() {
        mj_footer?.endRefreshing()
    }
    
    func endRefreshNoMoreFooter() {
        mj_footer?.endRefreshingWithNoMoreData()
    }
    
    func endRefreshFooter(hasMore: Bool) {
        if hasMore {
            endRefreshFooter()
        } else {
            endRefreshNoMoreFooter()
        }
    }
    
    func confiEmptyDataView(hasMore: Bool, isEmpty: Bool, footerAction: (() -> Void)?) {
        endRefreshHeader()
        
        if isEmpty {
            mj_footer?.isHidden = true
            showEmptyView()
        } else {
            mj_footer?.isHidden = false
            mj_footer?.refreshingBlock = footerAction
            hideEmptyView()
        }
        
        if hasMore {
            endRefreshFooter()
        } else {
            endRefreshNoMoreFooter()
        }
    }
}
