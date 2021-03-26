//
//  EMREditCommonGrowTxtViewCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/26.
//  
//

import UIKit

class EMREditCommonGrowTxtViewCell: UITableViewCell {
    
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
    let growView = ZZGrowTextView()
    
    // MARK: - Private Property
    
    var growViewHeight: CGFloat = 96 {
        didSet {
            let h = growViewHeight - 24
            growView.config = .init(minHeight: h, maxHeight: h)
        }
    }
}

// MARK: - UI
extension EMREditCommonGrowTxtViewCell {
    private func setUI() {
        setTxtView(growView)
        contentView.addSubview(growView)
        
        growView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(12)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }
    }
}

extension UITableViewCell {
    func setTxtView(_ txtView: ZZGrowTextView) {
        txtView.zz_setCorner(radius: 4, masksToBounds: true)
        txtView.zz_setBorder(color: .cf5f5f5, width: 1)
        txtView.backgroundColor = .cFAFAFA
        txtView.textView.backgroundColor = .cFAFAFA
        txtView.config = .init(minHeight: 72, maxHeight: 72)
    }
}
