//
//  Store.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 08.04.21.
//

import CombineRex
import Foundation
import LoggerMiddleware

struct AppState: Equatable {
    var characterListState: CharacterListState
}

extension AppState {
    static let initial = AppState(characterListState: .empty)
}

enum LifecycleActions {
    case launched
    case backgrounded
    case foregrounded
}

enum AppAction {
    case lifecycle(LifecycleActions)
    case character(CharacterActions)
}

extension AppAction {
    public var lifecycle: LifecycleActions? {
        get {
            guard case let .lifecycle(value) = self else { return nil }
            return value
        }
        set {
            guard case .lifecycle = self, let newValue = newValue else { return }
            self = .lifecycle(newValue)
        }
    }

    public var isLifecycle: Bool {
        self.lifecycle != nil
    }

    public var character: CharacterActions? {
        get {
            guard case let .character(value) = self else { return nil }
            return value
        }
        set {
            guard case .character = self, let newValue = newValue else { return }
            self = .character(newValue)
        }
    }

    public var isCharacter: Bool {
        self.character != nil
    }
}

extension Reducer where ActionType == AppAction, StateType == AppState {
    static let app: Reducer<AppAction, AppState> =
        Reducer<CharacterActions, CharacterListState>
            .character
            .lift(action: \.character, state: \.characterListState)
}

extension ComposedMiddleware where InputActionType == AppAction, OutputActionType == AppAction, StateType == AppState {
    static func app(world: World) -> ComposedMiddleware<AppAction, AppAction, AppState> {
        let loggerQueue = DispatchQueue(label: "de.teufel.TeufelStreaming.app-logger.queue",
                                        qos: .background)
        return
            CharacterMiddleware(characterService: CharacterService(urlRequester: world.session, decoder: world.decoder))
                .lift(inputAction: \.character, outputAction: AppAction.character, state: \.characterListState)

            <> IdentityMiddleware().logger(
                stateDiffTransform: .recursive(
                    prefixLines: "🏛",
                    stateName: "AppState",
                    filters: [
                        // some collections are too noisy
                    ]
                ),
                queue: loggerQueue
            )
    }
}

class Store: ReduxStoreBase<AppAction, AppState> {
    init(world: World) {
        super.init(
            subject: .combine(initialValue: .initial),
            reducer: Reducer.app,
            middleware: ComposedMiddleware.app(world: world)
        )
    }
}
