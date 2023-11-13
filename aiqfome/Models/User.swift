//
//  User.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import Foundation

struct User {
    let id: UUID
    let address: String
}

extension User {
    static let mock = User(
        id: UUID(),
        address: "Rua Mandaguari, 198"
    )
}
