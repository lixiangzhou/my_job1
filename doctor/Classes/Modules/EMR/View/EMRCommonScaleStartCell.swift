//
//  EMRCommonScaleStartCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class EMRCommonScaleStartCell: UITableViewCell {
    
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
    let leftTimeLabel = UILabel(font: .size(12), textColor: .c3, textAlignment: .center)
    let leftBottomLine = UIView()
    
    var inputStateLabel: UILabel!
    var diagnosisStateLabel: UILabel!
    var inputPersonLabel: UILabel!
    var submitTimeLabel: UILabel!
    var scoreLabel: UILabel!
    var resultLabel: UILabel!
    // MARK: - Private Property
    
    var rightView: RoundOptionView!
    let leftW: CGFloat = 106
}

// MARK: - UI
extension EMRCommonScaleStartCell {
    private func setUI() {
        addLeftView()
        
        addRightView()
    }
    
    func addLeftView() {
        let leftCircleView = UIImageView()
        leftCircleView.backgroundColor = .blue
        leftBottomLine.backgroundColor = .cE6EAF2
        
        contentView.addSubview(leftTimeLabel)
        contentView.addSubview(leftBottomLine)
        contentView.addSubview(leftCircleView)
        
        leftTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        leftCircleView.snp.makeConstraints { (make) in
            make.left.equalTo(90)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(10)
        }
        
        leftBottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(94)
            make.width.equalTo(2)
            make.bottom.equalToSuperview()
            make.top.equalTo(leftCircleView.snp.bottom)
        }
    }
    
    func addRightView() {
        rightView = RoundOptionView(frame: CGRect(x: 106, y: 8, width: UIScreen.zz_width - leftW - 16, height: 174), radius: 4, roundColor: .cF5F8FF, bgColor: .white, roundingCorners: .allCorners)
        contentView.addSubview(rightView)
        
        inputStateLabel = addRowView(idx: 0, title: "填写状态")
        diagnosisStateLabel = addRowView(idx: 1, title: "就诊状态")
        inputPersonLabel = addRowView(idx: 2, title: "填写人")
        submitTimeLabel = addRowView(idx: 3, title: "提交时间")
        scoreLabel = addRowView(idx: 4, title: "评分")
        resultLabel = addRowView(idx: 5, title: "结果")
        
        rightView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(leftW)
            make.right.equalTo(-16)
            make.height.equalTo(174)
            make.bottom.equalTo(-8)
        }
    }
    
    func addRowView(idx: CGFloat, title: String) -> UILabel {
        let h = CGFloat(25)
        let w = rightView.zz_width
        let row = UIView(frame: CGRect(x: 0, y: 8 + h * idx, width: w, height: h))
        
        let titleLabel = UILabel(text: title, font: .boldSize(12), textColor: .c4167f3)
        titleLabel.frame = CGRect(x: 16, y: 0, width: 100, height: h)
        row.addSubview(titleLabel)
        
        let rightLabel = UILabel(font: .size(12), textColor: .c4167f3)
        rightLabel.frame = CGRect(x: 118, y: 0, width: 120, height: h)
        row.addSubview(rightLabel)
        
        rightView.addSubview(row)
        
        if idx == 0 {
            let arrow = row.zz_add(subview: UIImageView())
            arrow.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(-16)
            }
        }
        
        return rightLabel
    }
}
