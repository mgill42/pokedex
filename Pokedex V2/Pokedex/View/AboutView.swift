//
//  AboutView.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 30/04/2023.
//

import SwiftUI

struct AboutView: View {
    
    @ObservedObject var pokemonVarieties: PokemonVarietiesViewModel
    let pokemon: Pokemon
    
    var body: some View {
     
        VStack {
            VStack {
                Text(pokemonVarieties.pokemonEnGenus?.genus ?? "")
                    .bold()
                
                Text(pokemonVarieties.pokemonEnTextEntries[0].flavorText.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\\f", with: " "))
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                
                HStack {
                    ForEach(pokemon.types, id: \.type.name) { type in
                        Text(type.type.name.capitalized)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(Color(type.type.name))
                            )
                            .padding(.vertical)
                    }
                }
                
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 5, y: 3)
            
            
//            VStack {
//                Text("Abilities").bold()
//                
//            }
            
            
            
        }
       
    }
}

//struct AboutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutView(pokemonVarieties: PokemonVarietiesViewModel(), pokemon: mockPokemon)
//    }
//}
