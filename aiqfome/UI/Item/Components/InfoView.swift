//
//  InfoView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

final class InfoView: UIView {
    
    // MARK: - Properties
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = .ceviche
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWith(text: "19,90")
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(text: String) {
        titleLabel.text = "Ceviche de salmão"
        configureMinimunPriceLabel(text: text)
        descriptionLabel.text = "salmão temperado com limão, cebola e pimenta"
    }
    
    private func configureMinimunPriceLabel(text: String) {
        let attributedString = NSMutableAttributedString(string: "a partir de  ")
        
        let customPriceString = NSAttributedString(string: "R$ " + text, attributes: [
            .font : UIFont.customFont(ofSize: 18, weight: .extraBold),
            .foregroundColor : UIColor.purpleDefault
        ])
        
        attributedString.append(customPriceString)
        minimunPriceLabel.attributedText = attributedString
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
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}

// MARK: - MyAbstractFactory
extension InfoView: MyAbstractFactory {
    func getCellHeight() -> CGFloat {
        310
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    InfoView()
}
