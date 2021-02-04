//
//  RoundOptionView.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//  
//

import UIKit

class RoundOptionView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 8), radius: CGFloat = 8, roundColor: UIColor = .white, bgColor: UIColor = .clear, roundingCorners: UIRectCorner) {
        self.init(frame: frame)
        self.radius = radius
        self.roundColor = roundColor
        self.roundingCorners = roundingCorners
        self.backgroundColor = bgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    private var radius: CGFloat = 8
    private var roundColor: UIColor = .white
    private var roundingCorners: UIRectCorner = [.bottomLeft, .bottomRight]
}

// MARK: - UI
extension RoundOptionView {
    override func draw(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
        path.addClip()
        roundColor.setFill()
        UIRectFill(rect)
    }
}

extension RoundOptionView {
    static func bottomRoundView(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 8), radius: CGFloat = 8, roundColor: UIColor = .white, bgColor: UIColor = .clear) -> RoundOptionView {
        RoundOptionView(frame: frame, radius: radius, roundColor: roundColor, bgColor: bgColor, roundingCorners: [.bottomRight, .bottomLeft])
    }
    
    static func topRoundView(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 8), radius: CGFloat = 8, roundColor: UIColor = .white, bgColor: UIColor = .clear) -> RoundOptionView {
        RoundOptionView(frame: frame, radius: radius, roundColor: roundColor, bgColor: bgColor, roundingCorners: [.topLeft, .topRight])
    }
}
