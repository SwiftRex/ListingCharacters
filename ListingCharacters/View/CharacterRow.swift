//
//  CharacterRow.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character
    let newUrl = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!

    var body: some View {
        HStack {
            AsyncImage(
                url: newUrl,
                placeholder: { Text("Loading...")}
            )
            .frame(width: 70, height: 110)
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .gray, radius: 10, x: 5, y: 5).padding()
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
                                          url: "",
                                          created: "" ))
    }
}
