//
//  EMREditMainItemCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditMainItemCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    var hasSepLine: Bool = false {
        didSet {
            sepView.isHidden = !hasSepLine
            sepView.snp.updateConstraints { (make) in
                make.height.equalTo(hasSepLine ? 4 : 0)
            }
            time2View.bottomLine.isHidden = hasSepLine
        }
    }
    
    let partView = PartRowView()
    let timeView = RowView()
    let time2View = RowView()
    let sepView = UIImageView()
    // MARK: - Private Property
    
}

// MARK: - UI
extension EMREditMainItemCell {
    private func setUI() {
        
        timeView.leftLabel.text = "疼痛时长"
        time2View.leftLabel.text = "疼痛加重时长"
        
        contentView.addSubview(partView)
        contentView.addSubview(timeView)
        contentView.addSubview(time2View)
        sepView.backgroundColor = .blue
        contentView.addSubview(sepView)
        
        partView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        timeView.snp.makeConstraints { (make) in
            make.top.equalTo(partView.snp.bottom)
            make.left.right.equalTo(partView)
            make.height.equalTo(44)
        }
        
        time2View.snp.makeConstraints { (make) in
            make.top.equalTo(timeView.snp.bottom)
            make.left.right.equalTo(partView)
            make.height.equalTo(44)
//            make.bottom.equalToSuperview()
        }
        
        sepView.snp.makeConstraints { (make) in
            make.top.equalTo(time2View.snp.bottom)
            make.left.equalTo(12)
            make.right.equalTo(-16)
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension EMREditMainItemCell {
    
}

// MARK: - Helper
extension EMREditMainItemCell {
    
}

// MARK: - Other
extension EMREditMainItemCell {
    class RowView: BaseView {
        let leftLabel = UILabel(font: .size(14), textColor: .c3)
        let rightLabel = UILabel(text: "请选择", font: .size(12), textColor: .c9)
        var bottomLine: UIView!
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(leftLabel)
            addSubview(rightLabel)
            
            let arrowView = zz_add(subview: UIImageView.defaultRightArrow())
            
            bottomLine = addBottomLine(left: 12, right: 16, height: 1)
            
            leftLabel.snp.makeConstraints { (make) in
                make.left.equalTo(12)
                make.bottom.equalTo(-8)
            }
            
            rightLabel.snp.makeConstraints { (make) in
                make.right.equalTo(-32)
                make.centerY.equalTo(leftLabel)
            }
            
            arrowView.snp.makeConstraints { (make) in
                make.right.equalTo(-16)
                make.centerY.equalTo(leftLabel)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class PartRowView: BaseView {
        let leftLabel = UILabel(text: "疼痛部位", font: .size(14), textColor: .c3)
        let rightLabel = UILabel(font: .size(12), textColor: .white)
        let rightTipLabel = UILabel(text: "请选择", font: .size(12), textColor: .c9)
        let tipView = UIView()
        let tipLabel = UILabel(text: "根据选择的疼痛部位和方位，可考虑神经区域为：三叉神经", font: .size(12), textColor: .c9, textAlignment: .left)
        
        var showTip: Bool = false {
            didSet {
                tipView.isHidden = !showTip
                leftLabel.snp.updateConstraints { (make) in
                    make.bottom.equalTo(showTip ? -50 : -8)
                }
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(leftLabel)
            
            rightLabel.backgroundColor = .c4167f3
            rightLabel.zz_setCorner(radius: 4, masksToBounds: true)
            rightLabel.isHidden = true
            addSubview(rightLabel)
            
            addSubview(rightTipLabel)
            
            let arrowView = zz_add(subview: UIImageView.defaultRightArrow())
            
            addBottomLine(left: 12, right: 16, height: 1)
            
            tipView.addSubview(tipLabel)
            let tipBtn = UIButton(title: "查看神经分布图", font: .size(12), titleColor: .c4167f3, target: self, action: #selector(tipAction))
            tipBtn.titleEdgeInsets = .init(top: 14, left: 0, bottom: 0, right: 0)
            tipView.addSubview(tipBtn)
            tipView.isHidden = true
            addSubview(tipView)
            
            leftLabel.snp.makeConstraints { (make) in
                make.top.equalTo(16)
                make.left.equalTo(12)
//                make.height.equalTo(20)
                make.bottom.equalTo(-8)
            }
            
            rightLabel.snp.makeConstraints { (make) in
                make.right.equalTo(-32)
                make.centerY.equalTo(leftLabel)
                make.width.equalTo(48)
                make.height.equalTo(28)
            }
            
            rightTipLabel.snp.makeConstraints { (make) in
                make.right.equalTo(-32)
                make.centerY.equalTo(leftLabel)
            }
            
            arrowView.snp.makeConstraints { (make) in
                make.right.equalTo(-16)
                make.centerY.equalTo(leftLabel)
            }
            
            tipView.snp.makeConstraints { (make) in
                make.left.equalTo(12)
                make.right.equalTo(-16)
                make.bottom.equalTo(-8)
                make.height.equalTo(34)
            }
            
            tipLabel.snp.makeConstraints { (make) in
                make.top.right.left.equalToSuperview()
            }
            
            tipBtn.sizeToFit()
            tipBtn.snp.makeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.width.equalTo(tipBtn.zz_width)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func tipAction() {
            
        }
    }
}
