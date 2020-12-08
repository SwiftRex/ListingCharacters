//
//  CharacterTests.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 07/12/20.
//

import XCTest
@testable import ListingCharacters

class CharacterTests: XCTestCase {

    func testDecode() throws {
        let url = Bundle.main.url(forResource: "characterssampledata", withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        //let data = json.data(using: .utf8)!
        let apiResponse = try decoder.decode(CharacterListResponse.self, from: data)
        XCTAssertEqual(apiResponse.info.count, 671)
        XCTAssertEqual(apiResponse.info.pages, 34)
        XCTAssertEqual(apiResponse.info.next, URL(string: "https://rickandmortyapi.com/api/character/?page=2")!)
        XCTAssertNil(apiResponse.info.prev)
        XCTAssertEqual(apiResponse.results.count, 20)

        let rick = apiResponse.results[0]
        XCTAssertEqual(rick.id, 1)
        XCTAssertEqual(rick.name, "Rick Sanchez")
        XCTAssertEqual(rick.species, "Human")
        XCTAssertEqual(rick.type, "")
        XCTAssertEqual(rick.gender.rawValue, "Male")
        XCTAssertEqual(rick.origin.name, "Earth (C-137)")
        XCTAssertEqual(rick.origin.url?.absoluteString, "https://rickandmortyapi.com/api/location/1")
        XCTAssertEqual(rick.location.name, "Earth (Replacement Dimension)")
        XCTAssertEqual(rick.location.url?.absoluteString, "https://rickandmortyapi.com/api/location/20" )
        XCTAssertEqual(rick.image.absoluteString, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        XCTAssertEqual(rick.url.absoluteString, "https://rickandmortyapi.com/api/character/1")
        XCTAssertEqual(rick.episode.count, 41)
    
    }
}

