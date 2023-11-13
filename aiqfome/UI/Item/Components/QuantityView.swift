//
//  QuantityView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

protocol QuantityViewProtocol: AnyObject {
    func addButtonTapped()
    func minusButtonTapped()
    func plusButtonTapped()
}

final class QuantityView: UIView {
    
    weak var delegate: QuantityViewProtocol?
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [priceLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 6
        view.distribution = .fill
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textTertiary
        label.font = .customFont(ofSize: 16, weight: .bold)
        label.text = "quantos?"
        return label
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textSecondary
        label.font = .customFont(ofSize: 14, weight: .semiBold)
        return label
    }()
    
    // right
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
 
        var configuration = UIButton.Configuration.plain()
        configuration.background.backgroundColor = .textSecondary
        configuration.background.cornerRadius = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        button.configuration = configuration
        
        let attributedString = NSAttributedString(string: "adicionar", attributes: [
            .font : UIFont.customFont(ofSize: 14, weight: .bold),
            .foregroundColor : UIColor.whiteDefault
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var quantityButton: QuantityButton = {
        let button = QuantityButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // button actions
    @objc func addButtonTapped() {
        delegate?.addButtonTapped()
    }
    
    // MARK: - Init
    init(
        delegate: QuantityViewProtocol,
        totalPrice: Double,
        orderQuantity: Int
    ) {
        self.delegate = delegate
        super.init(frame: .zero)
        configureTotalPriceLabel(value: totalPrice)
        configureWith(orderQuantity: orderQuantity)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureWith(orderQuantity: Int) {
        if orderQuantity == 0 {
            stackView.removeArrangedSubview(totalPriceLabel)
            addButton.layer.opacity = 1
            quantityButton.layer.opacity = 0
        } else {
            stackView.addArrangedSubview(totalPriceLabel)
            addButton.layer.opacity = 0
            quantityButton.configureWith(number: orderQuantity)
            quantityButton.layer.opacity = 1
        }
    }
    
    private func configureTotalPriceLabel(value: Double) {
        let attributedString = NSMutableAttributedString(string: "total ")
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        if let formattedString = formatter.string(from: NSNumber(value: value)) {
            
            let customPriceString = NSAttributedString(string: "R$ " + formattedString, attributes: [
                .font : UIFont.customFont(ofSize: 14, weight: .bold),
                .foregroundColor : UIColor.textTertiary
            ])
            
            attributedString.append(customPriceString)
            totalPriceLabel.attributedText = attributedString
        }
    }
    
}

// MARK: - ViewCode
extension QuantityView: ViewCode {
    func addSubviews() {
        addSubview(stackView)
        addSubview(addButton)
        addSubview(quantityButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            quantityButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            quantityButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}

// MARK: - MyAbstractFactory
extension QuantityView: MyAbstractFactory {
    func getCellHeight() -> CGFloat {
        56
    }
}
