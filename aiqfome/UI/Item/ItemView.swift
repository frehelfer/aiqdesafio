//
//  ItemView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import UIKit

class ItemView: UIView {
    
    // MARK: - Properties
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        label.text = "Test"
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Actions
    func setupView() {
        // setup das propriedades
    }
}

// MARK: - ViewCode
extension ItemView: ViewCode {
    func addSubviews() {
        addSubview(testLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setupStyle() {
        backgroundColor = .purple
    }
}
