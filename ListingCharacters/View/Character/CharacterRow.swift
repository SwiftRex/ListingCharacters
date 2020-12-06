//
//  CharacterRow.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character
    var body: some View {
        HStack {
            CharacterImage(avatarURL: character.url)
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
    static var previews: some View {
        CharacterRow(character: Character(id: 0, name: "Rick Sanchez",
                                          status: "Alive",
                                          species: "Human",
                                          type: "",
                                          gender: "Male",
                                          origin: Character.Location(name: "", url: ""),
                                          location: Character.Location(name: "", url: ""),
                                          image: "", episodes: [""],
                                          url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                                          created: "" ))
    }
}
