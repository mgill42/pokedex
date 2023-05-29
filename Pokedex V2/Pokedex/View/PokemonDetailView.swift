//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 26/04/2023.
//

import SwiftUI
import Kingfisher
import Charts

/// An enum to describe the possible tab selections
enum TabItem: Int, CaseIterable, Comparable {

    case tab1 = 0
    case tab2 = 1
    case tab3 = 2
    case tab4 = 3

    var description: String {
        switch self.rawValue {
        case 1:
          return "Entries"
        case 2:
          return "About"
        case 3:
          return "Stats"
        default:
            return  "Forms"
            
        }
    }

    var icon: String {
        "\(self.rawValue + 1).circle"
    }

    static func < (lhs: TabItem, rhs: TabItem) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

/// View modifier that applies a move transition on the leading edge
struct TransitionLeading: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.transition(.move(edge: .leading))
        } else {
            content.transition(
                .asymmetric(
                    insertion: .move(edge: .leading),
                    removal: .move(edge: .trailing)
                )
            )
        }
    }
}

/// View modifier that applies a move transition on the trailing edge
struct TransitionTrailing: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.transition(.move(edge: .trailing))
        } else {
            content.transition(
                .asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                )
            )
        }
    }
}

/// A container for two alternative display panels
struct PanelPair<LeftContent: View, RightContent: View>: View {

    /// The identifier for the left panel
    private let leftTab: TabItem

    /// Function that delivers the content for the left panel
    private let leftContent: () -> LeftContent

    /// Function that delivers the content for the right panel
    private let rightContent: () -> RightContent

    /// Binding to the state variable that controls the panel selection
    @Binding private var selectedTab: TabItem

    /// Creates a container for two alternative views
    init(
        leftTab: TabItem,
        selectedTab: Binding<TabItem>,
        leftContent: @escaping () -> LeftContent,
        rightContent: @escaping () -> RightContent
    ) {
        self.leftTab = leftTab
        self._selectedTab = selectedTab
        self.leftContent = leftContent
        self.rightContent = rightContent
    }

    var body: some View {

        // Important: the alternative content needs to be in a ZStack
        ZStack {
            if selectedTab <= leftTab {
                leftContent()
                    .modifier(TransitionLeading())
            } else {
                rightContent()
                    .modifier(TransitionTrailing())
            }
        }
    }
}

struct PokemonDetailView: View {

    @Environment(\.dismiss) var dismiss
    
   // @State var menuSelected = 0
    @State private var menuSelected = TabItem.tab1

    
    
    @State private var goBack = false
    
    @State var pokemon: Pokemon
    @StateObject var pokemonVarieties = PokemonVarietiesViewModel()
    
    private func panel(tab: TabItem, color: Color) -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text("Tab Content \(tab.rawValue + 1)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
            }
            Spacer()
        }
        .background(color)
    }

    /// Callback for a tab button
    private func changeTab(to: TabItem) {
        withAnimation {
            menuSelected = to
        }
    }

    var body: some View {
        
        ScrollView {
            VStack {
                VStack {
                    ZStack {
                        // Back Button
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("accent"))
                                
                            }
                            Spacer()
                        }
                        
                        // Pokemon Name
                        Text(pokemon.name.capitalized)
                            .font(.custom("AvenirNext-Bold", size: 25))
                            .foregroundColor(Color("accent"))
                        
                    }
                    Text(String(format: "%03d", pokemon.id))
                        .foregroundColor(Color("accent"))
                    
                    
                    // Pokemon Picture
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(pokemon.backgroundColor)
                        
                        
                        KFImage(URL(string: pokemon.sprites.other.officialArtwork.frontDefault))
                            .resizable()
                            .frame(width: 280, height: 280)
                            .padding(.vertical, 65)
                    }
                    .padding(.vertical)
                    
                    
                    HStack(spacing: 30) {
                        ForEach(TabItem.allCases, id: \.self) { tabItem in
                            Button(action: { changeTab(to: tabItem) }) {
                                VStack {
                                    Text(tabItem.description)
                                        .bold()
                                        .padding(.bottom, 30)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .foregroundColor(menuSelected == tabItem ? .primary : .secondary)
                        }
                
                    }
                    .padding(.top, 20)
                    
                    if pokemonVarieties.pokemon.isEmpty == false {
 
                        PanelPair(
                            leftTab: .tab1,
                            selectedTab: $menuSelected,
                            leftContent: { FormsView(pokemon: $pokemon, pokemonVarieties: pokemonVarieties) },
                            rightContent: {
                                
                                // Panel 2 + others
                                PanelPair(
                                    leftTab: .tab2,
                                    selectedTab: $menuSelected,
                                    leftContent: { EntriesView(pokemonVarieties: pokemonVarieties, pokemon: pokemon) },
                                    rightContent: {
                                        
                                        // Panels 3 + 4
                                        // zIndex needed for back jumps to work correctly
                                        PanelPair(
                                            leftTab: .tab3,
                                            selectedTab: $menuSelected,
                                            leftContent: { AboutView(pokemonVarieties: pokemonVarieties, pokemon: pokemon) },
                                            rightContent: { StatView(pokemon: pokemon) }
                                        )
                                        .zIndex(1)
                                    }
                                )
                            }
                        )
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                pokemonVarieties.fetchVarieties(pokemonID: pokemon.id)
            }
            .background(Color(hue: 0, saturation: 0, brightness: 0.99))
            .padding(.horizontal, 30)
            
            
        }
        
    }
}



struct PokemonDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            PokemonDetailView(pokemon: mockPokemon)
            
        }
    }
}
