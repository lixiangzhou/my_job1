//
//  ZZRefresh.swift
//  ZZRefresh
//
//  Created by lixiangzhou on 16/10/26.
//  Copyright © 2016年 lixiangzhou. All rights reserved.
//


import UIKit

public enum ZZRefreshState {
    case normal                 // 正常状态
    case willRefreshing         // 即将刷新的状态
    case releaseRefreshing      // 释放即可刷新的状态
    case refreshing             // 正在刷新状态
    case noMoreData                 // 没有更多数据
}

public enum ZZRefreshViewPositionStyle {
    case bottom
    case top
    case scaleToFill
}
