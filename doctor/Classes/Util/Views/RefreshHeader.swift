//
//  RefreshHeader.swift
//  healthcare_doctor
//
//  Created by 李向洲 on 2020/7/2.
//  Copyright © 2020 LXZ. All rights reserved.
//

import UIKit

class RefreshHeader: MJRefreshNormalHeader {
    let contentView = UIView()
    
    override func prepare() {
        super.prepare()
        addSubview(contentView)
        
        self.activityIndicatorViewStyle = .gray
        
        
        arrowView?.image = UIImage(named: "common_refresh")
        
        contentView.addSubview(self.loadingView!)
        contentView.addSubview(self.stateLabel!)
        contentView.addSubview(self.arrowView!)
        
        lastUpdatedTimeLabel?.isHidden = true
        
        setTitle("下拉刷新", for: .idle)
        setTitle("释放更新", for: .pulling)
        setTitle("正在刷新", for: .refreshing)
        
        stateLabel?.font = .size(14)
        stateLabel?.textColor = .darkGray
        
        
    }
    
    override func placeSubviews() {
        self.mj_y = -self.mj_h - self.ignoredScrollViewContentInsetTop;
        
        guard let stateLabel = stateLabel,
              let arrowView = arrowView,
              let loadingView = loadingView else { return }
        
        stateLabel.sizeToFit()
        arrowView.sizeToFit()
        loadingView.sizeToFit()
        
        let padding: CGFloat = 5
        
        var w: CGFloat
        var h: CGFloat
        var x: CGFloat
        var y: CGFloat
        
        h = max(loadingView.zz_height, max(stateLabel.zz_height, arrowView.zz_height))
        
        var stateX: CGFloat
        let stateW = stateLabel.text!.zz_size(withLimitWidth: 1000, fontSize: 14).width
        
        if state == .refreshing {
            arrowView.isHidden = true
            loadingView.isHidden = false
            
            w = loadingView.zz_width + stateW + padding
            x = (zz_width - w) * 0.5
            
            loadingView.frame = CGRect(x: 0,
                                     y: (h - loadingView.zz_height) * 0.5,
                                     width: loadingView.zz_width,
                                     height: loadingView.zz_height)
            
            stateX = loadingView.zz_width + padding
            
        } else {
            arrowView.isHidden = false
            loadingView.isHidden = true
            
            w = arrowView.zz_width + stateW + padding
            x = (zz_width - w) * 0.5
            
            arrowView.frame = CGRect(x: 0,
                                     y: (h - arrowView.zz_height) * 0.5,
                                     width: arrowView.zz_width,
                                     height: arrowView.zz_height)
            
            stateX = arrowView.zz_width + padding
        }
        
        y = (zz_height - h) * 0.5
        
        contentView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        stateLabel.frame = CGRect(x: stateX,
                                  y: (h - stateLabel.zz_height) * 0.5,
                                  width: stateW,
                                  height: stateLabel.zz_height)
    }
}


//class RefreshHeader: ZZRefreshHeader {
//    let arrowView = UIView()
//    let arrow = UIImageView("common_refresh")
//    let arrowLabel = UILabel(font: .size(14), textColor: .c6)
//
//    let ingView = UIView()
//    let ingLoading = UIActivityIndicatorView(style: .gray)
//    let ingLabel = UILabel(text: "正在刷新", font: .size(14), textColor: .c6)
//
//    override var state: ZZRefreshState {
//        didSet {
//            ingView.isHidden = state != .refreshing
//            arrowView.isHidden = state == .refreshing
//
//            ingLoading.stopAnimating()
//
//            UIView.animate(withDuration: 0.2) {
//                switch self.state {
//                case .normal, .willRefreshing:
//                    self.arrow.transform = .identity
//                    self.arrowLabel.text = "下拉刷新"
//                case .refreshing:
//                    self.arrow.transform = .identity
//                    self.ingLoading.startAnimating()
//                case .releaseRefreshing:
//                    self.arrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) + 0.001)
//                    self.arrowLabel.text = "释放更新"
//                default: break
//                }
//            }
//        }
//    }
//
//    override func setupUI() {
//        arrowView.addSubview(arrow)
//        arrowView.addSubview(arrowLabel)
//
//        ingView.addSubview(ingLoading)
//        ingView.addSubview(ingLabel)
//
//        addSubview(arrowView)
//        addSubview(ingView)
//
//        arrowView.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//        }
//
//        ingView.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//        }
//
//        arrow.snp.makeConstraints { (make) in
//            make.left.top.bottom.equalToSuperview()
//        }
//
//        arrowLabel.snp.makeConstraints { (make) in
//            make.centerY.right.equalToSuperview()
//            make.left.equalTo(arrow.snp.right).offset(5)
//        }
//
//        ingLoading.snp.makeConstraints { (make) in
//            make.left.top.bottom.equalToSuperview()
//        }
//
//        ingLabel.snp.makeConstraints { (make) in
//            make.centerY.right.equalToSuperview()
//            make.left.equalTo(arrow.snp.right).offset(5)
//        }
//    }
//}
