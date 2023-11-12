//
//  UIFont+Extensions.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

extension UIFont {

    enum CustomWeight {
        case regular
        case bold
        case black

        func getName() -> String {
            switch self {
            case .regular:
                return "Regular"
            case .bold:
                return "Bold"
            case .black:
                return "Black"
            }
        }
    }

    class func customFont(ofSize size: CGFloat, weight: CustomWeight = .regular) -> UIFont {
        guard let font = UIFont(name: "Nunito-\(weight.getName())", size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }

}
