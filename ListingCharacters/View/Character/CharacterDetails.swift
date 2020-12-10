//
//  CharacterDetails.swift
//  ListingCharacters
//
//  Created by Jarbas on 06/12/20.
//

import SwiftUI

struct CharacterDetails: View {
    @ObservedObject var viewModel: CharacterDetailsViewModel

    var body: some View {

        ScrollView {
            VStack {
                CharacterImageDetails(avatarURL: viewModel.character.image)

                Spacer().frame(height: 40)

                Text(viewModel.character.species)
                    .foregroundColor(.gray)

                Text(viewModel.character.name)
                    .font(.system(size: 24, weight: .semibold))
                    .padding([.leading, .trailing], 20)

                Text(viewModel.character.gender)
                    .foregroundColor(.gray).font(.subheadline)

                Text(viewModel.character.location).font(.callout)

                Text(viewModel.character.origin).font(.callout)

                Spacer()
                    .frame(height: 20)

                let columns = 3
                let roundedRows = Int(ceil((Double(viewModel.character.episodes.count) / Double(columns))))
                VStack {
                    ForEach(0 ..< roundedRows, id: \.self) { row in
                        HStack {
                            ForEach(0 ..< columns, id: \.self) { column in
                                let current = row * columns + column
                                if current < viewModel.character.episodes.count {
                                    EpisodeLabel(text: viewModel.character.episodes[current])
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

}

struct CharacterDetails_Previews: PreviewProvider {
    static let avatarURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    static let characterItemViewModel = CharacterListViewModel
        .CharacterListItemViewModel(id: 1,
                                    image: avatarURL,
                                    name: "Rick Sanchez",
                                    status: "Alive",
                                    species: "Human",
                                    gender: "Male",
                                    origin: "",
                                    location: "",
                                    episodes: ["Episode 1", "Episode 2", "Episode 3", "Episode 4", "Episode 5"],
                                    isFavourite: true)
    static var previews: some View {
        CharacterDetails(viewModel: CharacterDetailsViewModel(character: characterItemViewModel)
        )
    }
}
