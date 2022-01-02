//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import UIKit

class PokemonListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var imageSmall: UIImageView!

    func configure(title: String, imageName: String) {
        titleLabel.text = title.capitalized
        imageSmall.image = UIImage(named: imageName)
    }
}
