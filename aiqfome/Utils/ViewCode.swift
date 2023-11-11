//
//  ViewCode.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 11/11/23.
//

import Foundation

protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setupViewCode() {
        addSubviews()
        setupConstraints()
        setupStyle()
    }
}
