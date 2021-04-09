//
//  CharacterListViewModel.swift
//  ListingCharacters
//
//  Created by Jarbas on 06/12/20.
//

import Combine
import CoreGraphics
import Foundation

enum CharacterListViewAction {
    case onAppear
    case onScrollToTheBottom
    case item(id: Int, action: CharacterListItemViewAction)
}

extension CharacterListViewAction {
    func toAppAction() -> AppAction {
        switch self {
        case .onAppear:
            return .character(.readFirstPage)
        case .onScrollToTheBottom:
            return .character(.readNextPage)
        case let .item(id, .toggleFavorite):
            return .character(.toggleFavorite(id))
        case let .item(id, action: .fetchImage):
            return .character(.fetchImage(characterId: id))
        case let .item(id, action: .cancelFetchImage):
            return .character(.cancelFetchImage(characterId: id))
        }
    }
}
