//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 27/04/2023.
//

import Foundation
import SwiftUI


struct PokemonSpecies: Codable, Identifiable {
    let id: Int
    let flavorTextEntries: [FlavorTextEntry]
    let varieties: [Variety]
    let genera: [Genera]
    
    
    struct FlavorTextEntry: Codable {
        let flavorText: String
        let language: Language
        let version: Version
        
        struct Language: Codable {
            let name: String
            let url: String
        }
        
        struct Version: Codable, Hashable {
            let name: String
            let url: String
        }
        
    }
    
    struct Genera: Codable {
        let genus: String
        let language: Language
        
    }
    
    struct Language: Codable {
        let name: String
        let url: String
    }
    
    struct Variety: Codable {
        let pokemon: PokemonList
    }

}

