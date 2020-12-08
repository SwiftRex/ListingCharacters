//
//  CharacterListResponse.swift
//  ListingCharacters
//
//  Created by Jarbas on 07/12/20.
//

import Foundation

struct CharacterListResponse: Decodable {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: URL?
        let prev: URL?
    }

    let info: Info
    let results: [Character]
}
