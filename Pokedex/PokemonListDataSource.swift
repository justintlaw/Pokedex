//
//  PokemonListDataSource.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import UIKit

class PokemonListDataSource: NSObject {

}

extension PokemonListDataSource: UITableViewDataSource {
    static let pokemonListCellIdentifier = "PokemonListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonDatabase.shared.filteredPokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.pokemonListCellIdentifier, for: indexPath) as? PokemonListCell else {
            fatalError("Unable to dequeue PokemonCell")
        }

        let pokemon = PokemonDatabase.shared.filteredPokemonList[indexPath.row]

        cell.configure(title: "\(pokemon.id). \(pokemon.name)", imageName: pokemon.img_sprite)
        
        return cell
    }
}
