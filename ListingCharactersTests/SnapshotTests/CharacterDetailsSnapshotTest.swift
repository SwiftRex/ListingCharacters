//
//  CharacterDetailsSnapshotTest.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 10/12/20.
//

@testable import ListingCharacters
class CharacterDetailsSnapshotTest: SnapshotTestsBase {

    func testCharacterDetails() {
        let sut = CharacterDetails_Previews.previews
        assertSnapshotDevices(sut)
    }
}
