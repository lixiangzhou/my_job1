//
//  BindMobileController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/20.
//  
//

import UIKit
import ReactiveSwift

class BindMobileController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationStyle(.transparency)
    }
    // MARK: - Public Property
    
    // MARK: - Private Property
    private var mobileView = InputFieldView.commonFieldView(leftImage: nil, font: UIFont.PingFangSC.semibold.size(20), placeholder: "", rightSpacing: 0, bottomLineColor: .cf5f5f5)
    
    private var (codeView, codeBtn, timeLabel) = InputFieldView.codeFieldView(placeholder: "", bottomLineColor: .cf5f5f5)
    
    private let confirmBtn = UIButton(title: "确定绑定", font: .size(14), titleColor: .white, target: self, action: #selector(confirmAction))
    
    private let viewModel = LoginViewModel()
}

// MARK: - UI
extension BindMobileController {
    override func setUI() {
        view.backgroundColor = .white
        hideNavigation = true
        
        let closeBtn = UIButton(imageName: "", target: self, action: #selector(closeAction))
        closeBtn.backgroundColor = .blue
        view.addSubview(closeBtn)
        
        let loginTitleLabel = UILabel(text: "绑定手机号", font: .boldSize(24), textColor: .c3)
        view.addSubview(loginTitleLabel)
        
        let loginDescLabel = UILabel(text: "您好，欢迎来到宝霖医生！", font: .size(18), textColor: .c6)
        view.addSubview(loginDescLabel)
        
        let placeholderAttrDict = [NSAttributedString.Key.font: UIFont.size(16), NSAttributedString.Key.foregroundColor: UIColor.c9]
        
        let mobileLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 42))
        mobileLeftView.zz_add(subview: UILabel(text: "+86", font: UIFont.PingFangSC.semibold.size(20), textColor: .c3), frame: CGRect(x: 0, y: 0, width: 37, height: 42))
        let mobileArrowView = mobileView.zz_add(subview: UIImageView(image: UIImage(named: "")), frame: CGRect(x: 45, y: 0, width: 6, height: 42))
        mobileArrowView.backgroundColor = .blue
        mobileArrowView.contentMode = .center
        mobileView.addSubview(mobileLeftView)
        
        mobileView.leftViewSize = CGSize(width: 65, height: 42)
        mobileView.left2InputViewPadding = 0
        mobileView.textField.textContentType = .username
        mobileView.textFont = UIFont.PingFangSC.semibold.size(20)
        mobileView.textField.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: placeholderAttrDict)
//        mobileView.setMobileInputRule()
       
        codeBtn.setTitleColor(.c4167f3, for: .normal)
        codeBtn.isEnabled = false
        
        codeView.left2InputViewPadding = 0
        codeView.leftViewSize = .zero
        codeView.textFont = UIFont.PingFangSC.semibold.size(20)
        codeView.attributedPlaceholder = NSAttributedString(string: "请输入验证码", attributes: placeholderAttrDict)
//        codeView.setCodeInputRule()
        
        view.addSubview(mobileView)
        view.addSubview(codeView)
        
        confirmBtn.zz_setCorner(radius: 4, masksToBounds: true)
        confirmBtn.isEnabled = false
        confirmBtn.backgroundColor = UIColor.c4167f3.withAlphaComponent(0.4)
        view.addSubview(confirmBtn)
        
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalTo(32)
        }
        
        loginTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(128)
            make.left.equalTo(32)
        }
        
        loginDescLabel.snp.makeConstraints { (make) in
            make.top.equalTo(loginTitleLabel.snp.bottom).offset(16)
            make.left.equalTo(loginTitleLabel)
        }
        
        mobileView.snp.makeConstraints { (make) in
            make.top.equalTo(loginDescLabel.snp.bottom).offset(22)
            make.left.equalTo(loginTitleLabel)
            make.right.equalTo(-32)
            make.height.equalTo(42)
        }
        
        codeView.snp.makeConstraints { (make) in
            make.top.equalTo(mobileView.snp.bottom).offset(16)
            make.left.right.height.equalTo(mobileView)
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(codeView.snp.bottom).offset(60)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(42)
        }
        
    }
    
    override func setBinding() {
        
        let mobileEnabledSignal = SignalProducer<Bool, Never>(value: !(mobileView.textField.text ?? "").isEmpty).concat(mobileView.fieldTxtChangeSignal.map { !$0.isEmpty })
        
        let codeEnabledSignal = SignalProducer<Bool, Never>(value: !(codeView.textField.text ?? "").isEmpty).concat(codeView.fieldTxtChangeSignal.map { !$0.isEmpty })
       
        let codeLoginEnabledSignal = mobileEnabledSignal.and(codeEnabledSignal)
        
        confirmBtn.reactive.isEnabled <~ codeLoginEnabledSignal
        confirmBtn.reactive.backgroundColor <~ codeLoginEnabledSignal.map { UIColor.c4167f3.withAlphaComponent($0 ? 1 : 0.4) }
        
        codeBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            guard let self = self else { return }
            
            self.timeLabel.isHidden = true
            self.codeBtn.isHidden = false
            
            let mobile = self.mobileView.text!
            if !mobile.isMatchMobile {
                HUD.show(toast: "请输入正确的手机号！", in: self.view)
                self.timeLabel.isHidden = true
                self.codeBtn.isHidden = false
                return
            }
            
            self.viewModel.getCodeAndUpdateUI(mobile: mobile, timeLabel: self.timeLabel, codeBtn: self.codeBtn, codeView: self.codeView)
        }

        codeBtn.reactive.isEnabled <~ mobileView.editingChangedSignal.map { !$0.isEmpty }
    }
}

// MARK: - Action
extension BindMobileController {
    @objc private func confirmAction(_ sender: UIButton) {
        view.endEditing(true)
        let mobile = mobileView.text!
        
        var code: String?
        
    }
    
    @objc private func closeAction() {
        pop()
    }
}
