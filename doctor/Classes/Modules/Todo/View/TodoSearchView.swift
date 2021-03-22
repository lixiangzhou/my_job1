//
//  TodoSearchView.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class TodoSearchView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    
    var durationClosure: ((Date, Date) -> Void)?
    var searchClosure: ((String) -> Void)?
    var typeClosure: ((String) -> Void)?
    
    // MARK: - Private Property
    let searchView = SearchField()
    
    let selView = TodoMsgSelectSearchTimeView()
    var timeSelectView: ZZImagePositionButton!
    var timeTypeView: ZZImagePositionButton!
    
    let calendar = CalendarView()
}

// MARK: - UI
extension TodoSearchView {
    private func setUI() {
        backgroundColor = .white
        addSubview(searchView)
        
        timeSelectView = ZZImagePositionButton(title: "时间区间", font: .size(12), titleColor: .c6, imageName: "todo_top_calendar", backgroundColor: .cf6f6f6, target: self, action: #selector(timeAction), imgPosition: .right, leftPadding: 6, middlePadding: 6, rightPadding: 6)
        timeSelectView.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        timeSelectView.zz_setCorner(radius: 8, masksToBounds: true)
        addSubview(timeSelectView)
        
        timeTypeView = ZZImagePositionButton(title: "已逾期", font: .size(12), titleColor: .c6, imageName: "todo_top_arrow_down", backgroundColor: .cf6f6f6, target: self, action: #selector(typeAction), imgPosition: .right, leftPadding: 14, middlePadding: 4, rightPadding: 14)
        timeTypeView.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        timeTypeView.zz_setCorner(radius: 8, masksToBounds: true)
        
        selView.selectClosure = { txt in
            print(txt)
        }
        
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.height.equalTo(32)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension TodoSearchView {
    @objc private func timeAction() {
        endEditing(true)
        
        calendar.titleLabel.text = ""
        calendar.calendar.config.mode = .duration
        calendar.finishClosure = { [weak self] _ in
            guard let self = self else { return }
            let config = self.calendar.calendar.config
            if let start = config.start, let end = config.end {
                self.durationClosure?(start.date, end.date)
            }
        }
        calendar.show()
    }
    
    @objc private func typeAction() {
        endEditing(true)
        if selView.superview != nil {
            return
        }
        selView.interactiveViews = [self]
        selView.show(from: timeTypeView, size: CGSize(width: timeTypeView.zz_width, height: 33 * 3))
    }
}

// MARK: - Helper
extension TodoSearchView {
    
}

// MARK: - Other
extension TodoSearchView {
    
}

// MARK: - Public
extension TodoSearchView {
    func addTypeView(_ addOrNot: Bool) {
        if addOrNot {
            addSubview(timeTypeView)
            
            timeSelectView.snp.makeConstraints { (make) in
                make.top.height.equalTo(searchView)
                make.left.equalTo(searchView.snp.right).offset(8)
                make.width.equalTo(timeSelectView.zz_width)
            }
            
            timeTypeView.snp.makeConstraints { (make) in
                make.top.height.equalTo(searchView)
                make.left.equalTo(timeSelectView.snp.right).offset(8)
                make.width.equalTo(timeTypeView.zz_width)
                make.right.equalTo(-16)
            }
        } else {
            timeSelectView.snp.makeConstraints { (make) in
                make.top.height.equalTo(searchView)
                make.left.equalTo(searchView.snp.right).offset(8)
                make.width.equalTo(timeSelectView.zz_width)
                make.right.equalTo(-16)
            }
        }
        
    }
}
