//
//  Item.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import Foundation

struct Item {
    let id: UUID
    let title: String // Ceviche de salmão
    let description: String // salmão temperado com limão, cebola e pimenta
    let categoryList: [CategoryItem]
}

struct CategoryItem {
    let id: UUID
    let title: String // qual o tamanho?
    let maxOrderQuantity: Int? // escolha 1, se nil, quantos quiser!
    let isRequired: Bool
    let products: [Product]
}

struct Product {
    let id: UUID
    let name: String // médio
    let price: Double // 19.90
    let oldPrice: Double? // 22.90
}

struct User {
    let id: UUID
    let address: String // Rua Mandaguari, 198
}

struct Cart {
    let id: UUID
    let cart: [Product]
    let quantity: Int // 0 ou 1 ou 2
    let comment: String
    let totalPrice: Double
}
