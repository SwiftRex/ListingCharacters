//
//  API.swift
//  ListingCharacters
//
//  Created by Jarbas on 07/12/20.
//

import Combine

protocol API {
    func getCharacter(by id: String) -> AnyPublisher<Character, Error>
    func getAllCharacteres() -> AnyPublisher<[Character], Error>
}
