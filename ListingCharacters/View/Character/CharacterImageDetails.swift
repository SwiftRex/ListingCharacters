//
//  CharacterImageDetails.swift
//  ListingCharacters
//
//  Created by Jarbas on 07/12/20.
//

import SwiftUI

struct CharacterImageDetails: View {
    let avatarURL: URL
    var body: some View {
        AsyncImage(
            url: avatarURL,
            placeholder: { Text("Loading...")}
        )
        .frame(width: 180, height: 280)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 10, x: 5, y: 5)
    }

}

struct CharacterImageDetails_Previews: PreviewProvider {
    static var previews: some View {
        CharacterImageDetails(avatarURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!)
    }
}
