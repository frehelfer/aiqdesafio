//
//  DividerView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import Foundation

import UIKit

class DividerView: UIView {
    
    private enum Params {
        static let lineHeight: CGFloat = 4
        static let verticalPadding: CGFloat = 16
    }
    
    // MARK: - Properties
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .grayDefault
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode
extension DividerView: ViewCode {
    func addSubviews() {
        addSubview(backgroundView)
        backgroundView.addSubview(lineView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // backgroundView
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: Params.verticalPadding),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Params.verticalPadding),
            
            // lineView
            lineView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            lineView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Params.lineHeight),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}

// MARK: - MyAbstractFactory
extension DividerView: MyAbstractFactory {
    func getCellHeight() -> CGFloat {
        Params.lineHeight + Params.verticalPadding * 2
    }
}
