//
//  ItemTableViewCell.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 12/11/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemTableViewCell: ViewCode {
    func addSubviews() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func setupStyle() {
        selectionStyle = .none
        backgroundColor = .whiteDefault
    }
}
