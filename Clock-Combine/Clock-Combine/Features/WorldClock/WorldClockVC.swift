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
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setNavigationBar()
        self.setLayout()
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
