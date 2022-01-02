//
//  MoveListViewController.swift
//  Pokedex
//
//  Created by Justin on 1/2/22.
//

import UIKit

class MoveListViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    private var moveListDataSource: MoveListDataSource?
    
    func configure(with moves: [Move]) {
        let sortedList = moves.sorted() { $0.name < $1.name }
        
        PokemonDatabase.shared.moveList = sortedList
        PokemonDatabase.shared.filteredMoveList = sortedList
    }
    
    let searchController = UISearchController()
    
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        navigationItem.title = NSLocalizedString("Moves", comment: "pokemon moves view title")
        moveListDataSource = MoveListDataSource()
        tableView.dataSource = moveListDataSource
        initSearchController()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText)
    }
    
    func filterForSearchTextAndScopeButton(_ searchText: String) {
        PokemonDatabase.shared.filteredMoveList = PokemonDatabase.shared.moveList.filter { move in
            if (searchController.searchBar.text != "") {
                let searchTextMatch = move.name.lowercased().contains(searchText.lowercased())

                return searchTextMatch
            }
            else {
                return true
            }
        }

        tableView.reloadData()
    }
}
