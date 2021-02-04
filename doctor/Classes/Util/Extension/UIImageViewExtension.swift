//
//  UIImageViewExtension.swift
//  healthcare_doctor
//
//  Created by lixiangzhou on 2019/9/6.
//  Copyright © 2019 sphr. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    convenience init(_ name: String) {
        self.init(image: UIImage(named: name))
    }
    
    static func defaultRightArrow() -> UIImageView {
        return UIImageView(image: UIImage(named: "common_next_arrow"))
    }
    
    func setImage(with url: URL?, bgColor: UIColor = UIColor.white, placeholder: String = "", failImage: String = "", placeholderMode: UIView.ContentMode = .scaleToFill, failMode: UIView.ContentMode = .scaleToFill, completionMode: UIView.ContentMode = .scaleToFill) {
        backgroundColor = bgColor
        guard let url = url else {
            contentMode = failMode
            image = UIImage(named: failImage)
            return
        }
        
        kf.setImage(with: url, placeholder: UIImage(named: placeholder), options: nil, progressBlock: nil) { (result) in
            switch result {
            case .failure:
                self.image = UIImage(named: failImage.isEmpty ? placeholder : failImage)
                self.contentMode = failMode
            case .success:
                self.contentMode = completionMode
            }
        }
    }
}
