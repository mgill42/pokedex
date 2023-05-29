//
//  PokemonList.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 24/04/2023.
//

import Foundation

struct Results: Codable {
    let count: Int
    let next:  String
    let previous: String?
    let results: [PokemonList]
}

struct PokemonList: Codable {
    let name: String
    let url: String
}


