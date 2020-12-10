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
    @Published var pagingInfo: CharacterListResponse.Info =  CharacterListResponse.Info(count: 0,
                                                                                        pages: 0,
                                                                                        next: nil,
                                                                                        prev: nil)
    @Published var page: Int = 1

    var cancellables = Set<AnyCancellable>()
    let serviceProtocolType: CharacterAPI.Type
    let favouritesRepository: FavouritesRepository

    init(serviceProtocolType: CharacterAPI.Type, favouritesRepository: FavouritesRepository) {
        self.serviceProtocolType = serviceProtocolType
        self.favouritesRepository = favouritesRepository
    }

    private func updatePage() {
        if let nextPage = self.pagingInfo.next {
            let pageAsStr = nextPage.query?.split(separator: "=").last
            if let actualPage = pageAsStr {
                if let pageAsInt = Int(actualPage) {
                    self.page = pageAsInt
                }
            }
        }
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

    func getCharacterList() {
        let cancellable = serviceProtocolType.getAll(page: self.page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.pagingInfo = response.info
                self?.characterList.append(contentsOf: response.results.compactMap { item in
                    self?.fromModel(model: item)
                })
                self?.updatePage()
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
