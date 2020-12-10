//
//  CharacterListSnapshotTest.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 10/12/20.
//

@testable import ListingCharacters
import Foundation
class CharacterListSnapshotTest: SnapshotTestsBase {

    func testCharacterList() {
        let viewModel = CharacterListViewModel(serviceProtocolType:
                                                CharacterFakeService.self,
                                               favouritesRepository: FavouriteRepositoryFake())
        viewModel.getCharacterList()
        let sut = CharacterList(viewModel: viewModel)

        let expectation = self.expectation(description: "wait")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
        assertSnapshotDevices(sut)
    }
}
