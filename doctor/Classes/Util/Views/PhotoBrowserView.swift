//
//  PhotoBrowserView.swift
//  healthcare_doctor
//
//  Created by 李向洲 on 2020/7/13.
//  Copyright © 2020 LXZ. All rights reserved.
//

import UIKit

class PhotoBrowserView: BaseShowView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cycleView: ZZCycleView! = {
        let rect = CGRect(x: -10, y: 0, width: UIScreen.zz_width + 20, height: UIScreen.zz_height - UIScreen.zz_statusBar_additionHeight - UIScreen.zz_tabBar_additionHeight)
        let view = ZZCycleView(frame: rect)
        return view
    }()
//    var collectionView: UICollectionView!
    let numberLabel = UILabel(text: "0 / 0", font: .size(17), textColor: .white)
}

// MARK: - UI
extension PhotoBrowserView {
    private func setUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.zz_width + 20, height: UIScreen.zz_height)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        addSubview(cycleView)
        cycleView.layout = layout
        addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(UIScreen.zz_statusBar_additionHeight).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}

extension PhotoBrowserView {
    @discardableResult
    static func show(number: Int, showAt idx: Int, urlForIdx: @escaping (Int) -> URL?) -> Self {
        let browser = PhotoBrowserView()
        browser.cycleView.cycleCount = UInt(number)
        browser.cycleView.canCycle = false
        browser.cycleView.showAt(idx: idx)
        browser.cycleView.register(cell: ImageCell.self)
        
        browser.cycleView.cellForIndex = { view , idx in
            let cell = view.dequeue(cell: ImageCell.self, for: IndexPath(item: idx, section: 0))
            cell.imageView.transform = .identity
            cell.imageView.setImage(with: urlForIdx(idx), bgColor: .black, failImage: "", completionMode: .scaleAspectFit)
            return cell
        }
        
        browser.cycleView.didSelectCell = { [weak browser] view, _, _ in
            browser?.hide()
        }
        
        browser.cycleView.indexChange = { [weak browser] idx in
            browser?.numberLabel.text = "\(idx + 1)/\(number)"
        }
        
        browser.numberLabel.text = "\(idx + 1)/\(number)"
        
        browser.show()
        
        return browser as! Self
    }
}

extension PhotoBrowserView {
    class ImageCell: ZZCycleViewCell {
        let borderView = UIView()
        let imageView = UIImageView()
        override func setUI() {
            
//            imageView.isUserInteractionEnabled = true
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction))
            let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
            borderView.addGestureRecognizer(pinch)
            borderView.addGestureRecognizer(pan)
            
            borderView.clipsToBounds = true
            
            contentView.addSubview(borderView)
            borderView.addSubview(imageView)
            
            borderView.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.top.bottom.equalToSuperview()
                make.right.equalTo(-10)
            }
            
            imageView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        @objc func pinchAction(_ pinch: UIPinchGestureRecognizer) {
            let scale = pinch.scale
            imageView.transform = imageView.transform.scaledBy(x: scale, y: scale)
            pinch.scale = 1
        }
        
        
        var startPoint: CGPoint!
        var startTransform: CGAffineTransform!
        @objc func panAction(_ pan: UIPanGestureRecognizer) {
//            print(pan.translation(in: imageView))
            let p = pan.translation(in: borderView)
            
            switch pan.state {
            case .began:
                startPoint = imageView.center
//                startTransform = imageView.transform
            default:
//                imageView.zz_x += p.x
//                imageView.zz_y += p.y
//                imageView.center =
                imageView.transform = startTransform.translatedBy(x: startPoint.x + p.x, y: startPoint.y + p.y)
            }
            pan.setTranslation(.zero, in: imageView)
        }
    }
    
}
