//
//  WorldClockVC.swift
//  Clock-Combine
//
//  Created by sejin on 2023/11/22.
//

import UIKit

final class WorldClockVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonDidTap))
        
        return button
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTap))
        
        return button
    }()
    
    private let worldClockTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setNavigationBar()
        self.setLayout()
        self.setDelegate()
    }
    
    // MARK: - Methods
    
    private func setUI() {
        self.view.backgroundColor = .black
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "세계 시계"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationItem.leftBarButtonItem = self.editButton
        self.navigationItem.rightBarButtonItem = self.addButton
        self.navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    private func setLayout() {
        [worldClockTableView].forEach { childView in
            self.view.addSubview(childView)
            childView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            worldClockTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            worldClockTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            worldClockTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            worldClockTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setDelegate() {
        self.worldClockTableView.delegate = self
        self.worldClockTableView.dataSource = self
    }
    
    // MARK: - @objc Function
    
    @objc
    private func editButtonDidTap() {
        print("편집 버튼 터치")
    }
    
    @objc
    private func addButtonDidTap() {
        print("추가 버튼 터치")
    }
}

// MARK: - UITableViewDelegate

extension WorldClockVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel: UILabel = UILabel()

        titleLabel.frame = CGRect(x: 15, y: 10, width: 200, height: 40)
        titleLabel.text = "세계 시계"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)

        let headerView = UIView()
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
}

// MARK: - UITableViewDataSource

extension WorldClockVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = [UIColor.red, .blue, .green].randomElement()!
        return cell
    }
}
