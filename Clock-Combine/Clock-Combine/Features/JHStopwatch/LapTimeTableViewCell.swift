//
//  LapTimeTableViewCell.swift
//  Clock-Combine
//
//  Created by ParkJunHyuk on 2023/12/05.
//

import UIKit

import SnapKit

class LapTimeTableViewCell: UITableViewCell {
    
    static let identifier: String = "LapTimeTableViewCell"
    
    private var lapLabel: UILabel = {
        let label = UILabel()
        label.text = "랩1"
        label.textColor = .white
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:20.88"
        label.textColor = .white
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lapLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LapTimeTableViewCell {
    
    private func setUI() {
        self.backgroundColor = .clear
        self.addSubviews(mainStackView)
    }
    
    private func setLayout() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
