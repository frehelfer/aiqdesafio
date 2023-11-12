//
//  ItemViewModel.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import UIKit

protocol ItemViewModelDelegate: AnyObject {
    
}

class ItemViewModel {
    
    weak var viewDelegate: ItemViewModelDelegate?
    
    var customCells: [MyAbstractFactory] = [
        HeaderView()
    ]
    
    init() {
        
    }
    
    func getNumberOfCells() -> Int {
        customCells.count
    }
    
    func getCellViewForRowAt(row: Int) -> UIView {
        customCells[row].createCell()
    }
    
    func getCellHeightForRowAt(row: Int) -> CGFloat {
        customCells[row].getCellHeight()
    }
}
