//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 23/04/2023.
//

import SwiftUI

class PokemonViewModel: ObservableObject {
    var pokemonList = [PokemonList]()
    @Published var pokemon = [Pokemon]()
    let baseUrl = "https://pokeapi.co/api/v2/pokemon/?limit=151"
    
    init() {
        fetchPokemon()
    }

    
    func fetchPokemon() {
     
        guard let url = URL(string: baseUrl) else { return }
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
                        let decodedResults = try decoder.decode(Results.self, from: data)
                        self.pokemonList = decodedResults.results
                        
                        for pokemon in self.pokemonList {
                            self.extractPokemon(pokemonURL: pokemon.url)
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


