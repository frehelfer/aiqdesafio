//
//  Cart.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import Foundation

struct Cart {
    let id: UUID
    var products: [Product]
    var quantity: Int
    var comment: String
}

extension Cart {
    func calculateTotalPrice() -> Double {
        products.reduce(0) { $0 + $1.price } * Double(quantity)
    }
}
