//
//  WorldClockTableViewCell.swift
//  Clock-Combine
//
//  Created by sejin on 11/28/23.
//

import UIKit

final class WorldClockTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let timeDifferenceLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘, +0시간"
        label.textColor = UIColor(hexCode: "FFFFFF", alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "서울"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "23:25"
        label.textColor = UIColor(hexCode: "FFFFFF", alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 48, weight: .light)
        return label
    }()
    
    private lazy var cityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeDifferenceLabel, cityLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    // MARK: - initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initCell(timeDifference: String, city: String, time: String) {
        self.timeDifferenceLabel.text = timeDifference
        self.cityLabel.text = city
        self.timeLabel.text = time
    }
    
    // MARK: - Methods
    
    private func setUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func setLayout() {
        [cityStackView, timeLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            cityStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
