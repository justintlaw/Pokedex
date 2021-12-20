//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import UIKit

class PokemonListViewController: UITableViewController {
    private var pokemonListDataSource: PokemonListDataSource?
    
    static let showDetailSegueIdentifier = "ShowPokemonDetailSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
           let destination = segue.destination as? PokemonDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
//            let pokemon = Pokemon.testData[indexPath.row]
            let pokemon = PokemonDatabase.shared.pokemonList[indexPath.row]
            print("preparing")
            destination.configure(with: pokemon)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonDatabase.shared.pokemonList = PokemonDatabase.shared.getAllPokemon()
        print("view loaded")
        pokemonListDataSource = PokemonListDataSource()
        tableView.dataSource = pokemonListDataSource
    }
}
