//
//  CharacterAction.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation
import CoreGraphics

enum CharacterAction {
    case readFirstPage
    case readNextPage
    case gotCharacters([Character], page: CharacterPaging)
    case toggleFavorite(Int)
    case fetchImage(characterId: Int)
    case cancelFetchImage(characterId: Int)
    case imageGotDownloaded(URL, CGImage)
}
