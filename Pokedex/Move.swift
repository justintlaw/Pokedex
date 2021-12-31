//
//  Move.swift
//  Pokedex
//
//  Created by Justin on 12/31/21.
//

import Foundation

class Move {
    var id: Int
    var name: String
    var description: String
    
    init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
