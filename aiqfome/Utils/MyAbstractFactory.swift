//
//  MyAbstractFactory.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

protocol MyAbstractFactory {
    func createCell() -> UIView
    func getCellHeight() -> CGFloat
}

extension MyAbstractFactory where Self: UIView {
    
    func createCell() -> UIView {
        return self
    }
}
