//
//  CharacterRow.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import CombineRex
import SwiftUI

struct CharacterListItemView: View {
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

            avatar

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

    var avatar: some View {
        LazyImage(
            cacheReader: { viewModel.state.image },
            fetch: { viewModel.dispatch(.fetchImage) },
            cancel: { viewModel.dispatch(.cancelFetchImage) },
            image: { image in
                Image(decorative: image, scale: 1)
                    .resizable()
            },
            placeholder: {
                Text("Loading...")
            }
        )
        .frame(width: 70, height: 110)
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 10, x: 5, y: 5).padding()
    }
}

#if DEBUG
struct CharacterListItemViewPreviews: PreviewProvider {
    static let avatarURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    static var previews: some View {
        CharacterListItemView(
            viewModel:
                .mock(state:
                        .init(id: 1,
                              image: nil,
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
