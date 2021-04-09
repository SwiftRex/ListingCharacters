//
//  CharacterDetailsViewState.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation
import CoreGraphics

struct CharacterDetailsViewState: Equatable, Identifiable {
    let id: Int
    let image: CGImage?
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: String
    let location: String
    let episodes: [String]
    var favouriteImageName: String
}

extension CharacterDetailsViewState {
    static func from(state: CharacterListState, characterId: Int) -> CharacterDetailsViewState {
        guard let character = state.characteres.first(where: { $0.id == characterId }) else { return .empty }

        return from(
            state: character,
            image: state.images[character.image],
            isFavorite: state.favourites.contains(character.id)
        )
    }

    static func from(state: Character, image: CGImage?, isFavorite: Bool) -> CharacterDetailsViewState {
        CharacterDetailsViewState(
            id: state.id,
            image: image,
            name: state.name,
            status: state.status.rawValue,
            species: state.species,
            gender: state.gender.rawValue,
            origin: "from: \(state.origin.name)",
            location: "at \(state.location.name)",
            episodes: state.episode.compactMap { "Episode \($0.lastPathComponent)" },
            favouriteImageName: isFavorite ? "star.fill" : "star"
        )
    }

    static var empty: CharacterDetailsViewState {
        CharacterDetailsViewState(
            id: 0,
            image: nil,
            name: "",
            status: "",
            species: "",
            gender: "",
            origin: "",
            location: "",
            episodes: [],
            favouriteImageName: "star"
        )
    }
}
