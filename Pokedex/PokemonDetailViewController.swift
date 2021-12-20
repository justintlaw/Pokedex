//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    private var pokemon: Pokemon?
    private var dataSource: UITableViewDataSource?
    
    func configure(with pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: We need to grab the joined data here

        let title = pokemon?.name.capitalized ?? "View Pokemon"
        navigationItem.title = NSLocalizedString(title, comment: "pokemon detail view title")
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
