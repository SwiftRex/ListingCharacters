//
//  CharacterDetails.swift
//  ListingCharacters
//
//  Created by Jarbas on 06/12/20.
//

import CombineRex
import SwiftUI

struct CharacterDetailsView: View {
    @ObservedObject var viewModel: ObservableViewModel<CharacterDetailsViewAction, CharacterDetailsViewState>

    var body: some View {
        ScrollView {
            VStack {
                avatar

                Spacer().frame(height: 40)

                Text(viewModel.state.species)
                    .foregroundColor(.gray)

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

                    Text(viewModel.state.name)
                        .font(.system(size: 24, weight: .semibold))
                        .padding([.leading, .trailing], 20)
                }

                Text(viewModel.state.gender)
                    .foregroundColor(.gray).font(.subheadline)

                Text(viewModel.state.location).font(.callout)

                Text(viewModel.state.origin).font(.callout)

                Spacer()
                    .frame(height: 20)

                let columns = 3
                let roundedRows = Int(ceil((Double(viewModel.state.episodes.count) / Double(columns))))
                VStack {
                    ForEach(0 ..< roundedRows, id: \.self) { row in
                        HStack {
                            ForEach(0 ..< columns, id: \.self) { column in
                                let current = row * columns + column
                                if current < viewModel.state.episodes.count {
                                    EpisodeLabel(text: viewModel.state.episodes[current])
                                }
                            }
                        }
                    }
                }
                Spacer()
                    .frame(height: 20)
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
        .frame(width: 180, height: 280)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 10, x: 5, y: 5)
    }
}

#if DEBUG
struct CharacterDetailsViewPreviews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(
            viewModel: .mock(
                state: CharacterDetailsViewState
                    .from(
                        state: fakeCharacters().first!,
                        image: nil,
                        isFavorite: true
                    )
            )
        )
    }
}
#endif
