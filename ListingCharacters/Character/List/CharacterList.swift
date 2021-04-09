//
//  ContentView.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import CombineRex
import CombineRextensions
import SwiftUI

struct CharacterList: View {
    @ObservedObject var viewModel: ObservableViewModel<CharacterListViewAction, CharacterListViewState>
    let characterDetails: (Int) -> AnyView

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(
                        viewModel: viewModel,
                        collection: \.rows,
                        identifiableRowToCollectionAction: CharacterListViewAction.item
                    ) { rowViewModel in
                        NavigationLink(
                            destination: characterDetails(rowViewModel.state.id)
                        ) {
                            CharacterRow(viewModel: rowViewModel)
                        }
                    }
                }
            }
            .navigationTitle("Character List")
        }.onAppear {
            self.viewModel.dispatch(.onAppear)
        }
    }
}

#if DEBUG
func fakeCharacters() -> [Character] {
    let imageRickURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    let imageMortyURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
    let imageSummerURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!
    let imageBethURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg")!
    let rickURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
    let mortyURL = URL(string: "https://rickandmortyapi.com/api/character/2")!
    let summerURL = URL(string: "https://rickandmortyapi.com/api/character/3")!
    let bethURL = URL(string: "https://rickandmortyapi.com/api/character/4")!
    let origin = Location(name: "Earth (C-137)", url: nil)
    let location = Location(name: "Earth (Replacement Dimension)", url: nil)
    let rick = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human",
                         type: "",
                         gender: .male,
                         origin: origin,
                         location: location, image: imageRickURL, url: rickURL, episode: [], created: nil)
    let morty = Character(id: 2, name: "Morty Smith", status: .alive, species: "Human",
                          type: "",
                          gender: .male,
                          origin: origin,
                          location: location, image: imageMortyURL, url: mortyURL, episode: [], created: nil)

    let summer = Character(id: 3, name: "Summer Smith", status: .alive, species: "Human",
                           type: "",
                           gender: .female,
                           origin: origin,
                           location: location, image: imageBethURL, url: summerURL, episode: [], created: nil)
    let beth = Character(id: 4,
                         name: "Beth Smith",
                         status: .alive,
                         species: "Human",
                         type: "",
                         gender: .female,
                         origin: origin,
                         location: location, image: imageSummerURL, url: bethURL, episode: [], created: nil)
    return [rick, morty, summer, beth]
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList(
            viewModel: .mock(
                state: CharacterListViewState.from(
                    state: .init(
                        characteres: fakeCharacters(),
                        pageInfo: .empty,
                        favourites: [],
                        images: [:]
                    )
                )
            ),
            characterDetails: { _ in AnyView(EmptyView()) }
        )
    }
}
#endif
