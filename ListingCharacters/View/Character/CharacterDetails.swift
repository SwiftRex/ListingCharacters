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
            CharacterImage(avatarURL: viewModel.character.url)

        }
    }
}

struct CharacterDetails_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetails(viewModel: CharacterDetailsViewModel(
                            character:
                                Character(
                                    id: 0,
                                    name: "Rick Sanchez",
                                    status: "Alive",
                                    species: "Human",
                                    type: "",
                                    gender: "Male",
                                    origin: Character.Location(name: "", url: ""),
                                    location: Character.Location(name: "", url: ""),
                                    image: "", episodes: [""],
                                    url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                                    created: "" )))
    }
}
