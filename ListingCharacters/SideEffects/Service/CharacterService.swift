//
//  CharacterService.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import Combine
import CoreGraphics
import Foundation

struct CharacterService {
    let urlRequester: URLRequester
    let decoder: () -> JSONDecoder

    init(urlRequester: @escaping URLRequester, decoder: @escaping () -> JSONDecoder) {
        self.urlRequester = urlRequester
        self.decoder = decoder
    }

    private let apiBaseURL = "https://rickandmortyapi.com/api/character/?page="

    func getAll(page: Int = 1) -> AnyPublisher<CharacterListResponse, APIError> {
        let url = URL(string: "\(apiBaseURL)\(page)").unwrapOrDie()
        return urlRequester(URLRequest(url: url))
            .decode(type: CharacterListResponse.self, decoder: decoder())
            .eraseToAnyPublisher()
    }

    func getAll(page: CharacterPaging) -> AnyPublisher<CharacterListResponse, APIError> {
        guard let url = page.next else { return Empty().eraseToAnyPublisher() }
        
        return urlRequester(URLRequest(url: url))
            .decode(type: CharacterListResponse.self, decoder: decoder())
            .eraseToAnyPublisher()
    }

    func getImage(from url: URL) -> AnyPublisher<CGImage, APIError> {
        urlRequester(URLRequest(url: url))
            .decodeImage()
    }
}
