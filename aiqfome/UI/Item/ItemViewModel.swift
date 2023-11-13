//
//  ItemViewModel.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import UIKit

protocol ItemViewModelDelegate: AnyObject {
    func reloadTableView()
}

class ItemViewModel {
    
    weak var viewDelegate: ItemViewModelDelegate?
    
    let user: User
    let item: Item
    var customCells: [MyAbstractFactory] = []
    var cart: Cart = Cart(id: UUID(), products: [], quantity: 0, comment: "")
    
    init(user: User = User.mock, item: Item = Item.mock) {
        self.user = user
        self.item = item
        createCustomCells(user: user, item: item)
    }
    
    private func createCustomCells(user: User, item: Item) {
        self.customCells = [
            HeaderView(
                address: user.address
            ),
            InfoView(
                image: UIImage(resource: .ceviche),
                title: item.title,
                description: item.description,
                minimumPrice: item.calculateMinimumPricePossible()
            ),
            QuantityView(
                delegate: self,
                totalPrice: cart.calculateTotalPrice(),
                orderQuantity: cart.quantity
            )
        ]
        
        item.categoryList.forEach { categoryItem in
            customCells.append(DividerView())
            
            customCells.append(
                CategoryHeaderView(
                    categoryTitle: categoryItem.title,
                    isRequired: categoryItem.isRequired,
                    maxOrderQuantity: categoryItem.maxOrderQuantity
                )
            )
        }
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

extension ItemViewModel: QuantityViewProtocol {
    func addButtonTapped() {
        cart.quantity = 1
        createCustomCells(user: user, item: item)
        viewDelegate?.reloadTableView()
    }
    
    func minusButtonTapped() {
        
    }
    
    func plusButtonTapped() {
        
    }
}
