//
//  CharacterDetailsViewAction.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation

enum CharacterDetailsViewAction {
    case toggleFavorite
    case fetchImage
    case cancelFetchImage
}

extension CharacterDetailsViewAction {
    func toAppAction(characterId: Int) -> AppAction {
        switch self {
        case .toggleFavorite:
            return .character(.toggleFavorite(characterId))
        case .fetchImage:
            return .character(.fetchImage(characterId: characterId))
        case .cancelFetchImage:
            return .character(.cancelFetchImage(characterId: characterId))
        }
    }
}
