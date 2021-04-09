//
//  AppState.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation

struct AppState: Equatable {
    var characterListState: CharacterListState
}

extension AppState {
    static let initial = AppState(characterListState: .empty)
}
