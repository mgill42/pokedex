//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 23/04/2023.
//

import SwiftUI
import Kingfisher


struct PokemonCell: View {
    let pokemon: Pokemon
    
    var body: some View {
        
        
        ZStack {
            VStack(spacing: 0) {
                KFImage(URL(string: pokemon.sprites.other.officialArtwork.frontDefault))
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 20)
                    .padding(.top, 15)
                                
                Text(pokemon.name.capitalized)
                    .bold()
                    .padding(.bottom, 4)
                Text(String(format: "%03d", pokemon.id))
                    .font(.footnote)
                
            }
            .foregroundColor(Color("accent"))
            .padding()
        }
        .background(pokemon.backgroundColor)
        .cornerRadius(20)
    
    }
}



struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: mockPokemon)
    }
}
