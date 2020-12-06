//
//  CharacterModel.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import Foundation

struct Character: Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Location
    var location: Location
    var image: String
    var episodes: [String]
    var url: String
    var created: String

    struct Location {
        var name: String
        var url: String
    }
}
