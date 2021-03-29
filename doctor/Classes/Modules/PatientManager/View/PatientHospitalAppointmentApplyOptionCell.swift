//
//  PatientHospitalAppointmentApplyOptionCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/29.
//  
//

import UIKit

class PatientHospitalAppointmentApplyOptionCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var showOption: Bool = false {
        didSet {
            if showOption {
                pannelView.roundColor = .c4167f3
                titleLabel.textColor = .white
                pannelView.roundingCorners = [.topLeft, .topRight]
                
                selView.isHidden = false
                detailView.isHidden = false
                pannelView.snp.updateConstraints { (make) in
                    make.bottom.equalTo(-8 - 44)
                }
            } else {
                pannelView.roundColor = .cfbfbfb
                titleLabel.textColor = .c6
                pannelView.roundingCorners = .allCorners
                selView.isHidden = true
                
                detailView.isHidden = true
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
    
    let detailView = UIView()
    let detailLeftLabel = UILabel(font: .size(14), textColor: .c3)
    let detailRightLabel = UILabel(font: .size(14), textColor: .c3)
}

// MARK: - UI
extension PatientHospitalAppointmentApplyOptionCell {
    private func setUI() {
        selView.backgroundColor = .red
        
        selView.isHidden = true
        contentView.addSubview(pannelView)
        pannelView.addSubview(selView)
        pannelView.addSubview(titleLabel)
        
        detailView.backgroundColor = .cfbfbfb
        detailView.isHidden = true
        
        detailView.addSubview(detailLeftLabel)
        detailView.addSubview(detailRightLabel)
        contentView.addSubview(detailView)
        
        let arrowView = detailView.zz_add(subview: UIImageView.defaultRightArrow())
//        detailView.addBottomLine(left: 8, right: 8, height: 1)
        
        detailView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(arrowAction)))
        
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
        
        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(pannelView.snp.bottom)
            make.left.right.equalTo(pannelView)
            make.height.equalTo(44)
        }
        
        detailLeftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.bottom.equalTo(-10)
        }
        
        detailRightLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(detailLeftLabel)
            make.right.equalTo(-23)
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(detailLeftLabel)
        }

    }
    
}

// MARK: - Action
extension PatientHospitalAppointmentApplyOptionCell {
    @objc func arrowAction() {
        
    }
}
