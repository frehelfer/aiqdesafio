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
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .grayDefault
        return tableView
    }()
    
    private lazy var ticketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ver ticket", for: .normal)
        button.backgroundColor = .purpleDefault
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .customFont(ofSize: 16, weight: .bold)
        button.layer.opacity = 0
        button.addTarget(self, action: #selector(ticketButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func ticketButtonTapped() {
        print(#function)
    }
    
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
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func shouldDisplayTicketButton(displayButton: Bool) {
        ticketButton.layer.opacity = displayButton ? 1 : 0
    }
}

// MARK: - ViewCode
extension ItemView: ViewCode {
    func addSubviews() {
        addSubview(tableView)
        tableView.addSubview(ticketButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // tableView
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // ticketButton
            ticketButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            ticketButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            ticketButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ticketButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupStyle() {
        backgroundColor = .purpleDefault
    }
}
