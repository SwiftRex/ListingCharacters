//
//  CharacterDetailsViewProducer.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import CombineRextensions
import Foundation
import SwiftRex

extension ViewProducer where Context == Int, ProducedView == CharacterDetailsView {
    static func characterDetails<S: StoreType>(store: S) -> ViewProducer where S.ActionType == AppAction, S.StateType == AppState {
        ViewProducer { characterId in
            CharacterDetailsView(
                viewModel: store.projection(
                    action: { $0.toAppAction(characterId: characterId) },
                    state: { CharacterDetailsViewState.from(state: $0.characterListState, characterId: characterId) }
                ).asObservableViewModel(initialState: .empty)
            )
        }
    }
}
