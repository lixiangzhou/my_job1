//
//  PatientManagerController.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

//class PatientManagerController: TopTabController {
//
//    // MARK: - Life Cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func getTabControllers() -> [UIViewController] {
//        allVC.title = "AAA"
//        toSeeDoctorVC.title = "AAA"
//        toDiagnosisVC.title = "AAA"
//        toTreatmengVC.title = "AAA"
//        inHospitalVC.title = "AAA"
//        outHospitalVC.title = "AAA"
////        return [allVC, toSeeDoctorVC]
//        return [allVC, toSeeDoctorVC, toDiagnosisVC, toTreatmengVC, inHospitalVC, outHospitalVC]
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setNavigationStyle(.allWhite)
//    }
//
//    // MARK: - Public Property
////    let todoListVC = TodoListController()
////    let msgListVC = MsgListController()
//    // MARK: - Private Property
//
//    // 全部
//    let allVC = PatientManagerListController()
//    // 待就诊
//    let toSeeDoctorVC = PatientManagerListController()
//    // 待诊断
//    let toDiagnosisVC = PatientManagerListController()
//    // 待治疗
//    let toTreatmengVC = PatientManagerListController()
//    // 住院
//    let inHospitalVC = PatientManagerListController()
//    // 出院
//    let outHospitalVC = PatientManagerListController()
//}
//
//// MARK: - UI
//extension PatientManagerController {
//    override func setUI() {
//        super.setUI()
//    }
//}
//
//// MARK: - Action
//extension PatientManagerController {
////    func searchAction() {
////        let vc = TodoMsgSearchController()
////        push(vc)
////    }
//}

class PatientManagerController: TopTabController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setNavigationStyle(.allWhite)
    }

    override func getTabControllers() -> [UIViewController] {
        allVC.viewModel.title = "全部"
        toSeeDoctorVC.viewModel.title = "待就诊"
        toDiagnosisVC.viewModel.title = "待诊断"
        toTreatmengVC.viewModel.title = "待治疗"
        inHospitalVC.viewModel.title = "住院"
        outHospitalVC.viewModel.title = "出院"
//        return [allVC, toSeeDoctorVC]
        return [allVC, toSeeDoctorVC, toDiagnosisVC, toTreatmengVC, inHospitalVC, outHospitalVC]
    }


    // MARK: - Public Property
    // MARK: - Private Property

    let topView = PatientManagerTopView()

    // 全部
    let allVC = PatientManagerListController()
    // 待就诊
    let toSeeDoctorVC = PatientManagerListController()
    // 待诊断
    let toDiagnosisVC = PatientManagerListController()
    // 待治疗
    let toTreatmengVC = PatientManagerListController()
    // 住院
    let inHospitalVC = PatientManagerListController()
    // 出院
    let outHospitalVC = PatientManagerListController()

}

// MARK: - UI
extension PatientManagerController {
    override func setUI() {
        super.setUI()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(testAction))
        
        view.backgroundColor = .white
        view.addSubview(topView)

        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    override func layoutContentView() {
        self.layoutInfo.segmentControlPositionType = .top(size: CGSize.init(width: UIScreen.main.bounds.width, height: 40), offset:40)
        self.relayoutSubViews()
    }

    override func setUpSegmentStyle() {
        let itemStyle = LLSegmentItemTitleViewStyle()
        itemStyle.selectedColor = UIColor.c3
        itemStyle.unSelectedColor = UIColor.c3
        itemStyle.selectedTitleScale = 1
        itemStyle.titleLabelCenterOffsetY = 6

        segmentCtlView.backgroundColor = UIColor.white

        segmentCtlView.bottomSeparatorStyle = (1, UIColor.cf5f5f5) //分割线
        segmentCtlView.indicatorView.widthChangeStyle = .stationary(baseWidth: 32)//横杆宽度:有默认值
        segmentCtlView.indicatorView.centerYGradientStyle = .bottom(margin: 0)//横杆位置:有默认值
        segmentCtlView.indicatorView.backgroundColor = .c4167f3
        segmentCtlView.indicatorView.zz_setCorner(radius: 1, masksToBounds: true)
        segmentCtlView.indicatorView.shapeStyle = .custom //形状样式:有默认值

        var segmentedCtlStyle = LLSegmentedControlStyle()
        segmentedCtlStyle.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        segmentedCtlStyle.segmentItemViewClass = PatientManagerItemView.self  //ItemView和ItemViewStyle要统一对应
        segmentedCtlStyle.itemViewStyle = itemStyle
        segmentCtlView.reloadData(ctlViewStyle: segmentedCtlStyle)
    }
}

extension PatientManagerController {
    @objc func testAction() {
//        UIView.animate(withDuration: 0.15) {
            self.segmentCtlView.reLayoutItemViews()
            self.segmentCtlView.indicatorView.reloadLayout(leftItemView: self.segmentCtlView.leftItemView, rightItemView: self.segmentCtlView.rightItemView)
//        }
    }
}
