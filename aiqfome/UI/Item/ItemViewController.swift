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

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

