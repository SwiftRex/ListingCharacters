//
//  ListingCharactersApp.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import CombineRex
import SwiftUI

let world = World.live

@main
struct ListingCharactersApp: App {
    @StateObject var store = Store(world: world).asObservableViewModel(initialState: .initial)

    var body: some Scene {
        WindowGroup {
            mainView
        }
    }
}

extension ListingCharactersApp {
    var mainView: CharacterList {
        CharacterList(
            viewModel: store.projection(
                action: { $0.toAppAction },
                state: { CharacterListViewState.from(state: $0.characterListState) }
            ).asObservableViewModel(initialState: .empty),
            characterDetails: { id in
                AnyView(EmptyView())
            }
        )
    }
}
