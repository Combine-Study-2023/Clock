//
//  WorldCityListVC.swift
//  Clock-Combine
//
//  Created by sejin on 12/6/23.
//

import UIKit
import Combine

final class WorldCityListVC: UIViewController {
    
    // MARK: - Properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let viewModel = WorldCityListViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setSearchController()
        self.setLayout()
        self.setTableView()
        self.bindViewModel()
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
    }
    
    private func setLayout() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(WorldCityTableViewCell.self, forCellReuseIdentifier: WorldCityTableViewCell.className)
    }
    
    private func bindViewModel() {
        self.viewModel
            .transform(viewDidLoad: Just<Void>(()).eraseToAnyPublisher())
            .sink { _ in
                self.tableView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension WorldCityListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldCityTableViewCell.className,
                                                       for: indexPath) as? WorldCityTableViewCell
        else { return UITableViewCell() }
        
        cell.initCell(city: viewModel.cities[indexPath.item])
        
        return cell
    }
}
