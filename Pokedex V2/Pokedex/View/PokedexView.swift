//
//  PokedexView.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 23/04/2023.
//

import SwiftUI

struct PokedexView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "accent")!, .font: UIFont(name: "AvenirNext-Bold", size: 40)!]
    }
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject var viewModel = PokemonViewModel()
    @State var searchText = ""
    
    var body: some View {
        
        
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading) {
                        
                        Text("Search for a Pokemon by name or using its National Pokedex number")
                            .font(.system(size: 14))
                            .foregroundColor(Color("accent"))
                            .padding(.bottom)
                        
                        SearchBar(text: $searchText)
                            .padding(.bottom, 30)
                        
                    }
                    .padding(.horizontal, 8)
                    
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(viewModel.pokemon.sorted(by: {$0.id < $1.id})) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonCell(pokemon: pokemon)

                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    
                }
                .padding(.horizontal, 10)
            
            }
            .navigationBarTitle(
                Text("Pokedex")
            )
        }
    }
}


struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
