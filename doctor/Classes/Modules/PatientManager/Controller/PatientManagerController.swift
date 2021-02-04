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
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension PatientManagerController {
    override func setUI() {
        
    }
}

// MARK: - Action
extension PatientManagerController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        push(MyCardController())
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

