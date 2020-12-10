//
//  CharacterService.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import Foundation
import Combine

struct CharacterService: CharacterAPI {

    private static var  urlSession: URLSession =  URLSession.shared
    static let apiBaseURL = "https://rickandmortyapi.com/api/character/?page="

    static func getAll(page: Int = 1) -> AnyPublisher<[Character], APIError> {
        let jsonDecoder = JSONDecoder()
       jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        let url = "\(Self.apiBaseURL)\(page)"
        return Self.urlSession.dataTaskPublisher(for: URL(string: url)!)
            .decode(type: CharacterListResponse.self, decoder: jsonDecoder).eraseToAnyPublisher()
            .map { response -> [Character] in
                return response.results
            }.eraseToAnyPublisher()
    }
}

struct CharacterFakeService: CharacterAPI {
    static func getAll(page: Int)
    -> AnyPublisher<[Character], APIError> {
        let imageRickURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
        let imageMortyURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
        let imageSummerURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!
        let imageBethURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg")!
        let rickURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
        let mortyURL = URL(string: "https://rickandmortyapi.com/api/character/2")!
        let summerURL = URL(string: "https://rickandmortyapi.com/api/character/3")!
        let bethURL = URL(string: "https://rickandmortyapi.com/api/character/4")!
        let origin = Location(name: "Earth (C-137)", url: nil)
        let location = Location(name: "Earth (Replacement Dimension)", url: nil)
        let rick = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human",
                             type: "",
                             gender: .male,
                             origin: origin,
                             location: location, image: imageRickURL, url: rickURL, episode: [], created: nil)
        let morty = Character(id: 2, name: "Morty Smith", status: .alive, species: "Human",
                             type: "",
                             gender: .male,
                             origin: origin,
                             location: location, image: imageMortyURL, url: mortyURL, episode: [], created: nil)

        let summer = Character(id: 3, name: "Summer Smith", status: .alive, species: "Human",
                             type: "",
                             gender: .female,
                             origin: origin,
                             location: location, image: imageBethURL, url: summerURL, episode: [], created: nil)
        let beth = Character(id: 4,
                             name: "Beth Smith",
                             status: .alive,
                             species: "Human",
                             type: "",
                             gender: .female,
                             origin: origin,
                             location: location, image: imageSummerURL, url: bethURL, episode: [], created: nil)
        let chars: [Character] = [rick, morty, summer, beth]
        return Result.Publisher(chars).eraseToAnyPublisher()
    }
}
