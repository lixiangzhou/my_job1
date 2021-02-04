//
//  TextLeftGrowTextRightCell.swift
//  healthcare_doctor
//
//  Created by Macbook Pro on 2019/7/3.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit

class TextLeftGrowTextRightCell: UITableViewCell {
    
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
    var leftLabel: UILabel {
        innerView.leftLabel
    }
    
    var rightLabel: UILabel {
        innerView.rightLabel
    }
    
    var bottomLine: UIView {
        innerView.bottomLine
    }
    
    var config: TextLeftGrowTextRightViewConfig? {
        didSet {
            innerView.config = config
        }
    }
    // MARK: - Private Property
    private let innerView = TextLeftGrowTextRightView()
}

// MARK: - UI
extension TextLeftGrowTextRightCell {
    private func setUI() {
        contentView.addSubview(innerView)
        
        innerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


