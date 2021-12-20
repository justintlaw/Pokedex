//
//  Pokemon.swift
//  Pokedex
//
//  Created by Justin on 12/19/21.
//

import Foundation

class Pokemon {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    var base_experience: Int
    var hp: Int
    var attack: Int
    var defense: Int
    var speed: Int
    var img_sprite: String
    var img_full: String
    
    init(
        id: Int,
        name: String,
        height: Int,
        weight: Int,
        base_experience: Int,
        hp: Int,
        attack: Int,
        defense: Int,
        speed: Int,
        img_sprite: String,
        img_full: String
    ) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.base_experience = base_experience
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.speed = speed
        self.img_sprite = img_sprite
        self.img_full = img_full
    }
}


/*
 id = json_data["id"]
 name = json_data["name"]
 height = json_data["height"]
 weight = json_data["weight"]
 base_experience = json_data["base_experience"]
 hp = json_data["stats"][0]["base_stat"]
 attack = json_data["stats"][1]["base_stat"]
 defense = json_data["stats"][2]["base_stat"]
 speed = json_data["stats"][3]["base_stat"]
 img_sprite = f'{name}-sprite.png'
 img_full = f'{name}-full.png'
 */
