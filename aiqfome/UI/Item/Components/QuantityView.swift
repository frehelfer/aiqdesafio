//
//  QuantityView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

final class QuantityView: UIView {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [priceLabel, minimumPriceLabel])
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
    
    private lazy var minimumPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textSecondary
        label.font = .customFont(ofSize: 14, weight: .semiBold)
        label.text = "total R$29,90"
        return label
    }()
    
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
        
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWith(text: "29,90")
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(text: String) {
        configureMinimunPriceLabel(text: text)
    }
    
    private func configureMinimunPriceLabel(text: String) {
        let attributedString = NSMutableAttributedString(string: "total ")
        
        let customPriceString = NSAttributedString(string: "R$ " + text, attributes: [
            .font : UIFont.customFont(ofSize: 14, weight: .bold),
            .foregroundColor : UIColor.textTertiary
        ])
        
        attributedString.append(customPriceString)
        minimumPriceLabel.attributedText = attributedString
    }
    
}

// MARK: - ViewCode
extension QuantityView: ViewCode {
    func addSubviews() {
        addSubview(stackView)
        addSubview(addButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
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

#Preview(traits: .sizeThatFitsLayout) {
    QuantityView()
}
