//
//  EMREditXCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/25.
//  
//

import UIKit

class EMREditXCell: UITableViewCell {
    
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
    var hasX: Bool = true {
        didSet {
            xView.isHidden = !hasX
            
            titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(hasX ? 28 : 12)
            }
        }
    }
    // MARK: - Private Property
    let xView = UIImageView(image: UIImage(named: "mine_auth_xx"))
    let titleLabel = UILabel(font: .size(14), textColor: .c3)
    var bottomLine: UIView!
}

// MARK: - UI
extension EMREditXCell {
    private func setUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(xView)
        contentView.addSubview(titleLabel)
        
        xView.isHidden = true
        bottomLine = contentView.addBottomLine(color: .cf5f5f5, left: 12, right: 16, height: 1)
        
        xView.snp.makeConstraints { (make) in
            make.width.height.equalTo(8)
            make.left.equalTo(12)
            make.bottom.equalTo(-14)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(12)
            make.bottom.equalTo(-8)
        }
    }
    
    func setTitleTopOffset(_ offset: CGFloat) {
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(offset)
        }
    }
    
    func addArrowView() {
        let arrowView = contentView.zz_add(subview: UIImageView.defaultRightArrow())
        arrowView.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.bottom.equalTo(-11)
        }
    }
}
