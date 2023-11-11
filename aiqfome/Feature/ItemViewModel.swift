//
//  ItemViewModel.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import Foundation

protocol ItemViewModelDelegate: AnyObject {
    
}

class ItemViewModel {
    
    weak var viewDelegate: ItemViewModelDelegate?
    
    init() {
        
    }
}
