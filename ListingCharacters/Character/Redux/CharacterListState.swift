//
//  CharacterListState.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation
import CoreGraphics

struct CharacterListState: Equatable {
    var characteres: [Character]
    var pageInfo: CharacterPaging
    var favourites: Set<Int>
    var images: [URL: CGImage]
    var viewDetails: Int?
}

extension CharacterListState {
    static let empty = CharacterListState(
        characteres: [],
        pageInfo: .empty,
        favourites: [],
        images: [:],
        viewDetails: nil
    )
}
