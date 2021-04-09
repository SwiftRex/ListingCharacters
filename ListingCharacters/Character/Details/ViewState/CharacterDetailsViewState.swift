//
//  CharacterDetailsViewState.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation

struct CharacterDetailsViewState: Equatable {
    static func from(state: CharacterListState, characterId: Int) -> CharacterDetailsViewState {
        guard let character = state.characteres.first(where: { $0.id == characterId }) else { return .empty }
        return .init()
    }

    static var empty: CharacterDetailsViewState {
        .init()
    }
}
