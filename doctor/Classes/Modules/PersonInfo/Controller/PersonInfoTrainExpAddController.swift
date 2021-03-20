//
//  PersonInfoTrainExpAddController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class PersonInfoTrainExpAddController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "教育培训经历"
        setUI()
    }

    // MARK: - Public Property
    let nameView = TextLeftRightFieldView()
    let majorView = TextLeftRightFieldView()
    
    let inTimeLabel = UILabel(text: "入职时间", font: .size(14), textColor: .c9)
    let outTimeLabel = UILabel(text: "离职时间", font: .size(14), textColor: .c9)
    let descView = ZZGrowTextView()
    // MARK: - Private Property
    
}

// MARK: - UI
extension PersonInfoTrainExpAddController {
    override func setUI() {
        view.backgroundColor = .white
        setRightBarItem(title: "保存", action: #selector(saveAction))
        
        nameView.leftLabel.text = "名称"
        majorView.leftLabel.text = "专业"
        
        nameView.rightField.placeHolderString = "请输入名称"
        nameView.rightField.textAlignment = .right
        
        majorView.rightField.placeHolderString = "请输入专业"
        majorView.rightField.textAlignment = .right
        
        nameView.config = .init(bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
        majorView.config = .init(bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
        
        view.addSubview(nameView)
        view.addSubview(majorView)
        
        let timeView = addTimeView()
        
        addDescView(under: timeView)
        
        nameView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(52)
        }
        
        majorView.snp.makeConstraints { (make) in
            make.top.equalTo(nameView.snp.bottom)
            make.left.right.height.equalTo(nameView)
        }
    }
    
    func addTimeView() -> UIView {
        let timeView = view.zz_add(subview: UIView())
        
        let titleLabel = timeView.zz_add(subview: UILabel(text: "在职时间", font: .size(14), textColor: .c3))
        
        timeView.addSubview(inTimeLabel)
        timeView.addSubview(outTimeLabel)
        
        let sepView = timeView.zz_add(subview: UIView())
        sepView.zz_setCorner(radius: 1, masksToBounds: true)
        sepView.backgroundColor = .c3
        
        timeView.addBottomLine(left: 16, right: 16, height: 1)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
        }
        
        inTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(-16)
            make.width.equalTo(100)
        }
        
        outTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(195)
            make.bottom.equalTo(inTimeLabel)
            make.width.equalTo(100)
        }
        
        sepView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-22)
            make.width.equalTo(9)
            make.height.equalTo(2)
            make.left.equalTo(170)
        }
        
        timeView.snp.makeConstraints { (make) in
            make.top.equalTo(majorView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(84)
        }
        
        return timeView
    }
    
    func addDescView(under: UIView) {
        let contentView = view.zz_add(subview: UIView())
        
        let titleLabel = contentView.zz_add(subview: UILabel(text: "描述", font: .size(14), textColor: .c3))
        
        descView.zz_setBorder(color: .cf5f5f5, width: 1)
        descView.zz_setCorner(radius: 4, masksToBounds: true)
        descView.config = ZZGrowTextView.Config(paddingInset: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12), minHeight: 151, maxHeight: 151)
        contentView.addSubview(descView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
        }
        
        descView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.width.equalTo(175)
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(under.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}

// MARK: - Action
extension PersonInfoTrainExpAddController {
    @objc func saveAction() {
        
    }
}
