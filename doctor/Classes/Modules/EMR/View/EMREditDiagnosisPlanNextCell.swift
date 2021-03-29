//
//  EMREditDiagnosisPlanNextCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class EMREditDiagnosisPlanNextCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var showSelect: Bool = false {
        didSet {
            if showSelect {
                pannelView.roundColor = .c4167f3
                titleLabel.textColor = .white
                pannelView.roundingCorners = .allCorners
                selView.isHidden = false
            } else {
                pannelView.roundColor = .cfbfbfb
                titleLabel.textColor = .c6
                pannelView.roundingCorners = .allCorners
                selView.isHidden = true
            }
            pannelView.setNeedsDisplay()
        }
    }
    
    var showDiagnosisView: Bool = false {
        didSet {
            if showDiagnosisView {
                pannelView.roundColor = .c4167f3
                titleLabel.textColor = .white
                pannelView.roundingCorners = [.topLeft, .topRight]
                
                selView.isHidden = false
                diagnosisView.isHidden = false
                pannelView.snp.updateConstraints { (make) in
                    make.bottom.equalTo(-8 - 88)
                }
            } else {
                pannelView.roundColor = .cfbfbfb
                titleLabel.textColor = .c6
                pannelView.roundingCorners = .allCorners
                selView.isHidden = true
                
                diagnosisView.isHidden = true
                pannelView.snp.updateConstraints { (make) in
                    make.bottom.equalTo(-8)
                }
            }
            pannelView.setNeedsDisplay()
        }
    }
    
    // MARK: - Public Property
    let titleLabel = UILabel(font: .boldSize(14), textColor: .c6)
    let selView = UIImageView("")
    // MARK: - Private Property
    
    let pannelView = RoundOptionView(radius: 4, roundColor: .cfbfbfb, bgColor: .white, roundingCorners: .allCorners)
    
    let diagnosisView = UIView()
    var diagnosisTimeLabel: UILabel!
    var diagnosisLocLabel: UILabel!
}

// MARK: - UI
extension EMREditDiagnosisPlanNextCell {
    private func setUI() {
        selView.backgroundColor = .red
        
        selView.isHidden = true
        contentView.addSubview(pannelView)
        pannelView.addSubview(selView)
        pannelView.addSubview(titleLabel)
        
        diagnosisTimeLabel = addSubRow(idx: 0, title: "复诊时间", selector: #selector(timeAction))
        diagnosisLocLabel = addSubRow(idx: 1, title: "复诊地点", selector: #selector(locAction))
        
        diagnosisView.isHidden = true
        pannelView.addSubview(diagnosisView)
        
        pannelView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(12)
            make.right.equalTo(-16)
            make.bottom.equalTo(-8)
            make.height.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(8)
        }
        
        selView.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
        }
        
        diagnosisView.snp.makeConstraints { (make) in
            make.top.equalTo(pannelView.snp.bottom)
            make.left.right.equalTo(pannelView)
            make.height.equalTo(88)
        }
    }
    
    func addSubRow(idx: Int, title: String, selector: Selector) -> UILabel {
        let row = UIView()
        let leftLabel = row.zz_add(subview: UILabel(text: title, font: .size(14), textColor: .c3))
        let rightLabel = row.zz_add(subview: UILabel(font: .size(12), textColor: .c3))
        let arrowView = row.zz_add(subview: UIImageView.defaultRightArrow())
        row.addBottomLine(left: 8, right: 8, height: 1)
        
        row.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        
        diagnosisView.addSubview(row)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.bottom.equalTo(-8)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(leftLabel)
            make.right.equalTo(-23)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(leftLabel)
        }
        
        row.snp.makeConstraints { (make) in
            make.top.equalTo(idx * 44)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        return rightLabel as! UILabel
    }
    
}

// MARK: - Action
extension EMREditDiagnosisPlanNextCell {
    @objc func timeAction() {
        
    }
    
    @objc func locAction() {
        
    }
}
