//
//  YSStopwatchVC.swift
//  Clock-Combine
//
//  Created by sejin on 2023/11/22.
//

import UIKit

final class YSStopwatchVC: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let stopwatchView = YSStopwatchView()
    private lazy var tableView = stopwatchView.lapTableView.tableView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = stopwatchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions
extension YSStopwatchVC {
    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Network

extension YSStopwatchVC {
    func getAPI() {
        
    }
}

extension YSStopwatchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension YSStopwatchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopwatchView.lapTableviewData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabTableViewCell.identifier, for: indexPath) as? LabTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        let lap = stopwatchView.lapTableviewData.count - (indexPath as NSIndexPath).row
        cell.lapLabel.text = "랩 \(lap)"
        cell.diffLabel.text = "\(stopwatchView.diffTableViewData[lap-1])"

        return cell
    }

}
