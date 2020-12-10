//
//  CharacterDetailsViewModel.swift
//  ListingCharacters
//
//  Created by Jarbas on 06/12/20.
//
import Combine
import SwiftUI

class CharacterDetailsViewModel: ObservableObject {
    var character: CharacterListViewModel.CharacterListItemViewModel

    init(character: CharacterListViewModel.CharacterListItemViewModel) {
        self.character = character
    }
}
