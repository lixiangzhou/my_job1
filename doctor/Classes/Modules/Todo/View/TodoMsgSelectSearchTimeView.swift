//
//  TodoMsgSelectSearchTimeView.swift
//  doctor
//
//  Created by 李向洲 on 2021/2/3.
//  
//

import UIKit

class TodoMsgSelectSearchTimeView: BaseView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Property
    var dataSource = ["排序推荐", "最新日期"]
    var interactiveViews: [UIView]? = nil
    
    // MARK: - Private Property
    let tableView = UITableView()
    let bgView = UIView(bgColor: UIColor(white: 0, alpha: 0.6))
}

// MARK: - UI
extension TodoMsgSelectSearchTimeView {
    private func setUI() {
        frame = UIScreen.main.bounds
        let snapView = UIImageView()
        snapView.isUserInteractionEnabled = true
        snapView.image = UIApplication.shared.keyWindow?.zz_snapshotImage()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        snapView.addGestureRecognizer(tap)
        
        bgView.isUserInteractionEnabled = false
        
        addSubview(snapView)
        snapView.addSubview(bgView)
        
        tableView.backgroundColor = .clear
        tableView.set(dataSource: self, delegate: self, rowHeight: 33)
        tableView.register(cell: TodoMsgSelectSearchTimeCell.self)
        tableView.isScrollEnabled = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 8), bgColor: .white)
        tableView.tableFooterView = RoundOptionView.bottomRoundView()
        
        addSubview(tableView)
        
        snapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(tableView)
        }
    }
}

// MARK: - Action
extension TodoMsgSelectSearchTimeView {
    
}

// MARK: - Helper
extension TodoMsgSelectSearchTimeView {
    
}

// MARK: - Other
extension TodoMsgSelectSearchTimeView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let superView = superview else { return nil }
        let views = (interactiveViews ?? []) + tableView.visibleCells
        for view in views {
            let p = view.convert(point, from: superView)
            if let result = view.hitTest(p, with: event) {
                return result
            }
        }
        
        return super.hitTest(point, with: event)
    }
}

// MARK: - Public
extension TodoMsgSelectSearchTimeView {
    /// 调用之前要先设置DataSource
    func show(from view: UIView) {
        let window = UIApplication.shared.keyWindow!
        let rect = view.convert(view.bounds, to: window)
        
        window.addSubview(self)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(rect.maxY)
            make.left.right.equalToSuperview()
            make.height.equalTo(dataSource.count * 33 + 16)
        }
    }
    
    @objc func hide() {
        if superview != nil {
            removeFromSuperview()
            print(#function)
        }
    }
}

extension TodoMsgSelectSearchTimeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: TodoMsgSelectSearchTimeCell.self, for: indexPath)
        cell.txtLabel.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}

class TodoMsgSelectSearchTimeCell: UITableViewCell {
    
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
    
    let txtLabel = UILabel(text: " ", font: .size(12), textColor: .c3, textAlignment: .center)
    // MARK: - Private Property
    
}

// MARK: - UI
extension TodoMsgSelectSearchTimeCell {
    private func setUI() {
        backgroundColor = .white
        contentView.addSubview(txtLabel)
        
        txtLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
