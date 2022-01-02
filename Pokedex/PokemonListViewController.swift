//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import UIKit

class PokemonListViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    private var pokemonListDataSource: PokemonListDataSource?
    
    static let showDetailSegueIdentifier = "ShowPokemonDetailSegue"
    
    let searchController = UISearchController()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
           let destination = segue.destination as? PokemonDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let pokemon = PokemonDatabase.shared.pokemonList[indexPath.row]
            destination.configure(with: pokemon)
        }
    }
    
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.scopeButtonTitles = ["All", "Some", "None"]
        searchController.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonDatabase.shared.pokemonList = PokemonDatabase.shared.getAllPokemon()
        PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.getAllPokemon()
        pokemonListDataSource = PokemonListDataSource()
        tableView.dataSource = pokemonListDataSource
        initSearchController()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText, scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(_ searchText: String, _ scopeButton: String = "All") {
        PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.pokemonList.filter { pokemon in
//            let scopeMatch = (scopeButton == "All" || pokemon.name == scopeButton)
            if (searchController.searchBar.text != "") {
                let searchTextMatch = pokemon.name.lowercased().contains(searchText.lowercased())
                
//                return scopeMatch && searchTextMatch
                return searchTextMatch
            }
//            else {
//                return scopeMatch
//            }
            else {
                return false
            }
        }
        
        tableView.reloadData()
    }
}
