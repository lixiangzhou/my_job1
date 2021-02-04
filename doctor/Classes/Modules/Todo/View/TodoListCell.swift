//
//  TodoListCell.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class TodoListCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    let iconView = UIImageView()
    let nameLabel = UILabel(text: " ", font: .boldSize(16), textColor: .c3)
    let timeLabel = UILabel(text: " ", font: .size(14), textColor: .c3)
    let contentLabel = UILabel(text: " ", font: .size(14), textColor: .c3)
    let finishTimeLabel = UILabel(text: " ", font: .size(14), textColor: .c3)
    var bottomLine: UIView!
    // MARK: - Private Property
    
}

// MARK: - UI
extension TodoListCell {
    private func setUI() {
        backgroundColor = .white
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(finishTimeLabel)
        bottomLine = contentView.addBottomLine(height: 1)
        
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(8)
            make.top.equalTo(16)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.right.equalTo(-16)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.left.equalTo(iconView)
            make.right.equalTo(-16)
        }
        
        finishTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.left.right.equalTo(contentLabel)
            make.bottom.equalTo(-16)
        }
    }
}

// MARK: - Action
extension TodoListCell {
    
}

// MARK: - Helper
extension TodoListCell {
    
}

// MARK: - Other
extension TodoListCell {
    
}

// MARK: - Public
extension TodoListCell {
    
}
