//
//  ProductRowView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import UIKit

class ProductRowView: UIView {
    
    // MARK: - Properties
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 8
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
    
    // MARK: - Init
    init(

    ) {
        super.init(frame: .zero)
        
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubtitleLabel(isRequired: Bool, maxOrderQuantity: Int?) {
        
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
        56
    }
}
