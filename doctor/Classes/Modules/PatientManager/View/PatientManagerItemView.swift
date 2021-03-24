//
//  PatientManagerItemView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/23.
//  
//

import UIKit

class PatientManagerItemView: LLSegmentBaseItemView {
    let titleLabel = UILabel()
    required init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.frame = bounds
        titleLabel.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        addSubview(titleLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleChange(title: String) {
        if let vc = associateViewCtl as? PatientManagerListController {
            titleLabel.attributedText = isSelected ? vc.viewModel.selectAttributeTitle : vc.viewModel.attributeTitle
        }
    }
    
    override func itemWidth() -> CGFloat {
        if let vc = associateViewCtl as? PatientManagerListController {
            var w = vc.viewModel.title.zz_size(withLimitWidth: 1000, fontSize: 14).width
            w += "(\(vc.viewModel.count))".zz_size(withLimitWidth: 1000, fontSize: 12).width + 10
            print(vc.viewModel.attributeTitle.string, w)
            return w
        } else {
            return 100
        }
    }
}
