//
//  CharacterListResponse.swift
//  ListingCharacters
//
//  Created by Jarbas on 07/12/20.
//

import Foundation

struct CharacterListResponse: Decodable {
    let info: CharacterPaging
    let results: [Character]
}

struct CharacterPaging: Decodable, Equatable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

extension CharacterPaging {
    static var empty: CharacterPaging {
        .init(
            count: 0,
            pages: -1,
            next: unwrapOrDie(URL(string: "https://rickandmortyapi.com/api/character/?page=1")),
            prev: nil
        )
    }
}
