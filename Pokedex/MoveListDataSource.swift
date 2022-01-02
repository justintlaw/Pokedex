//
//  MoveListDataSource.swift
//  Pokedex
//
//  Created by Justin on 1/2/22.
//

import UIKit

class MoveListDataSource: NSObject {

}

extension MoveListDataSource: UITableViewDataSource {
    static let moveListCellIdentifier = "MoveListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonDatabase.shared.filteredMoveList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.moveListCellIdentifier, for: indexPath) as? MoveListCell else {
            fatalError("Unable to dequeue MoveListCell")
        }

        let move = PokemonDatabase.shared.filteredMoveList[indexPath.row]

        cell.configure(title: move.name)
        
        return cell
    }
}
