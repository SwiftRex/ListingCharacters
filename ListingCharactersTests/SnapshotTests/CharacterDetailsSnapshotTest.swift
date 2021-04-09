//
//  CharacterDetailsSnapshotTest.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 10/12/20.
//

@testable import ListingCharacters
import XCTest

class CharacterDetailsSnapshotTest: SnapshotTestsBase {

    func testCharacterDetails() {
        let sut = CharacterDetailsViewPreviews.previews
        assertSnapshotDevices(sut)
    }
}
