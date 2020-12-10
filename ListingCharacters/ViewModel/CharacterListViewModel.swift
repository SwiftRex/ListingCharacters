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
    let favouritesRepository: FavouritesRepository

    init(serviceProtocolType: CharacterAPI.Type, favouritesRepository: FavouritesRepository) {
        self.serviceProtocolType = serviceProtocolType
        self.favouritesRepository = favouritesRepository
    }

    func toggleCharacterFavourite(id: Int) {
        characterList.change(id: id) { _, character in
            character.isFavourite = !character.isFavourite
            if character.isFavourite {
                favouritesRepository.addCharacterToFavouriteList(id: id)
            } else {
                favouritesRepository.removeCharacterFromFavouriteList(id: id)
            }
        }
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
                    self?.fromModel(model: item)
                }
            })

        cancellables.insert(cancellable)

    }

    func fromModel(model: Character) -> CharacterListItemViewModel {
        CharacterListItemViewModel(id: model.id,
                                   image: model.image,
                                   name: model.name,
                                   status: model.status.rawValue,
                                   species: model.species,
                                   gender: model.gender.rawValue,
                                   origin: "from: \(model.origin.name)",
                                   location: "at \(model.location.name)",
                                   episodes: model.episode.compactMap { "Episode \($0.lastPathComponent)"
                                   },
                                   isFavourite: self.favouritesRepository.isFavourite(id: model.id)
        )
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
        var isFavourite: Bool

        var favouriteImageName: String {
            isFavourite ? "star.fill" : "star"
        }
    }
}
