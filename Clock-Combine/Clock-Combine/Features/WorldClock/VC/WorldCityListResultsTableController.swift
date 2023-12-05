//
//  WorldCityListResultsTableController.swift
//  Clock-Combine
//
//  Created by sejin on 12/6/23.
//

import UIKit
import Combine

final class WorldCityListResultsTableController: UITableViewController {
    
    // MARK: - Properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    let cities = CurrentValueSubject<[WorldCityData], Never>([])
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.bind()
    }
    
    private func setUI() {
        self.view.backgroundColor = UIColor(hexCode: "1c1c1e")
        self.tableView.register(WorldCityTableViewCell.self, forCellReuseIdentifier: WorldCityTableViewCell.className)
    }
    
    private func bind() {
        cities.sink { _ in
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldCityTableViewCell.className,
                                                       for: indexPath) as? WorldCityTableViewCell
        else { return UITableViewCell() }
        
        cell.initCell(city: self.cities.value[indexPath.item].0)
        
        return cell
    }
}
