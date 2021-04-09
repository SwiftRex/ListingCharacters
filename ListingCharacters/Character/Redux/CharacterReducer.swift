//
//  CharacterReducer.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation
import SwiftRex

extension Reducer where ActionType == CharacterAction, StateType == CharacterListState {
    static let character = Reducer<CharacterAction, CharacterListState>.reduce { action, state in
        switch action {
        case .readFirstPage:
            state.pageInfo = .empty
        case .readNextPage:
            break
        case let .toggleFavorite(id):
            if state.favourites.contains(id) {
                state.favourites.remove(id)
            } else {
                state.favourites.insert(id)
            }
        case let .gotCharacters(characters, page):
            state.characteres += characters
            state.pageInfo = page
        case let .imageGotDownloaded(url, image):
            state.images[url] = image
        case .fetchImage, .cancelFetchImage:
            break
        }
    }
}
