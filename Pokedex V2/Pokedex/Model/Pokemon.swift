//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 23/04/2023.
//

import Foundation
import SwiftUI

struct Pokemon: Codable, Identifiable{
    let id: Int
    let stats: [StatContainer]
    let types: [TypeContainer]
    let name: String
    let sprites: Sprite
    
    
    
    var backgroundColor: Color {
        switch types[0].type.name {
        case "grass": return Color("grass")
        case "fire": return Color("fire")
        case "poison": return Color("poison")
        case "water": return Color("water")
        case "electric": return Color("electric")
        case "psychic": return Color("psychic")
        case "normal": return Color("normal")
        case "ground": return Color("ground")
        case "flying": return Color("flying")
        case "bug": return Color("bug")
        case "rock": return Color("rock")
        case "fairy": return Color("fairy")
        case "fighting": return Color("fighting")
        case "dragon": return Color("dragon")
        case "ice": return Color("ice")
        case "steel": return Color("steel")
        case "ghost": return Color("ghost")
        default: return .indigo
        }
    }
 
    var statTotal: Int {
        var total = 0
        for stat in stats {
            total += stat.baseStat
        }
        return total
    }
    
}



struct Sprite: Codable {
    let frontDefault: String
    let other: Other
    
    struct Other: Codable {
        let officialArtwork: OfficialArtwork
        
        struct OfficialArtwork: Codable {
            let frontDefault: String
            let frontShiny: String
        }
        
        private enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
}


struct TypeContainer: Codable {
    let slot: Int
    let type: PokeType
    
    
    struct PokeType: Codable {
        let name: String
        let url: String
    }
}



struct StatContainer: Codable {
    let baseStat: Int
    let effort: Int
    let stat: Stat
    
    struct Stat: Codable {
        let name: String
        let url: String
    }
}

let mockPokemon = Pokemon(id: 3, stats: [StatContainer(baseStat: 40, effort: 0, stat: StatContainer.Stat(name: "hp", url: "https://pokeapi.co/api/v2/stat/3/")),
                                         StatContainer(baseStat: 30, effort: 0, stat: StatContainer.Stat(name: "attack", url: "https://pokeapi.co/api/v2/stat/3/")),
                                         StatContainer(baseStat: 60, effort: 0, stat: StatContainer.Stat(name: "defense", url: "https://pokeapi.co/api/v2/stat/3/")),
                                         StatContainer(baseStat: 90, effort: 0, stat: StatContainer.Stat(name: "special-defense", url: "https://pokeapi.co/api/v2/stat/3/")),
                                         StatContainer(baseStat: 255, effort: 0, stat: StatContainer.Stat(name: "speed", url: "https://pokeapi.co/api/v2/stat/3/"))], types: [TypeContainer(slot: 1, type: TypeContainer.PokeType(name: "grass", url: "https://pokeapi.co/api/v2/pokemon-form/4/"))], name: "venasaur", sprites: Sprite(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png", other: Sprite.Other(officialArtwork: Sprite.Other.OfficialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png", frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/3.png"))))
