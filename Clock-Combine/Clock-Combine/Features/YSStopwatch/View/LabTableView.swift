//
//  LabTableView.swift
//  Clock-Combine
//
//  Created by yeonsu on 12/4/23.
//

import UIKit
import SnapKit

final class LabTableView: UIView {

    // MARK: - Properties
    
    var index: Int = 0
    
    // MARK: - UI Components
    
    lazy var tableView: UITableView = {
        lazy var tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .none
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        tableView.isScrollEnabled = true
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        return tableView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions
extension LabTableView {
    func setUI() {
        
    }
    
    func setHierarchy() {
        addSubviews(tableView)
    }
    
    func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAddTarget() {

    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        LabTableViewCell.register(tableView: tableView)
    }
    
    func setDataBind() {
        
    }
}
