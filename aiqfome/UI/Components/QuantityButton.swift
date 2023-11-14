//
//  QuantityButton.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import UIKit

final class QuantityButton: UIView {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [minusButton, numberLabel, plusButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 4
        view.distribution = .fill
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .textTertiary
        label.font = .customFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.minus, for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.plus, for: .normal)
        return button
    }()
    
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(number: Int) {
        numberLabel.text = String(number)
        
        if number == 0 {
            minusButton.setImage(.minusDisabled, for: .normal)
            minusButton.isEnabled = false
        } else if number == 1 {
            minusButton.setImage(.trash, for: .normal)
            minusButton.isEnabled = true
        } else {
            minusButton.setImage(.minus, for: .normal)
            minusButton.isEnabled = true
        }
    }
    
}

// MARK: - ViewCode
extension QuantityButton: ViewCode {
    func addSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            numberLabel.heightAnchor.constraint(equalToConstant: 32),
            numberLabel.widthAnchor.constraint(equalToConstant: 28),
//            numberLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
//            numberLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}
