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
    
    private lazy var buttonStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .leading
        view.spacing = 4
        view.distribution = .fill
        return view
    }()
    
    private lazy var selectorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var dollarSignIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = .money
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var rowTapButtonArea: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(selectorButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func selectorButtonTapped() {
        delegate?.selectorButtonTapped(productRowView: self, product: product)
    }
    
    // MARK: - Init
    
    private var horizontalStackLeadingConstraint: NSLayoutConstraint!
    
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
        setupViewCode()
        
        productName.text = product.name
        configureSelector(type: type, isSelected: isSelected, quantity: quantity)
        configurePriceLabel(price: product.price, oldPrice: product.oldPrice, isRequired: isRequired)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // funciona, mas ta feio, arrumar!!
    private func configurePriceLabel(price: Double, oldPrice: Double?, isRequired: Bool) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        // se tiver desconto, apresenta uma string custom e coloca o dollar ICON
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
            
            buttonStack.addArrangedSubview(dollarSignIcon)
            
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
            buttonStack.addArrangedSubview(selectorButton)
            selectorButton.setImage(isSelected ? .radioOn : .radioOff, for: .normal)
            selectorButton.isHidden = false
            quantityButton.isHidden = true
        case .select:
            buttonStack.addArrangedSubview(selectorButton)
            selectorButton.setImage(isSelected ? .selectOn : .selectOff, for: .normal)
            selectorButton.isHidden = false
            quantityButton.isHidden = true
        case .quantity:
            buttonStack.addArrangedSubview(quantityButton)
            horizontalStackLeadingConstraint.constant = 10
            quantityButton.configureWith(number: quantity)
            selectorButton.isHidden = true
            rowTapButtonArea.isHidden = true
            quantityButton.isHidden = false
        }
    }
    
    // MARK: - Internal actions
    
}

// MARK: - ViewCode
extension ProductRowView: ViewCode {
    func addSubviews() {
        addSubview(buttonStack)
        addSubview(horizontalStack)
        addSubview(rowTapButtonArea)
    }
    
    func setupConstraints() {
        
        horizontalStackLeadingConstraint = horizontalStack.leadingAnchor.constraint(equalTo: buttonStack.trailingAnchor, constant: 4)
        horizontalStackLeadingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            
            // buttonStack
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonStack.topAnchor.constraint(equalTo: horizontalStack.topAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor),
            
            // selectorImage
            selectorButton.heightAnchor.constraint(equalToConstant: 24),
            selectorButton.widthAnchor.constraint(equalToConstant: 24),
            
            // dollarSignIcon
            dollarSignIcon.heightAnchor.constraint(equalToConstant: 24),
            dollarSignIcon.widthAnchor.constraint(equalToConstant: 24),
            
            // horizontalStack
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // rowTapButtonArea
            rowTapButtonArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowTapButtonArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            
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
