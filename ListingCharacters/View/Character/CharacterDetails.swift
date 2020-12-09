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

            //Text(viewModel.character.location.name).font(.callout)
            //Text(viewModel.character.origin.name).font(.callout)

            Spacer()
                .frame(height: 20)

//            HStack(spacing: 20) {
//                ForEach(0 ..< viewModel.character.episode.count, id: \.self) { index in
//                    EpisodeLabel(text: viewModel.character.episode[index].lastPathComponent)
//                }
//            }

        }
    }
}

//struct CharacterDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterDetails(viewModel: CharacterDetailsViewModel(
//                            character:
//                                Character(
//                                    id: 0,
//                                    name: "Rick Sanchez",
//                                    status: "Alive",
//                                    species: "Human",
//                                    type: "",
//                                    gender: "Male",
//                                    origin: Character.Location(name: "Earth (C-137)", url: ""),
//                                    location: Character.Location(name: "Earth (Replacement Dimension)", url: ""),
//                                    image: "", episodes: ["Episode 1", "Episode 2"],
//                                    url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
//                                    created: "" )))
//    }
//}
