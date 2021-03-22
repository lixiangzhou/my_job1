//
//  PatientManagerController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class PatientManagerController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
    }

    // MARK: - Public Property
    let calendar = CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_height, height: 310))
    let datePicker = DateSelectView()
    // MARK: - Private Property
}

// MARK: - UI
extension PatientManagerController {
    override func setUI() {
        
        datePicker.finishClosure = { date in
            print(date)
        }
        
//        let v1 = UIView()
        
//        let c1 = ZZCalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_height, height: 310))
//        view.addSubview(c1)
//        view.addSubview(calendar)

//        view.addSubview(calendar)
        
    }
}

// MARK: - Action
extension PatientManagerController {
    @objc func keyboardWillChangeFrameNotification(_ note: Notification) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        datePicker.show()
//        let model = calendarView.currentMonthModel
//        print(model.year, model.month)
//        calendar.show()
    }
}

// MARK: - Network
extension PatientManagerController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension PatientManagerController {
    
}

// MARK: - Other
extension PatientManagerController {
    
}

// MARK: - Public
extension PatientManagerController {
    
}
