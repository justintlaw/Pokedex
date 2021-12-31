//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: Outlets
    
    // header outlets
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonHeaderImage: UIImageView!
    
    // other outlets
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonBaseExperience: UILabel!
    @IBOutlet weak var pokemonHitPoints: UILabel!
    @IBOutlet weak var pokemonAttack: UILabel!
    @IBOutlet weak var pokemonDefense: UILabel!
    @IBOutlet weak var pokemonSpeed: UILabel!

    private var pokemon: Pokemon?
    private var pokemonMoveList: [Move] = [Move]()
    private var pokemonTypeList: [PokemonType] = [PokemonType]()
    private var dataSource: UITableViewDataSource?
    
    func configure(with pokemon: Pokemon) {
        self.pokemon = pokemon
        self.pokemonMoveList = PokemonDatabase.shared.getMovesForPokemon(id: pokemon.id)
        self.pokemonTypeList = PokemonDatabase.shared.getTypesForPokemon(id: pokemon.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let title = pokemon?.name.capitalized ?? "View Pokemon"
        navigationItem.title = NSLocalizedString(title, comment: "pokemon detail view title")
        
        if let pokemonToDisplay = pokemon {
            let image = UIImage(named: pokemonToDisplay.img_full)
            var color = UIColor.white.cgColor
            
            // set color based on light or dark mode
            if pokemonHeaderImage.traitCollection.userInterfaceStyle == .light {
                color = UIColor.gray.cgColor
            }
            
            // configure the image to be set inside a circle
            pokemonHeaderImage.layer.borderWidth = 2
            pokemonHeaderImage.layer.masksToBounds = false
            pokemonHeaderImage.layer.borderColor = color
            pokemonHeaderImage.layer.cornerRadius = pokemonHeaderImage.frame.height / 2
            pokemonHeaderImage.clipsToBounds = true

            pokemonHeaderImage.image = image
            
            // MARK: set other data
            
            // set header data
            pokemonNumber.text = "#\(pokemonToDisplay.id)"
            pokemonName.text = "Name: \(pokemonToDisplay.name.capitalized)"
            pokemonHeight.text = "Height: \(pokemonToDisplay.height)"
            pokemonWeight.text = "Weight: \(pokemonToDisplay.weight)"
            
            // set types
            var typesText = "Types: "
            
            if pokemonTypeList.count < 1 {
                typesText += "None"
            } else {
                let types = pokemonTypeList.map { $0.name }
                let typeNames = types.joined(separator: ", ")
                typesText += typeNames
            }
            
            pokemonTypes.text = typesText
            
            // set other stats
            pokemonBaseExperience.text = "Base Experience: \(pokemonToDisplay.base_experience)"
            pokemonHitPoints.text = "Hit Points: \(pokemonToDisplay.hp)"
            pokemonAttack.text = "Attack: \(pokemonToDisplay.attack)"
            pokemonDefense.text = "Defense: \(pokemonToDisplay.defense)"
            pokemonSpeed.text = "Speed: \(pokemonToDisplay.speed)"
        }
    }
}

//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by Justin on 12/16/21.
//

//import UIKit
//
//class ReminderDetailViewController: UITableViewController {
//    private var reminder: Reminder?
//    private var dataSource: UITableViewDataSource?
//
//    func configure(with reminder: Reminder) {
//        self.reminder = reminder
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setEditing(false, animated: false)
//        navigationItem.setRightBarButton(editButtonItem, animated: false)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifer)
//    }
//
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//
//        guard let reminder = reminder else {
//            fatalError("No reminder found for detail view")
//        }
//
//        if editing {
//            dataSource = ReminderDetailEditDataSource(reminder: reminder)
//            navigationItem.title = NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
//            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
//        } else {
//            dataSource = ReminderDetailViewDataSource(reminder: reminder)
//            navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
//            navigationItem.leftBarButtonItem = nil
//            editButtonItem.isEnabled = true
//        }
//
//        tableView.dataSource = dataSource
//        tableView.reloadData()
//    }
//
//    @objc
//    func cancelButtonTrigger() {
//        setEditing(false, animated: true)
//    }
//}
