//
//  PokemonVarietiesViewModel.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 27/04/2023.
//


import SwiftUI

class PokemonVarietiesViewModel: ObservableObject {
    @Published var pokemon = [Pokemon]()
    var pokemonEnTextEntries = [PokemonSpecies.FlavorTextEntry]()
    var pokemonEnGenus: PokemonSpecies.Genera?

  
  
    
    func fetchVarieties(pokemonID: Int) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemonID)") else { return }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                DispatchQueue.main.async {
                    do {
                        let decodedResults = try decoder.decode(PokemonSpecies.self, from: data)
                        
                        self.pokemonEnTextEntries.append(contentsOf: decodedResults.flavorTextEntries.filter({$0.language.name == "en"}))
                        self.pokemonEnGenus = decodedResults.genera.first(where: { $0.language.name == "en"})
                                                
                        for pokemonList in decodedResults.varieties {
                            self.extractPokemon(pokemonURL: pokemonList.pokemon.url)
                        }
            
                    } catch {
                        print("Error decoding:", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    
    
    func extractPokemon(pokemonURL: String) {
        
        
        guard let url = URL(string: pokemonURL) else { return }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request Error: ", error)
                return
            }
        
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                DispatchQueue.main.async {
                    do {
                        let decodedResults = try decoder.decode(Pokemon.self, from: data)
                        self.pokemon.append(decodedResults)
                    } catch {
                        print("Error decoding:", error)
                    }
                }
            }
        }
        dataTask.resume()
        
        
    }
}
