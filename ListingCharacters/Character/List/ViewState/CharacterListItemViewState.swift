//
//  CharacterListItemViewState.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation
import CoreGraphics

struct CharacterListItemViewState: Equatable, Identifiable {
    let id: Int
    let image: CGImage?
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: String
    let location: String
    let episodes: [String]
    var isFavourite: Bool

    var favouriteImageName: String {
        isFavourite ? "star.fill" : "star"
    }

    static func from(state: Character, image: CGImage?, isFavorite: Bool) -> CharacterListItemViewState {
        CharacterListItemViewState(
            id: state.id,
            image: image,
            name: state.name,
            status: state.status.rawValue,
            species: state.species,
            gender: state.gender.rawValue,
            origin: "from: \(state.origin.name)",
            location: "at \(state.location.name)",
            episodes: state.episode.compactMap { "Episode \($0.lastPathComponent)" },
            isFavourite: isFavorite
        )
    }
}

extension CharacterListItemViewState {
    static var empty: CharacterListItemViewState {
        CharacterListItemViewState(id: 0, image: nil, name: "", status: "", species: "", gender: "", origin: "", location: "", episodes: [], isFavourite: false)
    }
}
