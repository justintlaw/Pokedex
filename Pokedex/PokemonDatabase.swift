//
//  PokemonDatabase.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import Foundation
import SQLite3

class PokemonDatabase {
    
    // MARK: Constants
    struct Constants {
        static let fileName = "pokemon"
        static let fileExtension = "db"
    }
    
    // MARK: Properties
    var db: OpaquePointer?
    var pokemonList = [Pokemon]()
    var filteredPokemonList = [Pokemon]()

    // MARK: Singleton
    static let shared = PokemonDatabase()
    
    private init() {
        if let path = Bundle.main.path(forResource: Constants.fileName, ofType: Constants.fileExtension) {
            let fileExists = FileManager.default.fileExists(atPath: path)
            if !fileExists {
                fatalError("Could not find database file")
            }

            if sqlite3_open(path, &db) != SQLITE_OK {
                fatalError("Error opening pokemon database")
            }
        } else {
            fatalError("Could not find database file")
        }
    }
    
    // MARK: CRUD
    func getAllPokemon() -> [Pokemon] {
        var pokemonList = [Pokemon]()

        let queryString = "SELECT * FROM pokemon"
        
        // statement pointer
        var stmt:OpaquePointer?
 
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing query: \(errmsg)")
            return [Pokemon]()
        }
 
        // traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let height = Int(sqlite3_column_int(stmt, 2))
            let weight = Int(sqlite3_column_int(stmt, 3))
            let base_experience = Int(sqlite3_column_int(stmt, 4))
            let hp = Int(sqlite3_column_int(stmt, 5))
            let attack = Int(sqlite3_column_int(stmt, 6))
            let defense = Int(sqlite3_column_int(stmt, 7))
            let speed = Int(sqlite3_column_int(stmt, 8))
            let img_sprite = String(cString: sqlite3_column_text(stmt, 9))
            let img_full = String(cString: sqlite3_column_text(stmt, 10))
 
            //adding values to list
            pokemonList.append(
                Pokemon(
                    id: id,
                    name: name,
                    height: height,
                    weight: weight,
                    base_experience: base_experience,
                    hp: hp,
                    attack: attack,
                    defense: defense,
                    speed: speed,
                    img_sprite: img_sprite,
                    img_full: img_full)
            )
        }
        
        return pokemonList
    }
    
    func getPokemonById(_ id: Int) -> Pokemon? {
        var pokemon: Pokemon? = nil
        
        // TODO: the id value in the SQL statement should be parameterized
        // ignoring for now since the "id" value does not come from user input
        let queryString = "SELECT * FROM pokemon WHERE id = \(id)"
        
        // statement pointer
        var stmt:OpaquePointer?
 
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing query: \(errmsg)")
            return nil
        }
    
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let height = Int(sqlite3_column_int(stmt, 2))
            let weight = Int(sqlite3_column_int(stmt, 3))
            let base_experience = Int(sqlite3_column_int(stmt, 4))
            let hp = Int(sqlite3_column_int(stmt, 5))
            let attack = Int(sqlite3_column_int(stmt, 6))
            let defense = Int(sqlite3_column_int(stmt, 7))
            let speed = Int(sqlite3_column_int(stmt, 8))
            let img_sprite = String(cString: sqlite3_column_text(stmt, 9))
            let img_full = String(cString: sqlite3_column_text(stmt, 10))
 
            //adding values to list
            pokemon =
                Pokemon(
                    id: id,
                    name: name,
                    height: height,
                    weight: weight,
                    base_experience: base_experience,
                    hp: hp,
                    attack: attack,
                    defense: defense,
                    speed: speed,
                    img_sprite: img_sprite,
                    img_full: img_full)
        }
        
        return pokemon
    }
    
    func getMovesForPokemon(id: Int) -> [Move] {
        var moveList = [Move]()
        
        // TODO: the id value in the SQL statement should be parameterized
        // ignoring for now since the "id" value does not come from user input
        let queryString =
            """
            SELECT move.id, move.name, move.description FROM pokemon
            INNER JOIN pokemon_moves ON pokemon.id = pokemon_moves.pokemon_id
            INNER JOIN move ON pokemon_moves.move_id = move.id
            WHERE pokemon_id = \(id)
            """
        
        // statement pointer
        var stmt:OpaquePointer?
 
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing query: \(errmsg)")
            return [Move]()
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let description = String(cString: sqlite3_column_text(stmt, 2))
            
            moveList.append(Move(id: id, name: name, description: description))
        }
        
        return moveList
    }
    
    func getTypesForPokemon(id: Int) -> [PokemonType] {
        var typeList = [PokemonType]()
        
        // TODO: the id value in the SQL statement should be parameterized
        // ignoring for now since the "id" value does not come from user input
        let queryString =
            """
            SELECT type.id, type.name FROM type
            INNER JOIN pokemon_types ON type.id = pokemon_types.type_id
            WHERE pokemon_types.pokemon_id = \(id)
            """
        
        // statement pointer
        var stmt:OpaquePointer?
 
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing query: \(errmsg)")
            return [PokemonType]()
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            
            typeList.append(PokemonType(id: id, name: name))
        }
        
        return typeList
    }
}
