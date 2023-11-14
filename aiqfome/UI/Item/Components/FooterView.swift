//
//  FooterView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import UIKit

class FooterView: UIView, MyAbstractFactory {
    
    // MARK: - Properties
    private lazy var blankView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .whiteDefault
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [loveLabel, dataLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 8
        view.distribution = .fill
        return view
    }()
    
    private lazy var loveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .purpleText
        label.font = .customFont(ofSize: 14, weight: .bold)
        label.text = "feito com 💜 em maringá-PR"
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .purpleText
        label.font = .customFont(ofSize: 16, weight: .bold)
        label.text = "aiqfome.com © 2007-2023 aiqfome LTDA .\n CNPJ: 09.186.786/0001-58"
        return label
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode
extension FooterView: ViewCode {
    func addSubviews() {
        addSubview(blankView)
        addSubview(vStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // blankView
            blankView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blankView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blankView.topAnchor.constraint(equalTo: topAnchor),
            blankView.heightAnchor.constraint(equalToConstant: 39),
            
            // vStack
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            vStack.topAnchor.constraint(equalTo: blankView.bottomAnchor, constant: 24),
            vStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }
    
    func setupStyle() {
        backgroundColor = .grayDefault
    }
}
