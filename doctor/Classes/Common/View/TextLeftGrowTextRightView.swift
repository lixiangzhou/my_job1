//
//  TextLeftGrowTextRightView.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/7/3.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

class TextLeftGrowTextRightView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    let bottomLine = UIView()
    
    var config: TextLeftGrowTextRightViewConfig! {
        didSet {
            leftLabel.font = config.leftFont
            leftLabel.textColor = config.leftTextColor
            
            rightLabel.font = config.rightFont
            rightLabel.textColor = config.rightTextColor
            rightLabel.textAlignment = config.rightAlignment
            
            leftLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(config.leftPadding)
                make.width.equalTo(config.leftWidth)
                
                switch config.leftAlignment {
                case .top:
                    make.top.equalTo(config.leftTopPadding)
                    make.bottom.lessThanOrEqualTo(-config.leftBottomPadding)
                case .center:
                    make.centerY.equalToSuperview()
                case .bottom:
                    make.top.greaterThanOrEqualTo(config.leftTopPadding)
                    make.bottom.equalTo(-config.leftBottomPadding)
                }
            }
            
            rightLabel.snp.remakeConstraints { (make) in
                make.right.equalTo(-config.rightPadding)
                make.top.equalTo(config.rightTopPadding)
                make.bottom.equalTo(bottomLine).offset(-config.rightBottomPadding)
                if config.rightAlignment == .right {
                    make.left.greaterThanOrEqualTo(leftLabel.snp.right).offset(config.leftToRightMargin)
                } else {
                    make.left.equalTo(leftLabel.snp.right).offset(config.leftToRightMargin)
                }
            }
            
            bottomLine.isHidden = !config.hasBottomLine
            bottomLine.backgroundColor = config.bottomLineColor
            
            bottomLine.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.equalTo(config.bottomLineLeftPadding)
                make.right.equalTo(-config.bottomLineRightPadding)
                make.height.equalTo(config.bottomLineHeight)
            }
        }
    }
    
    // MARK: - Private Property
}

// MARK: - UI
extension TextLeftGrowTextRightView {
    private func setUI() {
        rightLabel.numberOfLines = 0
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(bottomLine)
    }
}

struct TextLeftGrowTextRightViewConfig {
    /// 左边的View距离左边的距离
    var leftPadding: CGFloat
    /// 左边的View距离顶部的距离
    var leftTopPadding: CGFloat
    /// 左边的View距离底部的距离
    var leftBottomPadding: CGFloat
    /// 左边文本宽度
    var leftWidth: CGFloat
    /// 左边文本字体
    var leftFont: UIFont
    /// 左边文本字体颜色
    var leftTextColor: UIColor
    /// 左边文本对其方式
    var leftAlignment: TextAlignment
    
    /// 右边的View距离右边的距离
    var rightPadding: CGFloat
    /// 右边的View距离顶部的距离
    var rightTopPadding: CGFloat
    /// 右边的View距离底部的距离
    var rightBottomPadding: CGFloat
    /// 右边文本字体
    var rightFont: UIFont
    /// 右边文本字体颜色
    var rightTextColor: UIColor
    /// 右边文本对其方式
    var rightAlignment: NSTextAlignment
    
    ///
    var leftToRightMargin: CGFloat
    
    var hasBottomLine = true
    var bottomLineColor: UIColor
    var bottomLineLeftPadding: CGFloat
    var bottomLineRightPadding: CGFloat
    var bottomLineHeight: CGFloat
    
    init(leftPadding: CGFloat = 15,
         leftTopPadding: CGFloat = 10,
         leftBottomPadding: CGFloat = 10,
         leftWidth: CGFloat = 80,
         leftFont: UIFont = UIFont.size(16),
         leftTextColor: UIColor = .gray,
         leftAlignment: TextAlignment = .top,
         rightPadding: CGFloat = 15,
         rightTopPadding: CGFloat = 10,
         rightBottomPadding: CGFloat = 10,
         rightFont: UIFont = UIFont.size(16),
         rightTextColor: UIColor = .gray,
         rightAlignment: NSTextAlignment = .right,
         leftToRightMargin: CGFloat = 20,
         hasBottomLine: Bool = true,
         bottomLineColor: UIColor = UIColor.lightGray,
         bottomLineLeftPadding: CGFloat = 0,
         bottomLineRightPadding: CGFloat = 0,
         bottomLineHeight: CGFloat = 0.5) {
        self.leftPadding = leftPadding
        self.leftTopPadding = leftTopPadding
        self.leftBottomPadding = leftBottomPadding
        self.leftWidth = leftWidth
        self.leftFont = leftFont
        self.leftTextColor = leftTextColor
        self.leftAlignment = leftAlignment
        
        self.rightPadding = rightPadding
        self.rightTopPadding = rightTopPadding
        self.rightBottomPadding = rightBottomPadding
        self.rightFont = rightFont
        self.rightTextColor = rightTextColor
        self.rightAlignment = rightAlignment
        
        self.leftToRightMargin = leftToRightMargin
        
        self.hasBottomLine = hasBottomLine
        self.bottomLineColor = bottomLineColor
        self.bottomLineLeftPadding = bottomLineLeftPadding
        self.bottomLineRightPadding = bottomLineRightPadding
        self.bottomLineHeight = bottomLineHeight
    }
}

extension TextLeftGrowTextRightViewConfig {
    enum TextAlignment {
        case top
        case center
        case bottom
    }
}
