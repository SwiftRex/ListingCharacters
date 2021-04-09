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
    var toAppAction: AppAction {
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

enum CharacterListItemViewAction {
    case toggleFavorite
    case fetchImage
    case cancelFetchImage
}

struct CharacterListViewState: Equatable {
    let rows: [CharacterListItemViewState]
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
            }
        )
    }
}

extension CharacterListViewState {
    static var empty: CharacterListViewState {
        CharacterListViewState(rows: [])
    }
}

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
