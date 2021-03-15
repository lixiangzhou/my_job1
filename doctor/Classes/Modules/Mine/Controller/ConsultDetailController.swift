//
//  ConsultDetailController.swift
//  doctor
//
//  Created by 李向洲 on 2021/3/15.
//  
//

import UIKit

class ConsultDetailController: BaseController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        viewModel.getData()
        
        DispatchQueue.main.zz_after(0.5) {
            self.titleLabel.text = "来了！中国新冠病毒疫苗冠病毒疫苗冠病毒疫苗冠病毒疫苗上市全民免费"
            self.sourceTimeLabel.text = "新闻 2021.01.16"
            self.contentLabel.text = """
生活因平凡而不凡。无数的普通人也在用手机记录着自己在春节前或温馨或忙碌的场景，这些来自平凡日常的记录也是最有感染力的语言。

我们在短视频平台众多的上传内容中，共选择了25位作者发布的视频作品，通过这一个个小窗口、小视频讲述了他们一年来的变化，也记录了一段真实而又特殊的新春记忆。
生活因平凡而不凡。无数的普通人也在用手机记录着自己在春节前或温馨或忙碌的场景，这些来自平凡日常的记录也是最有感染力的语言。

我们在短视频平台众多的上传内容中，共选择了25位作者发布的视频作品，通过这一个个小窗口、小视频讲述了他们一年来的变化，也记录了一段真实而又特殊的新春记忆。
生活因平凡而不凡。无数的普通人也在用手机记录着自己在春节前或温馨或忙碌的场景，这些来自平凡日常的记录也是最有感染力的语言。

我们在短视频平台众多的上传内容中，共选择了25位作者发布的视频作品，通过这一个个小窗口、小视频讲述了他们一年来的变化，也记录了一段真实而又特殊的新春记忆。
生活因平凡而不凡。无数的普通人也在用手机记录着自己在春节前或温馨或忙碌的场景，这些来自平凡日常的记录也是最有感染力的语言。

我们在短视频平台众多的上传内容中，共选择了25位作者发布的视频作品，通过这一个个小窗口、小视频讲述了他们一年来的变化，也记录了一段真实而又特殊的新春记忆。
生活因平凡而不凡。无数的普通人也在用手机记录着自己在春节前或温馨或忙碌的场景，这些来自平凡日常的记录也是最有感染力的语言。

我们在短视频平台众多的上传内容中，共选择了25位作者发布的视频作品，通过这一个个小窗口、小视频讲述了他们一年来的变化，也记录了一段真实而又特殊的新春记忆。

虽隔山海，爱意不减；共此屏幕，与你同在。
"""
            self.sourceLabel.text = "来源：生活记录"
            self.resetScrollViewContentSizeUnderNavigation()
        }
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    let viewModel = ConsultDetailViewModel()
    
    let titleLabel = UILabel(text: " ", font: UIFont.PingFangSC.medium.size(16), textColor: .c3)
    let sourceTimeLabel = UILabel(text: " ", font: UIFont.PingFangSC.regular.size(12), textColor: .c9)
    let dzBtn = UIButton(imageName: "mine_consult_dz", selectedImageName: "mine_consult_dz_color", target: self, action: #selector(dzAction))
    let favBtn = UIButton(imageName: "mine_consult_fav", selectedImageName: "mine_consult_fav_color", target: self, action: #selector(favAction))
    let contentLabel = UILabel(text: " ", font: .size(14), textColor: .c6)
    let sourceLabel = UILabel(text: " ", font: .size(14), textColor: .c6, textAlignment: .right)
}

// MARK: - UI
extension ConsultDetailController {
    override func setUI() {
        innerContentView.addSubview(titleLabel)
        innerContentView.addSubview(sourceTimeLabel)
        innerContentView.addSubview(dzBtn)
        innerContentView.addSubview(favBtn)
        innerContentView.addSubview(contentLabel)
        innerContentView.addSubview(sourceLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        sourceTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(17)
            make.left.equalTo(titleLabel)
        }
        
        favBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(sourceTimeLabel)
            make.width.height.equalTo(32)
        }
        
        dzBtn.snp.makeConstraints { (make) in
            make.width.height.centerY.equalTo(favBtn)
            make.right.equalTo(favBtn.snp.left)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sourceTimeLabel.snp.bottom).offset(17)
            make.left.right.equalTo(titleLabel)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom)
            make.right.equalTo(titleLabel)
            make.height.equalTo(48)
        }
    }
}

// MARK: - Action
extension ConsultDetailController {
    @objc func dzAction() {
        dzBtn.isSelected = !dzBtn.isSelected
    }
    
    @objc func favAction() {
        favBtn.isSelected = !favBtn.isSelected
    }
}

// MARK: - Network
extension ConsultDetailController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension ConsultDetailController {
    
}

// MARK: - Other
extension ConsultDetailController {
    
}

// MARK: - Public
extension ConsultDetailController {
    
}

