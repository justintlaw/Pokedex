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

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
           let destination = segue.destination as? PokemonDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let pokemon = PokemonDatabase.shared.filteredPokemonList[indexPath.row]
            destination.configure(with: pokemon)
        }
    }
    
    // setup the search controller
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["Number", "Name", "Type"]
        searchController.searchBar.delegate = self
        
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .bookmark, state: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonDatabase.shared.pokemonList = PokemonDatabase.shared.getAllPokemon()
        PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.getAllPokemon()
        pokemonListDataSource = PokemonListDataSource()
        tableView.dataSource = pokemonListDataSource
        initSearchController()
    }
    
    // respond to updates to search bar (user input)
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            searchController.searchBar.showsBookmarkButton = false
        } else {
            searchController.searchBar.showsBookmarkButton = true
        }

        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText, scopeButton)
    }
    
    // filter based on text in search bar and sort options
    func filterForSearchTextAndScopeButton(_ searchText: String, _ scopeButton: String = "Number") {
        PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.pokemonList.filter { pokemon in
            if (searchController.searchBar.text != "") {
                let searchTextMatch = pokemon.name.lowercased().contains(searchText.lowercased())

                return searchTextMatch
            } else {
                return true
            }
        }
        
        switch scopeButton {
        case "Number":
            PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.filteredPokemonList.sorted() {
                $0.id < $1.id
            }
        case "Name":
            PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.filteredPokemonList.sorted() {
                $0.name < $1.name
            }
        case "Type":
            PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.filteredPokemonList.sorted() {
                PokemonDatabase.shared.getTypesForPokemon(id: $0.id)[0].name < PokemonDatabase.shared.getTypesForPokemon(id: $1.id)[0].name
            }
        default:
            PokemonDatabase.shared.filteredPokemonList = PokemonDatabase.shared.filteredPokemonList.sorted() {
                $0.id < $1.id
            }
        }
        
        tableView.reloadData()
    }
}
