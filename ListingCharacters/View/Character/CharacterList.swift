//
//  ContentView.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI

struct CharacterList: View {
    @ObservedObject var viewModel: CharacterListViewModel
    var body: some View {
        NavigationView {
            List(self.viewModel.characterList) { character in
                NavigationLink(
                    destination: CharacterDetails(viewModel: CharacterDetailsViewModel(character: character))) {
                    CharacterRow(viewModel: character, onTapFavourite: viewModel.toggleCharacterFavourite(id:))
                }.onAppear {
                    if viewModel.characterList.last?.id == character.id {
                        self.viewModel.getCharacterList()
                    }
                }
            }
            .navigationTitle("Character List")
        }.onAppear {
            self.viewModel.getCharacterList()
        }
    }
}
struct CharacterList_Previews: PreviewProvider {

    static func getViewModel() -> CharacterListViewModel {
        let viewModel = CharacterListViewModel(serviceProtocolType: CharacterFakeService.self,
                                               favouritesRepository: FavouriteRepositoryFake())
        return viewModel

    }

    static var previews: some View {
        CharacterList(viewModel: getViewModel() )
    }
}
