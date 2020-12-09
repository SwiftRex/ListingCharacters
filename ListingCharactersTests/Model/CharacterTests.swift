//
//  CharacterTests.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 07/12/20.
//

import XCTest
import Combine
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

    func testGetAllCharacteresAPISuccess() {
        let sut = PassthroughSubject<(data: Data, response: URLResponse), URLError>()
        let shouldCallValueClosure = expectation(description: "output closure should have been called")
        let shouldCallSuccessCompletion = expectation(
            description: "successful completion closure should have been called")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        let cancellable = sut
            .decode(type: CharacterListResponse.self, decoder: decoder)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished:
                        shouldCallSuccessCompletion.fulfill()

                    case let .failure(error):
                        XCTFail("It was expected to succeed, but it failed with error \(error)")
                    }
                },
                receiveValue: { apiResponse in
                    XCTAssertEqual(apiResponse.results[0].id, 1)
                    shouldCallValueClosure.fulfill()
                }
            )
        let url = Bundle.main.url(forResource: "characterssampledata", withExtension: "json")
        let data = try? Data(contentsOf: url!)

        let response = HTTPURLResponse(url: URL(string: "htttps:/my.url.com")!,
                                       statusCode: 200, httpVersion: nil, headerFields: nil)!
        sut.send((data: data!, response: response))
        sut.send(completion: .finished)

        wait(for: [shouldCallValueClosure, shouldCallSuccessCompletion], timeout: 0.5)

        _ = cancellable
    }

    func testGetCharacterAPIStatusCodeError() {
        let sut = PassthroughSubject<(data: Data, response: URLResponse), URLError>()
        let shouldCallErrorClosure = expectation(description: "Error closure should have been called")

        let cancellable = sut
            .decode(type: Character.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished:
                        XCTFail("It was expected to fail")

                    case let .failure(.unexpectedStatusCode(statusCode)):
                        XCTAssertEqual(statusCode, 400)
                        shouldCallErrorClosure.fulfill()

                    case .failure:
                        XCTFail("It was expected to fail with status code 300")
                    }
                },
                receiveValue: { _ in
                    XCTFail("It was expected to fail")
                }
            )

        let response = HTTPURLResponse(url: URL(string: "https://goggle.com")!,
                                       statusCode: 400, httpVersion: nil, headerFields: nil)!
        sut.send((data: Data(), response: response))
        sut.send(completion: .finished)
        wait(for: [shouldCallErrorClosure], timeout: 0.1)

        _ = cancellable
    }
}
