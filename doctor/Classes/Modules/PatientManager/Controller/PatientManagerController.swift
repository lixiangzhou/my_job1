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
    let calendarView = ZZCalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 400))
    // MARK: - Private Property
}

// MARK: - UI
extension PatientManagerController {
    override func setUI() {
        
//        view.backgroundColor = .yellow
        
        
        calendarView.zz_setBorder(color: .cf5f5f5, width: 1)
        calendarView.zz_setCorner(radius: 5, masksToBounds: true)
        view.addSubview(calendarView)
        
        calendarView.selectMonthClosure = { model in
            print(model.year, model.month)
        }
    }
}

// MARK: - Action
extension PatientManagerController {
    @objc func keyboardWillChangeFrameNotification(_ note: Notification) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let model = calendarView.currentMonthModel
        print(model.year, model.month)
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
