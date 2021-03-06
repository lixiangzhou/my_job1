//
//  LLSegmentBadgeItemView.swift
//  LLSegmentViewController
//
//  Created by apple on 2019/1/12.
//  Copyright © 2019年 lilin. All rights reserved.
//

import UIKit

class LLSegmentItemBadgeViewStyle:LLSegmentItemViewStyle {
    /*数字或红点Label.center偏离图片右上角*/
    var badgeValueLabelOffset = CGPoint.init(x: 5, y: 5)
    var badgeValueLabelColor = UIColor.red
    var badgeValueLabelTextColor = UIColor.white
    var badgeValueMaxNum = 99
}

let LLSegmentRedBadgeValue = "redBadgeValue"
class LLSegmentItemBadgeView: LLSegmentBaseItemView {
    let badgeValueLabel = UILabel()
    private let badgeValueObserverKeyPath = "badgeValue"
    internal var badgeValueLabelLocationView:UIView?
    private var badgeItemViewStyle = LLSegmentItemBadgeViewStyle()
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        badgeValueLabel.backgroundColor = UIColor.red
        badgeValueLabel.textAlignment = .center
        badgeValueLabel.textColor = UIColor.white
        badgeValueLabel.font = UIFont.systemFont(ofSize: 12)
        badgeValueLabel.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        badgeValueLabel.center = CGPoint.init(x: bounds.width - 10, y: 10)
        addSubview(badgeValueLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bindAssociateViewCtl(ctl: UIViewController) {
        super.bindAssociateViewCtl(ctl: ctl)
        associateViewCtl?.tabBarItem.addObserver(self, forKeyPath: badgeValueObserverKeyPath, options: [.new], context: nil)
    }
    

    deinit {
        associateViewCtl?.tabBarItem.removeObserver(self, forKeyPath: badgeValueObserverKeyPath)
    }
    
    override func setSegmentItemViewStyle(itemViewStyle: LLSegmentItemViewStyle) {
        super.setSegmentItemViewStyle(itemViewStyle: itemViewStyle)
        if let itemViewStyle = itemViewStyle as? LLSegmentItemBadgeViewStyle {
            badgeItemViewStyle = itemViewStyle
            badgeValueLabel.backgroundColor = itemViewStyle.badgeValueLabelColor
            badgeValueLabel.textColor = itemViewStyle.badgeValueLabelTextColor
        }
    }
    
    internal func layoutBadgeLabel() {
        guard let badgeValueLabelLocationView = badgeValueLabelLocationView else {
            return
        }
        
        var badgeValueStr = associateViewCtl?.tabBarItem.badgeValue
        if let badgeValue = badgeValueStr, let intValue = Int(badgeValue) {
            if intValue > badgeItemViewStyle.badgeValueMaxNum {
                badgeValueStr = "\(badgeItemViewStyle.badgeValueMaxNum)+"
            }
        }
        badgeValueLabel.text = badgeValueStr
        badgeValueLabel.sizeToFit()
        
        var badgeValueLabelFrame = badgeValueLabel.frame
        if associateViewCtl?.tabBarItem.badgeValue == LLSegmentRedBadgeValue {
            badgeValueLabel.isHidden = false
            badgeValueLabelFrame.size.width = 9
            badgeValueLabelFrame.size.height = 9
            badgeValueLabel.text = ""
        }else if associateViewCtl?.tabBarItem.badgeValue == nil {
            badgeValueLabel.isHidden = true
        }else{
            badgeValueLabel.isHidden = false
            badgeValueLabelFrame.size.width += 10
            badgeValueLabelFrame.size.height += 0
            badgeValueLabelFrame.size.width = max(badgeValueLabelFrame.width, badgeValueLabelFrame.height)
        }
        badgeValueLabel.frame = badgeValueLabelFrame
        badgeValueLabel.center = CGPoint.init(x: badgeValueLabelLocationView.frame.maxX + badgeItemViewStyle.badgeValueLabelOffset.x, y: badgeValueLabelLocationView.frame.minY + badgeItemViewStyle.badgeValueLabelOffset.y)
        badgeValueLabel.layer.cornerRadius = badgeValueLabel.bounds.height/2
        badgeValueLabel.clipsToBounds = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if  keyPath ==  badgeValueObserverKeyPath{
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
}
