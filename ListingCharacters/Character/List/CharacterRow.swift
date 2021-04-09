//
//  CharacterRow.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import CombineRex
import SwiftUI

struct CharacterRow: View {
    @ObservedObject var viewModel: ObservableViewModel<CharacterListItemViewAction, CharacterListItemViewState>

    var body: some View {
        HStack {
            Button(
                action: {
                    viewModel.dispatch(.toggleFavorite)
                },
                label: {
                    Image(systemName: viewModel.state.favouriteImageName)
                        .foregroundColor(.yellow)
                }
            ).buttonStyle(PlainButtonStyle())

            CharacterImage(avatarURL: viewModel.state.image)
            VStack(alignment: .leading) {
                Text(viewModel.state.name).font(.headline)
                Text(viewModel.state.status).font(.subheadline)
                    .foregroundColor(.gray)
                Text(viewModel.state.species).font(.subheadline)
                    .foregroundColor(.gray)
                Text(viewModel.state.gender).font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#if DEBUG
struct CharacterRow_Previews: PreviewProvider {
    static let avatarURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    static var previews: some View {
        CharacterRow(
            viewModel:
                .mock(state:
                        .init(id: 1,
                              image: avatarURL,
                              name: "Rick Sanchez",
                              status: "Alive",
                              species: "Human",
                              gender: "Male",
                              origin: "",
                              location: "",
                              episodes: ["Episode 1", "Episode 2"],
                              isFavourite: true
                        ))
        )
    }
}
#endif
