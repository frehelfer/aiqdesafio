//
//  Product.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import Foundation

struct Product {
    let id: UUID
    let name: String
    let price: Double
    let oldPrice: Double?
}

extension Product {
    func getProductType(categoryItem: CategoryItem) -> SelectorType {
        if let quantity = categoryItem.maxOrderQuantity {
            
            if quantity > 1 {
                return .select
            } else {
                return .radio
            }
            
        }
        
        return .quantity
    }
}
