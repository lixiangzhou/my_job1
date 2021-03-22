//
//  CalendarView.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/22.
//  
//

import UIKit

class CalendarView: BaseShowView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setUI()
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: toolBarHeight + nextHeight + calendar.collectionH + calendar.config.weekH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    
    let titleLabel = UILabel(text: "选择时间", font: .size(12), textColor: .c9)
    let nextView = NextView()
    var calendar: ZZCalendarView!
    var finishClosure: ((DayModel) -> Void)?
    
    // MARK: - Private Property
    private let toolBarHeight: CGFloat = 44
    private let nextHeight: CGFloat = 40
}

// MARK: - UI
extension CalendarView {
    private func setUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        
        contentView.backgroundColor = .clear
        
        let toolBar = RoundOptionView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: toolBarHeight), roundingCorners: [.topLeft, .topRight])
        addSubview(toolBar)
        contentView.addSubview(toolBar)
        
        let cancelBtn = UIButton(title: "取消", font: .size(14), titleColor: .c6, target: self, action: #selector(hide))
        let finishBtn = UIButton(title: "确定", font: .size(14), titleColor: .c4167f3, target: self, action: #selector(finishAction))
        
        toolBar.addSubview(titleLabel)
        toolBar.addSubview(cancelBtn)
        toolBar.addSubview(finishBtn)
        
        nextView.backgroundColor = .white
        nextView.preBtn.addTarget(self, action: #selector(preAction), for: .touchUpInside)
        nextView.nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        contentView.addSubview(nextView)
        
        
        calendar = ZZCalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 400))
        calendar.backgroundColor = .white
        contentView.addSubview(calendar)
        
        nextView.titleLabel.text = String(format: "%d-%02d", calendar.config.selectDate.zz_year, calendar.config.selectDate.zz_month)
        
        calendar.selectMonthClosure = { [weak self] month in
            self?.nextView.titleLabel.text = String(format: "%d-%02d", month.year, month.month)
        }
        
        toolBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.bottom.equalToSuperview()
        }
        
        finishBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        nextView.snp.makeConstraints { (make) in
            make.top.equalTo(toolBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(nextHeight)
        }
        
        calendar.snp.makeConstraints { (make) in
            make.top.equalTo(nextView.snp.bottom)
            make.width.equalTo(UIScreen.zz_width)
            make.height.equalTo(calendar.config.weekH + calendar.collectionH)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension CalendarView {
    @objc private func finishAction() {
        hide()
        if let day = calendar.currentDayModel {
            finishClosure?(day)
        }
    }
    
    @objc private func preAction() {
        print(#function)
    }
    
    @objc private func nextAction() {
        print(#function)
    }
}

extension CalendarView {
    class NextView: BaseView {
        let titleLabel = UILabel(text: " ", font: UIFont.AvenirNext.demibold.size(16), textColor: .c3)
        let preBtn = UIButton(imageName: "")
        let nextBtn = UIButton(imageName: "")
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            preBtn.backgroundColor = .blue
            nextBtn.backgroundColor = .blue
            
            addSubview(titleLabel)
            addSubview(preBtn)
            addSubview(nextBtn)
            
            titleLabel.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
            
            preBtn.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.right.equalTo(snp.centerX).offset(-42)
                make.width.equalTo(10)
            }
            
            nextBtn.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(snp.centerX).offset(42)
                make.width.equalTo(10)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
}
