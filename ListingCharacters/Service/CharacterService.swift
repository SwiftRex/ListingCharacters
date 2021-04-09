//
//  CharacterService.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import Foundation
import Combine

struct CharacterService {
    let urlRequester: URLRequester
    let decoder: () -> JSONDecoder

    init(urlRequester: @escaping URLRequester, decoder: @escaping () -> JSONDecoder) {
        self.urlRequester = urlRequester
        self.decoder = decoder
    }

    private let apiBaseURL = "https://rickandmortyapi.com/api/character/?page="

    func getAll(page: Int = 1) -> AnyPublisher<CharacterListResponse, APIError> {
        let url = unwrapOrDie(URL(string: "\(apiBaseURL)\(page)"))
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
}

//struct CharacterFakeService: CharacterAPI {
//    static func getAll(page: Int)
//    -> AnyPublisher<CharacterListResponse, APIError> {
//        let imageRickURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
//        let imageMortyURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
//        let imageSummerURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")!
//        let imageBethURL = URL(string: "https://rickandmortyapi.com/api/character/avatar/4.jpeg")!
//        let rickURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
//        let mortyURL = URL(string: "https://rickandmortyapi.com/api/character/2")!
//        let summerURL = URL(string: "https://rickandmortyapi.com/api/character/3")!
//        let bethURL = URL(string: "https://rickandmortyapi.com/api/character/4")!
//        let origin = Location(name: "Earth (C-137)", url: nil)
//        let location = Location(name: "Earth (Replacement Dimension)", url: nil)
//        let rick = Character(id: 1, name: "Rick Sanchez", status: .alive, species: "Human",
//                             type: "",
//                             gender: .male,
//                             origin: origin,
//                             location: location, image: imageRickURL, url: rickURL, episode: [], created: nil)
//        let morty = Character(id: 2, name: "Morty Smith", status: .alive, species: "Human",
//                              type: "",
//                              gender: .male,
//                              origin: origin,
//                              location: location, image: imageMortyURL, url: mortyURL, episode: [], created: nil)
//
//        let summer = Character(id: 3, name: "Summer Smith", status: .alive, species: "Human",
//                               type: "",
//                               gender: .female,
//                               origin: origin,
//                               location: location, image: imageBethURL, url: summerURL, episode: [], created: nil)
//        let beth = Character(id: 4,
//                             name: "Beth Smith",
//                             status: .alive,
//                             species: "Human",
//                             type: "",
//                             gender: .female,
//                             origin: origin,
//                             location: location, image: imageSummerURL, url: bethURL, episode: [], created: nil)
//        let chars: [Character] = [rick, morty, summer, beth]
//        let response = CharacterListResponse(info: CharacterListResponse.Info(count: 1, pages: 1,
//                                                                              next: nil, prev: nil), results: chars)
//        return Result.Publisher(response).eraseToAnyPublisher()
//    }
//}

func unwrapOrDie<P>(_ value: P?, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> P {
    if let value = value { return value }
    fatalError("Error trying to unwrap value from type \(P.self). \(file):\(line)/\(function)")
}
