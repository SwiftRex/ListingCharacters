//
//  CharacterModel.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import Foundation

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: URL
    let url: URL
    let episode: [URL]
    let created: Date?
}

enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}

enum Gender: String, Decodable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown
}

struct Location: Decodable {
    let name: String
    let url: URL?

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    init(name: String, url: URL?) {
        self.name = name
        self.url = url
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        url = try? values.decode(URL.self, forKey: .url)
    }
}
