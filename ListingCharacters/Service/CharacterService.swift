//
//  CharacterService.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import Foundation
import Combine

struct CharacterService {
    static let apiBaseURL = "https://rickandmortyapi.com/api/character/?page="
    static func getAll(urlSession: URLSession, page: Int = 1) -> AnyPublisher<[Character], APIError> {
        let jsonDecoder = JSONDecoder()
       jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        let url = "\(Self.apiBaseURL)\(page)"
        return urlSession.dataTaskPublisher(for: URL(string: url)!)
            .decode(type: CharacterListResponse.self, decoder: jsonDecoder).eraseToAnyPublisher()
            .map { response -> [Character] in
                return response.results
            }.eraseToAnyPublisher()
    }
}
