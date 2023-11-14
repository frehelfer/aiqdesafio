//
//  ItemViewModel.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import UIKit

protocol ItemViewModelDelegate: AnyObject {
    func reloadTableView()
    func shouldDisplayTicketButton(displayButton: Bool)
}

class ItemViewModel {
    
    weak var viewDelegate: ItemViewModelDelegate?
    
    private let user: User
    private let item: Item
    private var cart: Cart {
        didSet {
            updateTicketButton()
        }
    }
        
    private var customCells: [MyAbstractFactory] = []
    
    init(
        user: User = User.mock,
        item: Item = Item.mock,
        cart: Cart = Cart(id: UUID(), products: [], quantity: 0, comment: "")
    ) {
        self.user = user
        self.item = item
        self.cart = cart
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
            
            categoryItem.products.forEach { product in
                customCells.append(
                    ProductRowView(
                        delegate: self,
                        product: product,
                        isRequired: categoryItem.isRequired,
                        isSelected: cart.products.contains(where: { $0.id == product.id }),
                        quantity: cart.products.filter({ $0.id == product.id }).count,
                        type: product.getProductType(categoryItem: categoryItem)
                    )
                )
            }
        }
        
        customCells.append(FooterView())
    }
    
    private func updateTicketButton() {
        if cart.quantity > 0 {
            viewDelegate?.shouldDisplayTicketButton(displayButton: true)
        } else {
            viewDelegate?.shouldDisplayTicketButton(displayButton: false)
        }
    }
    
    func getNumberOfCells() -> Int {
        customCells.count
    }
    
    func getCellViewForRowAt(row: Int) -> UIView {
        customCells[row].createCell()
    }
}

// MARK: - QuantityViewProtocol
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

// MARK: - ProductRowViewDelegate
extension ItemViewModel: ProductRowViewDelegate {
    
    func selectorButtonTapped(productRowView: ProductRowView, product: Product) {
        print(#function)
        cart.products.append(product)
        createCustomCells(user: user, item: item)
        viewDelegate?.reloadTableView()
    }
}
