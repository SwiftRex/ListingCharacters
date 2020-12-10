//
//  FavouritesRepositoryTests.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 10/12/20.
//

import XCTest
import Foundation
@testable import ListingCharacters

class FavouritesRepositoryTests: XCTestCase {

    func testAddNewFavourite() throws {
        let defaults = UserDefaults()
        let characterID = 200000
        defaults.addCharacterToFavouriteList(id: characterID)
        let characters = defaults.favouritesCharacters
        XCTAssertTrue(characters.contains(characterID))
    }

    func testRemoveNewFavourite() throws {
        let defaults = UserDefaults()
        let characterID = 100000
        defaults.addCharacterToFavouriteList(id: characterID)
        XCTAssertTrue(defaults.favouritesCharacters.contains(characterID))
        defaults.removeCharacterFromFavouriteList(id: characterID)
        XCTAssertFalse(defaults.favouritesCharacters.contains(characterID))
    }

}
