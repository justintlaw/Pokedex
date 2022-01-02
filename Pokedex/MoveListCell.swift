//
//  MoveListCell.swift
//  Pokedex
//
//  Created by Justin on 1/2/22.
//

import UIKit

class MoveListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title.capitalized
    }
}
