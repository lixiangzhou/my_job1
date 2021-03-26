//
//  EMREditCommonSpaceCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditCommonSpaceCell: UITableViewCell {
    
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
    let spaceView = UIView()
    // MARK: - Private Property
    
    var height: CGFloat = 0 {
        didSet {
            spaceView.snp.updateConstraints { (make) in
                make.height.equalTo(height)
            }
        }
    }
}

// MARK: - UI
extension EMREditCommonSpaceCell {
    private func setUI() {
        contentView.addSubview(spaceView)
        
        spaceView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(0)
        }
    }
}
