//
//  CategoryHeaderView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import UIKit

class CategoryHeaderView: UIView, MyAbstractFactory {
    
    // MARK: - Properties
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [verticalStack])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 8
        view.distribution = .fill
        return view
    }()
    
    private lazy var verticalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 2
        view.distribution = .fill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textPrimary
        label.font = .customFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textSecondary
        label.font = .customFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private lazy var isRequiredView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .textTertiary
        view.addSubview(isRequiredLabel)
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var isRequiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .whiteDefault
        label.font = .customFont(ofSize: 12, weight: .bold)
        label.text = "obrigatório"
        return label
    }()
    
    
    
    // MARK: - Init
    init(
        categoryTitle: String,
        isRequired: Bool,
        maxOrderQuantity: Int?
    ) {
        super.init(frame: .zero)
        titleLabel.text = categoryTitle
        configureSubtitleLabel(isRequired: isRequired, maxOrderQuantity: maxOrderQuantity)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubtitleLabel(isRequired: Bool, maxOrderQuantity: Int?) {
        if let maxOrderQuantity, isRequired {
            subtitleLabel.text = "escolha \(maxOrderQuantity)"
            horizontalStack.addArrangedSubview(isRequiredView)
        } else if let maxOrderQuantity {
            subtitleLabel.text = "escolha até \(maxOrderQuantity)"
        } else {
            subtitleLabel.text = "escolha quantos quiser"
        }
    }
}

// MARK: - ViewCode
extension CategoryHeaderView: ViewCode {
    func addSubviews() {
        addSubview(horizontalStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // horizontalStack
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            // isRequiredLabel
            isRequiredLabel.leadingAnchor.constraint(equalTo: isRequiredView.leadingAnchor, constant: 8),
            isRequiredLabel.trailingAnchor.constraint(equalTo: isRequiredView.trailingAnchor, constant: -8),
            isRequiredLabel.topAnchor.constraint(equalTo: isRequiredView.topAnchor, constant: 6),
            isRequiredLabel.bottomAnchor.constraint(equalTo: isRequiredView.bottomAnchor, constant: -6),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}
