//
//  HeaderView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

final class HeaderView: UIView, MyAbstractFactory {
    
    // MARK: - Properties
    private lazy var aiqLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = .aiqfomeIcon.withTintColor(.whiteDefault)
        return image
    }()
    
    private lazy var locationIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = .location.withTintColor(.whiteDefault)
        return image
    }()
    
    private lazy var addressStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [descriptionLabel, addressLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 2
        view.distribution = .fill
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .purpleLight
        label.font = .customFont(ofSize: 14, weight: .bold)
        label.text = "entregando em"
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .whiteDefault
        label.font = .customFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var profileIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(.profile.withTintColor(.whiteDefault), for: .normal)
        return button
    }()
    
    // MARK: - Init
    init(address: String) {
        super.init(frame: .zero)
        configureWith(text: address)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(text: String) {
        let attributedString = NSMutableAttributedString(string: text + " ")
        let icon = NSTextAttachment(image: UIImage(resource: .chevronRight).withTintColor(.whiteDefault))
        icon.bounds = CGRect(origin: CGPoint(x: 0, y: -3.0), size: CGSize(width: 16, height: 16))
        attributedString.append(NSAttributedString(attachment: icon))
        
        addressLabel.attributedText = attributedString
    }
    
}

// MARK: - ViewCode
extension HeaderView: ViewCode {
    func addSubviews() {
        addSubview(aiqLogo)
        addSubview(locationIcon)
        addSubview(addressStack)
        addSubview(profileIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // aiqLogo
            aiqLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aiqLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            aiqLogo.widthAnchor.constraint(equalToConstant: 32),
            aiqLogo.heightAnchor.constraint(equalToConstant: 32),
            
            // locationIcon
            locationIcon.leadingAnchor.constraint(equalTo: aiqLogo.trailingAnchor, constant: 24),
            locationIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // addressStack
            addressStack.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 10),
            addressStack.trailingAnchor.constraint(equalTo: profileIcon.leadingAnchor, constant: -24),
            addressStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            addressStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            // profileIcon
            profileIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setupStyle() {
        backgroundColor = .purpleDefault
    }
}
