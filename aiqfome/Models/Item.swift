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
    let imagePath: String // http path
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

extension Item {
    func calculateMinimumPricePossible() -> Double {
        var totalPrice = 0.0

        for category in categoryList where category.isRequired {
            if let minPriceProduct = category.products.min(by: { $0.price < $1.price }) {
                totalPrice += minPriceProduct.price
            }
        }

        return totalPrice
    }
}

extension Item {
    static let mock = Item(
        id: UUID(),
        title: "Ceviche de salmão",
        description: "salmão temperado com limão, cebola e pimenta",
        imagePath: "/someImagePath.jpg",
        categoryList: [
            CategoryItem(
                id: UUID(),
                title: "qual o tamanho?",
                maxOrderQuantity: 1,
                isRequired: true,
                products: [
                    Product(
                        id: UUID(),
                        name: "médio",
                        price: 19.90,
                        oldPrice: 22.90
                    ),
                    Product(
                        id: UUID(),
                        name: "grande",
                        price: 28.90,
                        oldPrice: nil
                    )
                ]
            ),
            CategoryItem(
                id: UUID(),
                title: "vai querer bebida?",
                maxOrderQuantity: nil,
                isRequired: false,
                products: [
                    Product(
                        id: UUID(),
                        name: "coca-cola",
                        price: 10,
                        oldPrice: nil
                    ),
                    Product(
                        id: UUID(),
                        name: "suco prats laranja",
                        price: 6,
                        oldPrice: nil
                    ),
                    Product(
                        id: UUID(),
                        name: "água sem gás",
                        price: 3,
                        oldPrice: nil
                    )
                ]
            ),
            CategoryItem(
                id: UUID(),
                title: "precisa de talher?",
                maxOrderQuantity: 1,
                isRequired: false,
                products: [
                    Product(
                        id: UUID(),
                        name: "hashi",
                        price: 0,
                        oldPrice: nil
                    ),
                    Product(
                        id: UUID(),
                        name: "garfo e faca descartável",
                        price: 1,
                        oldPrice: nil
                    )
                ]
            ),
            CategoryItem(
                id: UUID(),
                title: "mais alguma coisa?",
                maxOrderQuantity: 2,
                isRequired: false,
                products: [
                    Product(
                        id: UUID(),
                        name: "biscoito da sorte",
                        price: 2,
                        oldPrice: nil
                    ),
                    Product(
                        id: UUID(),
                        name: "rolinho primavera",
                        price: 8,
                        oldPrice: nil
                    )
                ]
            )
        ]
    )
}

// totalCartQuantity
// if only one and required
// if maxQuantity == nil
// if only one and not required
// if more then one and not required (square options)
// comment
