//
//  ItemViewController.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import UIKit

class ItemViewController: UIViewController {
    
    private var viewModel: ItemViewModel
    private var itemView = ItemView()
    
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

