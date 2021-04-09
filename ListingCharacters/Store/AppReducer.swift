//
//  AppReducer.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation
import SwiftRex

extension Reducer where ActionType == AppAction, StateType == AppState {
    static let app: Reducer<AppAction, AppState> =
        Reducer<CharacterAction, CharacterListState>
            .character
            .lift(action: \.character, state: \.characterListState)
}
