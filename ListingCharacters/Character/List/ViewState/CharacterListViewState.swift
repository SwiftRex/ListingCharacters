//
//  CharacterListViewState.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation

struct CharacterListViewState: Equatable {
    let rows: [CharacterListItemViewState]
    let selectedCharacter: Int?
}

extension CharacterListViewState {
    static func from(state: CharacterListState) -> CharacterListViewState {
        CharacterListViewState(
            rows: state.characteres.compactMap { character in
                CharacterListItemViewState.from(
                    state: character,
                    image: state.images[character.image],
                    isFavorite: state.favourites.contains(character.id)
                )
            },
            selectedCharacter: state.viewDetails
        )
    }
}

extension CharacterListViewState {
    static var empty: CharacterListViewState {
        CharacterListViewState(rows: [], selectedCharacter: nil)
    }
}
