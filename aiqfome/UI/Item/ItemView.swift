//
//  ItemView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import UIKit

class ItemView: UIView {
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    private lazy var test: UIView = {
        let tableView = HeaderView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Actions
    func setupView(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource) {
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
    }
}

// MARK: - ViewCode
extension ItemView: ViewCode {
    func addSubviews() {
        addSubview(tableView)
        addSubview(test)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // tableView
//            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            test.leadingAnchor.constraint(equalTo: leadingAnchor),
            test.trailingAnchor.constraint(equalTo: trailingAnchor),
            test.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}
