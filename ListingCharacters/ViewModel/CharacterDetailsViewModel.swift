//
//  CharacterDetailsViewModel.swift
//  ListingCharacters
//
//  Created by Jarbas on 06/12/20.
//

import Combine
import SwiftUI

class CharacterDetailsViewModel: ObservableObject {
    var character: Character

    init(character: Character) {
        self.character = character
    }

    func getCharacter() { }
}
