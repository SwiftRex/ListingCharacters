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
    var favouriteImageName: String

    static func from(state: Character, image: CGImage?, isFavorite: Bool) -> CharacterListItemViewState {
        CharacterListItemViewState(
            id: state.id,
            image: image,
            name: state.name,
            status: state.status.rawValue,
            species: state.species,
            gender: state.gender.rawValue,
            favouriteImageName: isFavorite ? "star.fill" : "star"
        )
    }
}

extension CharacterListItemViewState {
    static var empty: CharacterListItemViewState {
        CharacterListItemViewState(id: 0, image: nil, name: "", status: "", species: "", gender: "", favouriteImageName: "star")
    }
}
