//
//  FormsView.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 30/04/2023.
//

import SwiftUI
import Kingfisher
struct FormsView: View {
    
    @Binding var pokemon: Pokemon
    @ObservedObject var pokemonVarieties: PokemonVarietiesViewModel

    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach (pokemonVarieties.pokemon.sorted(by: {$0.id < $1.id})) { pokemon in
                    
                    Button {
                        self.pokemon = pokemon
                        
                    } label: {
                        KFImage(URL(string: pokemon.sprites.frontDefault))
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(pokemon.backgroundColor)
                            )
                    }
                    .opacity(self.pokemon.id == pokemon.id ? 1.0 : 0.5)
                    
                }
            }

        }
        .scrollIndicators(.hidden)
        
    }
}

//struct FormsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormsView()
//    }
//}
