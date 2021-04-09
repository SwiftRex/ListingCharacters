//
//  CharacterListViewProducer.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import CombineRextensions
import Foundation
import SwiftRex

extension ViewProducer where Context == Void, ProducedView == CharacterListView {
    static func characterList<S: StoreType>(store: S) -> ViewProducer where S.ActionType == AppAction, S.StateType == AppState {
        ViewProducer {
            CharacterListView(
                viewModel: store.projection(
                    action: { $0.toAppAction() },
                    state: { CharacterListViewState.from(state: $0.characterListState) }
                ).asObservableViewModel(initialState: .empty),
                characterDetails: .characterDetails(store: store)
            )
        }
    }
}
