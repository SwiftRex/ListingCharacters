//
//  ContentView.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    var body: some View {
        NavigationView {
            List(self.viewModel.characterList) { character in
                NavigationLink(
                    destination: CharacterDetails(viewModel: CharacterDetailsViewModel(character: character))) {
                    CharacterRow(viewModel: character, onTapFavourite: viewModel.toggleCharacterFavourite(id:))
                }
            }
            .navigationTitle("Character List")
        }.onAppear {
            self.viewModel.getCharacterList()
        }
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static func getViewModel() -> CharacterListViewModel {
//        let viewModel = CharacterListViewModel()
//        let rick = Character(id: 0, name: "Rick Sanchez",
//                                     status: "Alive",
//                                     species: "Human",
//                                     type: "",
//                                     gender: "Male",
//                                     origin: Character.Location(name: "", url: ""),
//                                     location: Character.Location(name: "", url: ""),
//                                     image: "", episodes: [""],
//                                     url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
//                                     created: "" )
//        let morty = Character(id: 1, name: "Morty Smith",
//                                     status: "Alive",
//                                     species: "Human",
//                                     type: "",
//                                     gender: "Male",
//                                     origin: Character.Location(name: "", url: ""),
//                                     location: Character.Location(name: "", url: ""),
//                                     image: "", episodes: [""],
//                                     url: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!,
//                                     created: "")
//        viewModel.characterList = [rick, morty]
//        return viewModel
//
//    }
//
//    static var previews: some View {
//        CharacterListView(viewModel: getViewModel() )
//    }
//}
