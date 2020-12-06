//
//  CharacterImage.swift
//  ListingCharacters
//
//  Created by Jarbas on 06/12/20.
//

import SwiftUI

struct CharacterImage: View {
    let avatarURL: URL
    var body: some View {
        AsyncImage(
            url: avatarURL,
            placeholder: { Text("Loading...")}
        )
        .frame(width: 70, height: 110)
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 10, x: 5, y: 5).padding()
    }
}

struct CharacterImage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterImage(avatarURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!)
    }
}
