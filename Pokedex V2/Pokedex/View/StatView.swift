//
//  StatView.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 30/04/2023.
//

import SwiftUI
import Charts

struct StatView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            Chart {
                ForEach(pokemon.stats, id:\.stat.name) { stat in
                    let value = stat.baseStat
                    let statName = stat.stat.name
                    
                    BarMark(x: .value("Value", value) , y: .value("Stat", statName.replacingOccurrences(of: "-", with: " ").capitalized))
                        .foregroundStyle(Color.green.gradient)
                        .cornerRadius(5)
                        .annotation(position: .trailing, alignment: .trailing) {
                            Text(String(value))
                                .padding(.leading, 5)
                                .foregroundColor(.green)
                                .bold()
                                .font(.system(size: 15))
                        }
                    
                }
            }
            .frame(height: 300)
            .chartXAxis {
                AxisMarks() {
                    
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisValueLabel(horizontalSpacing: 0)
                        .font(.headline)
                }
                
            }
 
            
            
            Text("Total: **\(pokemon.statTotal)**")
                .foregroundColor(.green)
                .padding()
        }
    }
}

//struct StatView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatView()
//    }
//}
