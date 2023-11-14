//
//  InfoView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

final class InfoView: UIView, MyAbstractFactory {
    
    // MARK: - Properties
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var infoStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, minimunPriceLabel, descriptionLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 6
        view.distribution = .fill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textTertiary
        label.font = .customFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var minimunPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textSecondary
        label.font = .customFont(ofSize: 14, weight: .extraBold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .textSecondary
        label.font = .customFont(ofSize: 14, weight: .semiBold)
        return label
    }()
    
    // MARK: - Init
    init(
        image: UIImage,
        title: String,
        description: String,
        minimumPrice: Double
    ) {
        super.init(frame: .zero)
        itemImage.image = image
        titleLabel.text = title
        configureMinimunPriceLabel(value: minimumPrice)
        descriptionLabel.text = description
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMinimunPriceLabel(value: Double) {
        let attributedString = NSMutableAttributedString(string: "a partir de  ")
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        if let formattedString = formatter.string(from: NSNumber(value: value)) {
            
            let customPriceString = NSAttributedString(string: formattedString, attributes: [
                .font : UIFont.customFont(ofSize: 18, weight: .extraBold),
                .foregroundColor : UIColor.purpleDefault
            ])
            
            attributedString.append(customPriceString)
            minimunPriceLabel.attributedText = attributedString
        }
    }
    
}

// MARK: - ViewCode
extension InfoView: ViewCode {
    func addSubviews() {
        addSubview(itemImage)
        addSubview(infoStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // itemImage
            itemImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImage.topAnchor.constraint(equalTo: topAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 195),
            
            // infoStack
            infoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoStack.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 16),
            infoStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}
