//
//  CharacterRow.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI

struct CharacterRow: View {
    var viewModel: CharacterListViewModel.CharacterListItemViewModel
    let onTapFavourite: (Int) -> Void
    var body: some View {
        HStack {
            Button(action: {
                    onTapFavourite(viewModel.id) },
                   label: {
                    Image(systemName: viewModel.favouriteImageName)
                        .foregroundColor(.yellow)
                   }).buttonStyle(PlainButtonStyle())

            CharacterImage(avatarURL: viewModel.image)
            VStack(alignment: .leading) {
                Text(viewModel.name).font(.headline)
                Text(viewModel.status).font(.subheadline)
                    .foregroundColor(.gray)
                Text(viewModel.species).font(.subheadline)
                    .foregroundColor(.gray)
                Text(viewModel.gender).font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static let avatarURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    static var previews: some View {
        CharacterRow(viewModel:
                        CharacterListViewModel.CharacterListItemViewModel(id: 1,
                                                                          image: avatarURL,
                                                                          name: "Rick Sanchez",
                                                                          status: "Alive",
                                                                          species: "Human",
                                                                          gender: "Male",
                                                                          origin: "",
                                                                          location: "",
                                                                          episodes: ["Episode 1", "Episode 2"],
                                                                          isFavourite: true), onTapFavourite: {_ in })
    }
}
