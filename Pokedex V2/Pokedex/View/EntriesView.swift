//
//  FormsView.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 30/04/2023.
//

import SwiftUI

struct EntriesView: View {
    
    @ObservedObject var pokemonVarieties: PokemonVarietiesViewModel
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            ForEach (pokemonVarieties.pokemonEnTextEntries, id: \.version) { entry in
                VStack() {
                    
                    Text(entry.version.name.capitalized)
                        .bold()
                        .background(
                            Rectangle()
                                .fill(pokemon.backgroundColor)
                                .frame(width: 900, height: 50)
                                .position(y: 7)
                        )
                    
                
                    
                    Text(entry.flavorText.replacingOccurrences(of: "\n", with: " "))
                        .multilineTextAlignment(.center)
                        .padding(.top, 12)
                    
        
                    
                }
             
                .padding()
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5, y: 3)
                .padding(.bottom, 30)
            }
        }
    }
}

//struct FormsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormsView()
//    }
//}
