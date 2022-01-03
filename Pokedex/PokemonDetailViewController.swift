//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    static let showMovesSegueIdentifier = "ShowPokemonMovesSegue"

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showMovesSegueIdentifier,
           ((sender as? UIButton) != nil),
           let destination = segue.destination as? MoveListViewController {
            destination.configure(with: pokemonMoveList)
        }
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
