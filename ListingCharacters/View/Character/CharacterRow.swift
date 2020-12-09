//
//  CharacterRow.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI

struct CharacterRow: View {
    let character: CharacterListViewModel.CharacterListItemViewModel
    var body: some View {
        HStack {
            CharacterImage(avatarURL: character.image)
            VStack(alignment: .leading) {
                Text(character.name).font(.headline)
                Text(character.status).font(.subheadline)
                    .foregroundColor(.gray)
                Text(character.species).font(.subheadline)
                    .foregroundColor(.gray)
                Text(character.gender).font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static let avatarURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    static var previews: some View {
        CharacterRow(character:
                        CharacterListViewModel.CharacterListItemViewModel(id: 1,
                                                                          image: avatarURL,
                                                                          name: "Rick Sanchez",
                                                                          status: "Alive",
                                                                          species: "Human",
                                                                          gender: "Male"))
    }
}
