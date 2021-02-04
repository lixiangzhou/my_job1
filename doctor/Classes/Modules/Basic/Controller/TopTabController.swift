//
//  TopTabController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit
import ReactiveSwift

let clickTabIndexProperty = MutableProperty<Int>(0)
let dragTabIndexProperty = MutableProperty<Int>(0)

class TopTabController: LLSegmentViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationStyle(.allWhite)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func getTabControllers() -> [UIViewController] {
        fatalError()
    }
    
    var tabControllers: [UIViewController]!

    // MARK: - Public Property
}
// MARK: - UI
extension TopTabController {
    override func setUI() {
        loadSegmentedConfig()
        segmentCtlView.delegate = self
    }
    
    override func setBinding() {
        clickTabIndexProperty.signal.observeValues { [weak self] (idx) in
            
        }
        
        dragTabIndexProperty.signal.skipRepeats().observeValues { [weak self] (idx) in
            
        }
    }
    
    override func loadCtls() {
        tabControllers = getTabControllers()
        reloadViewControllers(ctls: tabControllers)
    }
}

// MARK: -
extension TopTabController: LLSegmentedControlDelegate {
    func segMegmentCtlView(segMegmentCtlView: LLSegmentedControl, clickItemAt sourceItemView: LLSegmentBaseItemView, to destinationItemView: LLSegmentBaseItemView) {
        clickTabIndexProperty.value = destinationItemView.index
    }
    
    func segMegmentCtlView(segMegmentCtlView: LLSegmentedControl, dragToScroll leftItemView: LLSegmentBaseItemView, rightItemView: LLSegmentBaseItemView) {
        if rightItemView.index == leftItemView.index {
            dragTabIndexProperty.value = rightItemView.index
        }
    }
    
    func segMegmentCtlView(segMegmentCtlView: LLSegmentedControl, totalPercent: CGFloat) {
        
    }
}

// MARK: -
extension TopTabController {
    /// 解决在iPhone X上滑动联动的BUG，子View 不随着滑动
    override func scrollView(scrollView: LLContainerScrollView, shouldScrollWithSubView subView: UIScrollView) -> Bool {
        return false
    }
}
