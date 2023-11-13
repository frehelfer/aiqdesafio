//
//  ItemViewController.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import UIKit

class ItemViewController: UIViewController {
    
    private lazy var itemView: ItemView = {
        let view = ItemView()
        view.setupView(tableViewDelegate: self, tableViewDataSource: self)
        return view
    }()
    
    private var viewModel: ItemViewModel
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.viewDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = itemView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension ItemViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = viewModel.getCellViewForRowAt(row: indexPath.row)
        let cell = MyTableViewCell(style: .default, reuseIdentifier: MyTableViewCell.identifier)
        cell.configure(with: view)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getCellHeightForRowAt(row: indexPath.row)
    }
}

// MARK: - ItemViewModelDelegate
extension ItemViewController: ItemViewModelDelegate {
    func reloadTableView() {
        itemView.reloadTableView()
        print(#function)
    }
}

