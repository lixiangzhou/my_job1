//
//  EMREditBasicFieldCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/24.
//  
//

import UIKit

class EMREditBasicFieldCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var hasX: Bool = true {
        didSet {
            xView.isHidden = !hasX
            
            titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(hasX ? 28 : 12)
            }
        }
    }
    
    // MARK: - Public Property
    
    // MARK: - Private Property
    let xView = UIImageView(image: UIImage(named: "mine_auth_xx"))
    let titleLabel = UILabel(font: .size(14), textColor: .c3)
    
    let fieldView = UITextField()
}

// MARK: - UI
extension EMREditBasicFieldCell {
    private func setUI() {
        contentView.backgroundColor = .white
        
        fieldView.textAlignment = .right
        fieldView.font = .size(14)
        
        contentView.addSubview(xView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(fieldView)
        
        contentView.addBottomLine(color: .cf5f5f5, left: 12, right: 16, height: 1)
        
        xView.snp.makeConstraints { (make) in
            make.width.height.equalTo(8)
            make.left.equalTo(12)
            make.bottom.equalTo(-14)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(28)
            make.bottom.equalTo(-8)
            make.height.equalTo(20)
        }
        
        fieldView.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.right.equalTo(-16)
            make.width.equalTo(120)
            make.bottom.equalToSuperview()
        }
    }
}
