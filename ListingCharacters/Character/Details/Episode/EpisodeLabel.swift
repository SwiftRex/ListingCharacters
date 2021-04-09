//
//  EpisodeLabel.swift
//  ListingCharacters
//
//  Created by Jarbas on 07/12/20.
//

import SwiftUI

struct EpisodeLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct EpisodeLabel_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeLabel(text: "Episode 1")
    }
}
