//
//  ProductRowView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import UIKit

enum SelectorType {
    case radio
    case select
    case quantity
}

class ProductRowView: UIView {
    
    // MARK: - Properties
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [productName])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 8
        view.distribution = .fill
        return view
    }()
    
    private lazy var selectorImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textSecondary
        label.font = .customFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .purpleText
        label.font = .customFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var quantityButton: QuantityButton = {
        let button = QuantityButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.opacity = 1
        return button
    }()
    
    // MARK: - Init
    init(
        product: Product,
        isRequired: Bool,
        isSelected: Bool,
        quantity: Int,
        type: SelectorType
    ) {
        super.init(frame: .zero)
        productName.text = product.name
        configurePriceLabel(price: product.price, oldPrice: product.oldPrice, isRequired: isRequired)
        configureSelector(type: type, isSelected: isSelected, quantity: quantity)
        
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // funciona, mas ta feio, arrumar depois
    private func configurePriceLabel(price: Double, oldPrice: Double?, isRequired: Bool) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        // se tiver desconto, apresenta uma string custom
        if
            let oldPrice,
            let formattedOldePrice = formatter.string(from: NSNumber(value: oldPrice)) {
            
            let attributedString = NSMutableAttributedString(
                string: "de " + formattedOldePrice + " por ",
                attributes: [
                    .font : UIFont.customFont(ofSize: 12, weight: .bold),
                    .foregroundColor : UIColor.textSecondary
                ]
            )
            
            if let formattedCurrentPrice = formatter.string(from: NSNumber(value: price)) {
                
                let customPriceString = NSAttributedString(string: formattedCurrentPrice, attributes: [
                    .font : UIFont.customFont(ofSize: 14, weight: .bold),
                    .foregroundColor : UIColor.greenDefault
                ])
                
                attributedString.append(customPriceString)
                horizontalStack.addArrangedSubview(priceLabel)
                priceLabel.attributedText = attributedString
            }
            
        // se não, apresenta o valor Roxo bold, se não for obrigatorio, coloca um + na frente
        } else {
            if price > 0 {
                if let formattedString = formatter.string(from: NSNumber(value: price)) {
                    horizontalStack.addArrangedSubview(priceLabel)
                    priceLabel.text = isRequired ? formattedString : "+" + formattedString
                }
            }
        }
    }
    
    private func configureSelector(type: SelectorType, isSelected: Bool, quantity: Int) {
        switch type {
        case .radio:
            selectorImage.image = isSelected ? .radioOn : .radioOff
        case .select:
            selectorImage.image = isSelected ? .selectOn : .selectOff
        case .quantity:
            quantityButton.configureWith(number: quantity)
        }
    }
}

// MARK: - ViewCode
extension ProductRowView: ViewCode {
    func addSubviews() {
        addSubview(horizontalStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // horizontalStack
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}

// MARK: - MyAbstractFactory
extension ProductRowView: MyAbstractFactory {
    func getCellHeight() -> CGFloat {
        44
    }
}
