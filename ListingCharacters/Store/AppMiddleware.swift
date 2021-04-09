//
//  AppMiddleware.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation
import SwiftRex

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
