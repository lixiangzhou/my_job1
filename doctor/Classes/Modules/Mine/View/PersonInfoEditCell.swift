//
//  PersonInfoEditCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/4.
//  
//

import UIKit

class PersonInfoEditCell: TextTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        config = .init(leftPaddingRight: 0, leftFont: .size(14), rightFont: .size(14), rightTextColor: .c26d765, rightPaddingLeft: 8, bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
