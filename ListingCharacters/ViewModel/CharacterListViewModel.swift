//
//  CharacterListViewModel.swift
//  ListingCharacters
//
//  Created by Jarbas on 06/12/20.
//

import Combine
import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characterList: [CharacterListItemViewModel] = []
    var cancellables = Set<AnyCancellable>()
    let serviceProtocolType: CharacterAPI.Type

    init(serviceProtocolType: CharacterAPI.Type) {
        self.serviceProtocolType = serviceProtocolType
    }
    func getCharacterList(page: Int = 1) {
        let cancellable = serviceProtocolType.getAll(page: 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] list in
                self?.characterList = list.compactMap { item in
                    CharacterListItemViewModel(id: item.id,
                                               image: item.image,
                                               name: item.name,
                                               status: item.status.rawValue,
                                               species: item.species,
                                               gender: item.gender.rawValue,
                                               origin: "from: \(item.origin.name)",
                                               location: "at \(item.location.name)",
                                               episodes: item.episode.compactMap { "Episode \($0.lastPathComponent)" })
                }
            })

        cancellables.insert(cancellable)

    }

    struct CharacterListItemViewModel: Identifiable {
        let id: Int
        let image: URL
        let name: String
        let status: String
        let species: String
        let gender: String
        let origin: String
        let location: String
        let episodes: [String]
    }
}
