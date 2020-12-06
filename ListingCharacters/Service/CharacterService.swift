//
//  CharacterService.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import Foundation

protocol CharacterService {
    func getCharacterList(page: Int) -> [Character]
    func getCharacterDetails(id: Int) -> Character
}
