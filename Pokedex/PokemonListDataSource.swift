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
//        return Pokemon.testData.count
        return PokemonDatabase.shared.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.pokemonListCellIdentifier, for: indexPath) as? PokemonListCell else {
            fatalError("Unable to dequeue PokemonCell")
        }
        
//        let pokemon = Pokemon.testData[indexPath.row]
        let pokemon =  PokemonDatabase.shared.pokemonList[indexPath.row]

        cell.configure(title: pokemon.name, imageName: pokemon.img_sprite)
        print("poke: \(pokemon.img_sprite)")
        
        return cell
    }
}

//import UIKit
//
//class ReminderListDataSource: NSObject {
//    private lazy var dateFormatter = RelativeDateTimeFormatter()
//}
//
//extension ReminderListDataSource: UITableViewDataSource {
//    static let reminderListCellIdentifier = "ReminderListCell"
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Reminder.testData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderListCellIdentifier, for: indexPath) as? ReminderListCell else {
//            fatalError("Unable to dequeue ReminderCell")
//        }
//
//        let reminder = Reminder.testData[indexPath.row]
//        let dateText = dateFormatter.localizedString(for: reminder.dueDate, relativeTo: Date())
//
//        cell.configure(title: reminder.title, dateText: dateText, isDone: reminder.isComplete) {
//            Reminder.testData[indexPath.row].isComplete.toggle()
//            tableView.reloadRows(at: [indexPath], with: .none)
//        }
//
//        return cell
//    }
//}
