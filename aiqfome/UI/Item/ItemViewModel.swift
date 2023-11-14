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
        customCells = [
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
                        quantity: cart.products.reduce(0) { $1.id == product.id ? $0 + 1 : $0 },
                        type: product.getProductType(categoryItem: categoryItem)
                    )
                )
            }
        }
        
        customCells.append(DividerView())
        customCells.append(CommentView(delegate: self, text: cart.comment))
        customCells.append(FooterView())
    }
    
    private func updateTicketButton() {
        if cart.quantity > 0 {
            viewDelegate?.shouldDisplayTicketButton(displayButton: true)
        } else {
            viewDelegate?.shouldDisplayTicketButton(displayButton: false)
        }
    }
    
    private func updateUI() {
        createCustomCells(user: user, item: item)
        viewDelegate?.reloadTableView()
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
    
    func minusButtonTapped() {
        if cart.quantity == 1 {
            cart.products.removeAll()
        }
        cart.quantity -= 1
        updateUI()
    }
    
    func plusButtonTapped() {
        if cart.quantity == 0 {
            cart.products.append(item.categoryList[0].products[0])
        }
        cart.quantity += 1
        updateUI()
    }
}

// MARK: - ProductRowViewDelegate
extension ItemViewModel: ProductRowViewDelegate {
    
    // Sorry for this 🫣🥺, but hey, it's better to be working than not. I will fix this when I have more time 🥳
    func selectorButtonTapped(productRowView: ProductRowView, product: Product) {
        
        // remove the product if it's already in the cart
        if let index = cart.products.firstIndex(where: { $0.id == product.id }) {
            cart.products.remove(at: index)
            
        } else {
            
            // get category information
            if let categoryItem = item.categoryList.first(where: { $0.products.contains(where: { $0.id == product.id }) }),
               let maxCategoryQuantity = categoryItem.maxOrderQuantity {
                
                let productsFromSameCategory = cart.products.filter { cartProduct in
                    categoryItem.products.contains { $0.id == cartProduct.id }
                }
                
                // check product quantity from the same category
                if productsFromSameCategory.count < maxCategoryQuantity {
                    cart.products.append(product)
                    
                    // If cart quantity is 0, update it to 1
                    if cart.quantity == 0 {
                        cart.quantity = 1
                    }
                    
                } else if productsFromSameCategory.count <= 1 {
                    cart.products.removeAll { productToRemove in
                        productsFromSameCategory.contains { $0.id == productToRemove.id }
                    }
                    cart.products.append(product)
                }
            }
        }
        
        updateUI()
    }
    
    func plusButtonTapped(product: Product) {
        
        if cart.quantity == 0 {
            cart.quantity = 1
        }
        
        cart.products.append(product)
        updateUI()
    }
    
    func minusButtonTapped(product: Product) {
        if let index = cart.products.firstIndex(where: { $0.id == product.id }) {
            cart.products.remove(at: index)
            updateUI()
        }
    }
}

// MARK: - CommentViewDelegate
extension ItemViewModel: CommentViewDelegate {
    
    func addComment(text: String) {
        cart.comment = text
        updateUI()
    }
}
