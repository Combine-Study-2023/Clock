//
//  WorldCityTableViewCell.swift
//  Clock-Combine
//
//  Created by sejin on 12/6/23.
//

import UIKit

final class WorldCityTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
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
    
    func initCell(city: String) {
        self.cityLabel.text = city
    }
    
    // MARK: - Methods
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        [cityLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
