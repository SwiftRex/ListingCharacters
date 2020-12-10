//
//  CharacterListViewModelTests.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 10/12/20.
//

import XCTest
@testable import ListingCharacters

class CharacterListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsFavouriteToggle() throws {
        let viewModel = CharacterListViewModel(serviceProtocolType:
                                                CharacterFakeService.self,
                                               favouritesRepository: FavouriteRepositoryFake())

        viewModel.getCharacterList()
        let expectation = self.expectation(description: "wait")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 0.1)
        let char = viewModel.characterList.first!
        viewModel.toggleCharacterFavourite(id: char.id)
        let firstFav = viewModel.characterList.first(where: {$0.id == char.id})!.isFavourite
        viewModel.toggleCharacterFavourite(id: char.id)
        let secondFav = viewModel.characterList.first(where: {$0.id == char.id})!.isFavourite
        XCTAssertNotEqual(char.isFavourite, firstFav)
        XCTAssertNotEqual(firstFav, secondFav)

    }

}
