//
//  CharacterMiddleware.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Combine
import Foundation
import SwiftRex

class CharacterMiddleware: Middleware {
    typealias InputActionType = CharacterAction
    typealias OutputActionType = CharacterAction
    typealias StateType = CharacterListState

    private var getState: GetState<CharacterListState>?
    private var output: AnyActionHandler<CharacterAction>?
    private let characterService: CharacterService
    private var cancellables = Set<AnyCancellable>()
    private var imageDownloads: [URL: AnyCancellable] = [:]

    init(characterService: CharacterService) {
        self.characterService = characterService
    }

    func receiveContext(getState: @escaping GetState<CharacterListState>, output: AnyActionHandler<CharacterAction>) {
        self.getState = getState
        self.output = output
    }

    func handle(action: CharacterAction, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        guard let getState = getState, let output = output else { return }

        afterReducer = .do {
            switch action {
            case .readFirstPage, .readNextPage:
                self.characterService
                    .getAll(page: getState().pageInfo)
                    .sink(
                        receiveCompletion: { completion in }, // TODO: Handle error
                        receiveValue: { response in
                            output.dispatch(.gotCharacters(response.results, page: response.info))
                        }
                    )
                    .store(in: &self.cancellables)
            case let .fetchImage(characterId):
                guard let url = getState().characteres.first(where: { $0.id == characterId })?.image else { return }

                let downloadTask = self.characterService
                    .getImage(from: url)
                    .sink(
                        receiveCompletion: { completion in }, // TODO: Handle error
                        receiveValue: { image in
                            output.dispatch(.imageGotDownloaded(url, image))
                        }
                    )
                self.imageDownloads[url] = downloadTask
            case let .cancelFetchImage(characterId):
                guard let url = getState().characteres.first(where: { $0.id == characterId })?.image else { return }

                self.imageDownloads[url] = nil
            case let .imageGotDownloaded(url, _):
                self.imageDownloads.removeValue(forKey: url)
            case .toggleFavorite:
                break
            case .gotCharacters, .closeDetails, .openDetails:
                return
            }

        }
    }
}
