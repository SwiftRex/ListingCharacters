//
//  World.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 08.04.21.
//

import Combine
import Foundation

struct Repository {
    let favoritesRepository: FavoritesRepository
}

extension Repository {
    static let live = Repository(favoritesRepository: .live)
}

#if DEBUG
extension Repository {
    static let mock = Repository(favoritesRepository: .mock)
}
#endif


struct FavoritesRepository {
    let readFavourites: () -> [Int]
    let saveFavourites: ([Int]) -> Void
}

extension FavoritesRepository {
    private static let userDefaults = UserDefaults.standard

    static let live = FavoritesRepository(
        readFavourites: {
            let favchars = userDefaults.object(forKey: "favchars") as? [Int]
            guard let characters = favchars else {
                return [Int]()
            }
            return characters
        },
        saveFavourites: { newValue in
            userDefaults.set(newValue, forKey: "favchars")
        }
    )
}

#if DEBUG
extension FavoritesRepository {
    static var _favourites: [Int] = []

    static let mock = FavoritesRepository(
        readFavourites: { _favourites },
        saveFavourites: { _favourites = $0 }
    )
}
#endif

typealias URLRequester = (URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>

struct World {
    let decoder: () -> JSONDecoder
    let session: URLRequester
    let repository: Repository
}

extension World {
    private static let urlSession = URLSession.shared

    static let live = World(
        decoder: {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            return jsonDecoder
        },
        session: { request in
            urlSession
                .dataTaskPublisher(for: request)
                .eraseToAnyPublisher()
        },
        repository: .live
    )
}

#if DEBUG
extension World {
    static let passthroughSession = PassthroughSubject<(data: Data, response: URLResponse), URLError>()

    static let mock = World(
        decoder: {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            return jsonDecoder
        },
        session: { _ in
            passthroughSession
                .eraseToAnyPublisher()
        },
        repository: .live
    )
}
#endif

