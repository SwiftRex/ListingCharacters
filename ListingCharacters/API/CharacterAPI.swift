//
//  CharacterAPI.swift
//  ListingCharacters
//
//  Created by Jarbas on 09/12/20.
//

import Foundation
import Combine

protocol CharacterAPI {
    static func getAll(page: Int) -> AnyPublisher<[Character], APIError>
}
