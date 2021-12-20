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
    
//    func configure(
//        id: Int,
//        name: String,
//        height: Int,
//        weight: Int,
//        base_experience: Int,
//        hp: Int,
//        attack: Int,
//        defense: Int,
//        speed: Int,
//        img_sprite: String,
//        img_full: String
//    ) {
//        titleLabel.text = name.capitalized
//    }

    func configure(title: String, imageName: String) {
        titleLabel.text = title.capitalized
        
        print("image name: \(imageName)")
        imageSmall.image = UIImage(named: imageName)
    }
}


//
//  ReminderListCell.swift
//  Today
//
//  Created by Justin on 12/15/21.
//

//import UIKit
//
//class ReminderListCell: UITableViewCell {
//    typealias DoneButtonAction = () -> Void
//
//    @IBOutlet var titleLabel: UILabel!
//    @IBOutlet var dateLabel: UILabel!
//    @IBOutlet var doneButton: UIButton!
//
//
//    private var doneButtonAction: DoneButtonAction?
//
//    @IBAction func doneButtonTriggered(_ sender: UIButton) {
//        doneButtonAction?()
//    }
//
//    func configure(title: String, dateText: String, isDone: Bool, doneButtonAction: @escaping DoneButtonAction) {
//        titleLabel.text = title
//        dateLabel.text = dateText
//        let image = isDone ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
//        doneButton.setBackgroundImage(image, for: .normal)
//        self.doneButtonAction = doneButtonAction
//    }
//}
