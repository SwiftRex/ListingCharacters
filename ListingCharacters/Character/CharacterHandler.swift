//
//  CharacterHandler.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 08.04.21.
//

import CoreGraphics
import CoreImage
import Foundation
import SwiftRex

struct CharacterListState: Equatable {
    var characteres: [Character]
    var pageInfo: CharacterPaging
    var favourites: Set<Int>
    var images: [URL: CGImage]
}

extension CharacterListState {
    static let empty = CharacterListState(
        characteres: [],
        pageInfo: .empty,
        favourites: [],
        images: [:]
    )
}

enum CharacterActions {
    case readFirstPage
    case readNextPage
    case gotCharacters([Character], page: CharacterPaging)
    case toggleFavorite(Int)
    case fetchImage(characterId: Int)
    case cancelFetchImage(characterId: Int)
    case imageGotDownloaded(URL, CGImage)
}

extension Reducer where ActionType == CharacterActions, StateType == CharacterListState {
    static let character = Reducer<CharacterActions, CharacterListState>.reduce { action, state in
        switch action {
        case .readFirstPage:
            state.pageInfo = .empty
        case .readNextPage:
            break
        case let .toggleFavorite(id):
            if state.favourites.contains(id) {
                state.favourites.remove(id)
            } else {
                state.favourites.insert(id)
            }
        case let .gotCharacters(characters, page):
            state.characteres += characters
            state.pageInfo = page
        case let .imageGotDownloaded(url, image):
            state.images[url] = image
        case .fetchImage, .cancelFetchImage:
            break
        }
    }
}

// FP

import Combine
// OOP
class CharacterMiddleware: Middleware {
    typealias InputActionType = CharacterActions
    typealias OutputActionType = CharacterActions
    typealias StateType = CharacterListState

    private var getState: GetState<CharacterListState>?
    private var output: AnyActionHandler<CharacterActions>?
    private let characterService: CharacterService
    private var cancellables = Set<AnyCancellable>()
    private var imageDownloads: [URL: AnyCancellable] = [:]

    init(characterService: CharacterService) {
        self.characterService = characterService
    }

    func receiveContext(getState: @escaping GetState<CharacterListState>, output: AnyActionHandler<CharacterActions>) {
        self.getState = getState
        self.output = output
    }

    func handle(action: CharacterActions, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
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
            case .gotCharacters:
                return
            }

        }
    }
}
