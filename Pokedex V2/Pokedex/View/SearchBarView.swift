//
//  SearchBarView.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 25/04/2023.
//



import SwiftUI
 
struct SearchBar: View {
    @Binding var text: String
 
 
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Name or number", text: $text)
            }
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(.systemGray6))
            )
            
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("button"))
                            
                    )
            }
        }
     
        
    }
}


struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
