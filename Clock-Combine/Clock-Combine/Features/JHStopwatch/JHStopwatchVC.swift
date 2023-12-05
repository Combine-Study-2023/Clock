//
//  JHStopwatchVC.swift
//  Clock-Combine
//
//  Created by sejin on 2023/11/22.
//

import UIKit

import SnapKit
import Combine

class JHStopwatchVC: UIViewController {
    
    private let leftButton = StopwatchButton(type: .reset)
    private let rightButton = StopwatchButton(type: .start)
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 90)
        label.text = "00:00.00"
        return label
    }()
    
    private var lapTimeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        setUI()
        setLayout()
        setDelegate()
        setTarget()
    }
}

extension JHStopwatchVC {
    
    private func setUI() {
        self.view.addSubviews(timeLabel, leftButton, rightButton, lapTimeTableView)
    }
    
    private func setLayout() {
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(171)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(leftButton.snp.top).offset(-100)
        }
        
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(lapTimeTableView.snp.top).offset(-16)
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(lapTimeTableView.snp.top).offset(-16)
        }
        
        lapTimeTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        self.lapTimeTableView.delegate = self
        self.lapTimeTableView.dataSource = self
        
        lapTimeTableView.register(LapTimeTableViewCell.self, forCellReuseIdentifier: "LapTimeTableViewCell")
    }
    
    private func setTarget() {
        leftButton.addTarget(self, action: #selector(tapLeftButton), for: .touchUpInside)
        
        rightButton.addTarget(self, action: #selector(tapRightButton), for: .touchUpInside)
    }
}

extension JHStopwatchVC: UITableViewDelegate {
    
}

extension JHStopwatchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LapTimeTableViewCell.identifier, for: indexPath) as? LapTimeTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension JHStopwatchVC {
    
    @objc func tapLeftButton() {
        print("좌측 버튼:", leftButton.titleType)
        leftButton.titleType = changeButtonType(type: leftButton.titleType)
    }
    
    @objc func tapRightButton() {
        print("우측 버튼:", rightButton.titleType)
        rightButton.titleType = changeButtonType(type: rightButton.titleType)
        leftButton.titleType = changeButtonType(type: leftButton.titleType)
    }
    
    private func changeButtonType(type: StopwatchButtonType) -> StopwatchButtonType {
        switch type {
        case .start:
            return .stop
        case .stop:
            return .start
        case .lap:
            return .reset
        case .reset:
            return .lap
        }
    }
}
