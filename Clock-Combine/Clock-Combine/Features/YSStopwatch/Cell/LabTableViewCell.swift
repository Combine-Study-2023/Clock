//
//  LabTableViewCell.swift
//  Clock-Combine
//
//  Created by yeonsu on 12/4/23.
//

import UIKit
import SnapKit

final class LabTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier: String = "LabTableViewCell"
    
    // MARK: - UI Components
    public let lapLabel: UILabel = {
        let label = UILabel()
        label.text = "랩"
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        let fontSize = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: fontSize)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    public let diffLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        let fontSize = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: fontSize)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Life Cycles

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions
extension LabTableViewCell {
    func setUI() {
        
    }
    
    func setHierarchy() {
        addSubviews(lapLabel, diffLabel)
    }
    
    func setLayout() {
        lapLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        diffLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(lapLabel)
        }
    }
    
    public static func register(tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: self.reuseIdentifier)
    }
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
