//
//  CharacterListSnapshotTest.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 10/12/20.
//

import Foundation
@testable import ListingCharacters
import SwiftUI

class CharacterListSnapshotTest: SnapshotTestsBase {

    func testCharacterList() {
        let state = CharacterListState(
            characteres: fakeCharacters(),
            pageInfo: CharacterPaging(count: 4, pages: 1, next: nil, prev: nil),
            favourites: [],
            images: [:]
        )
        let sut = CharacterListView(
            viewModel: .mock(state: CharacterListViewState.from(state: state)),
            characterDetails: { _ in AnyView(EmptyView()) }
        )

        assertSnapshotDevices(sut)
    }
}
