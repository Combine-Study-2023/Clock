//
//  WorldCityListVC.swift
//  Clock-Combine
//
//  Created by sejin on 12/6/23.
//

import UIKit
import Combine

final class WorldCityListVC: UITableViewController {
    
    // MARK: - Properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let searchText = PassthroughSubject<String, Never>()
    
    let selectedCity = PassthroughSubject<WorldCityData, Never>()
    
    // MARK: - UI Components
    
    private let searchResultsTableController = WorldCityListResultsTableController()
    
    private lazy var searchController = UISearchController(searchResultsController: self.searchResultsTableController)
    
    private let viewModel = WorldCityListViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setSearchController()
        self.bindViews()
        self.bindViewModel()
        self.setTableView()
    }
    
    // MARK: - Methods
    
    private func setUI() {
        self.view.backgroundColor = UIColor(hexCode: "1c1c1e")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = UIColor(hexCode: "1c1c1e")
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        self.navigationController?.navigationBar.barTintColor = UIColor(hexCode: "1c1c1e")
    }
    
    private func setSearchController() {
        self.navigationItem.searchController = searchController
        self.searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "검색",
                                                                                                         attributes: [.foregroundColor: UIColor.gray])
        searchController.searchBar.searchTextField.textColor = .white
        self.navigationItem.title = "도시 선택"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    private func setTableView() {
        self.tableView.register(WorldCityTableViewCell.self, forCellReuseIdentifier: WorldCityTableViewCell.className)
    }
    
    private func bindViewModel() {
        self.viewModel
            .transform(viewDidLoad: Just<Void>(()).eraseToAnyPublisher())
            .sink { _ in
                self.tableView.reloadData()
            }.store(in: &subscriptions)
        
        self.viewModel
            .transform(searchText: searchText.eraseToAnyPublisher())
            .subscribe(searchResultsTableController.cities)
            .store(in: &subscriptions)
    }
    
    private func bindViews() {
        self.searchResultsTableController.selectedCity
            .subscribe(self.selectedCity)
            .store(in: &subscriptions)
    }
}

extension WorldCityListVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.viewModel.cities[indexPath.item]
        self.selectedCity.send(city)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldCityTableViewCell.className,
                                                       for: indexPath) as? WorldCityTableViewCell
        else { return UITableViewCell() }
        
        cell.initCell(city: self.viewModel.cities[indexPath.item].0)
        
        return cell
    }
}

extension WorldCityListVC: UISearchControllerDelegate {
}

extension WorldCityListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        self.searchText.send(text)
    }
}
