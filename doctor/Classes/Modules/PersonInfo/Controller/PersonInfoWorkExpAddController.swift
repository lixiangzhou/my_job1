//
//  PersonInfoWorkExpAddController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class PersonInfoWorkExpAddController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "工作经历"
        setUI()
    }

    // MARK: - Public Property
    let hospitalView = TextLeftRightFieldView()
    let deptView = TextLeftRightFieldView()
    let titleView = LeftRightConfigView()
    
    let inTimeLabel = UILabel(text: "入职时间", font: .size(14), textColor: .c9)
    let outTimeLabel = UILabel(text: "离职时间", font: .size(14), textColor: .c9)
    let calendar = CalendarView()
    // MARK: - Private Property
    
}

// MARK: - UI
extension PersonInfoWorkExpAddController {
    override func setUI() {
        view.backgroundColor = .white
        setRightBarItem(title: "保存", action: #selector(saveAction))
        
        hospitalView.leftLabel.text = "医院"
        deptView.leftLabel.text = "科室"
        
        hospitalView.rightField.placeHolderString = "请输入医院"
        hospitalView.rightField.textAlignment = .right
        
        deptView.rightField.placeHolderString = "请输入科室"
        deptView.rightField.textAlignment = .right
        
        hospitalView.config = .init(bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
        deptView.config = .init(bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
        
        view.addSubview(hospitalView)
        view.addSubview(deptView)
        
        titleView.leftLabel.text = "职称"
        titleView.config = .init(leftPaddingRight: 0, leftFont: .size(14), rightFont: .size(14), bottomLineLeftPadding: 16, bottomLineRightPadding: 16, bottomLineHeight: 1)
        view.addSubview(titleView)
        
        addTimeView()
        
        hospitalView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(52)
        }
        
        deptView.snp.makeConstraints { (make) in
            make.top.equalTo(hospitalView.snp.bottom)
            make.left.right.height.equalTo(hospitalView)
        }
        
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(deptView.snp.bottom)
            make.left.right.height.equalTo(hospitalView)
        }
    }
    
    func addTimeView() {
        let timeView = view.zz_add(subview: UIView())
        
        let titleLabel = timeView.zz_add(subview: UILabel(text: "在职时间", font: .size(14), textColor: .c3))
        
        inTimeLabel.isUserInteractionEnabled = true
        outTimeLabel.isUserInteractionEnabled = true
        inTimeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(intimeAction)))
        outTimeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(outtimeAction)))
        
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
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(84)
        }
    }
}

// MARK: - Action
extension PersonInfoWorkExpAddController {
    @objc func saveAction() {
        
    }
    
    @objc func intimeAction() {
        calendar.titleLabel.text = "入职时间"
        if let time = inTimeLabel.text?.zz_date(withDateFormat: "yyyy-MM-dd") {
            calendar.calendar.config.selectDate = time
        } else {
            calendar.calendar.config.selectDate = Date()
        }
        
        calendar.finishClosure = { [weak self] day in
            self?.inTimeLabel.textColor = .c3
            self?.inTimeLabel.text = String(format: "%d-%02d-%02d", day.year, day.month, day.day)
        }
        
        calendar.show()
    }
    
    @objc func outtimeAction() {
        calendar.titleLabel.text = "入职时间"
        if let time = outTimeLabel.text?.zz_date(withDateFormat: "yyyy-MM-dd") {
            calendar.calendar.config.selectDate = time
        } else {
            calendar.calendar.config.selectDate = Date()
        }
        
        calendar.finishClosure = { [weak self] day in
            self?.outTimeLabel.textColor = .c3
            self?.outTimeLabel.text = String(format: "%d-%02d-%02d", day.year, day.month, day.day)
        }
        
        calendar.show()
    }
}
