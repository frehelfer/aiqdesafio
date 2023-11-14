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

protocol ProductRowViewDelegate: AnyObject {
    func selectorButtonTapped(productRowView: ProductRowView, product: Product)
    func plusButtonTapped(product: Product)
    func minusButtonTapped(product: Product)
}

class ProductRowView: UIView, MyAbstractFactory {
    
    weak var delegate: ProductRowViewDelegate?
    let product: Product
    
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
    
    private lazy var selectorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(selectorButtonTapped), for: .touchUpInside)
        return button
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
        let button = QuantityButton(delegate: self)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc private func selectorButtonTapped() {
        delegate?.selectorButtonTapped(productRowView: self, product: product)
    }
    
    // MARK: - Init
    init(
        delegate: ProductRowViewDelegate,
        product: Product,
        isRequired: Bool,
        isSelected: Bool,
        quantity: Int,
        type: SelectorType
    ) {
        self.delegate = delegate
        self.product = product
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
            selectorButton.setImage(isSelected ? .radioOn : .radioOff, for: .normal)
            selectorButton.isHidden = false
            quantityButton.isHidden = true
        case .select:
            selectorButton.setImage(isSelected ? .selectOn : .selectOff, for: .normal)
            selectorButton.isHidden = false
            quantityButton.isHidden = true
        case .quantity:
            quantityButton.configureWith(number: quantity)
            selectorButton.isHidden = true
            quantityButton.isHidden = false
        }
    }
    
    // MARK: - Internal actions
    
}

// MARK: - ViewCode
extension ProductRowView: ViewCode {
    func addSubviews() {
        addSubview(baseView)
        baseView.addSubview(quantityButton)
        baseView.addSubview(selectorButton)
        addSubview(horizontalStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            baseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            baseView.centerYAnchor.constraint(equalTo: horizontalStack.centerYAnchor),
            
            // quantityButton
            quantityButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            quantityButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            quantityButton.topAnchor.constraint(equalTo: baseView.topAnchor),
            quantityButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
//            quantityButton.widthAnchor.constraint(equalToConstant: 96),
//            quantityButton.heightAnchor.constraint(equalToConstant: 28),
            
            // selectorImage
            selectorButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            selectorButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            selectorButton.topAnchor.constraint(equalTo: baseView.topAnchor),
            selectorButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            
            
            // horizontalStack
            horizontalStack.leadingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: 4),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}

// MARK: - TitleQuantityButtonProtocol
extension ProductRowView: QuantityButtonProtocol {
   func plusButtonTapped() {
       delegate?.plusButtonTapped(product: product)
   }
   
   func minusButtonTapped() {
       delegate?.minusButtonTapped(product: product)
   }
}
