//
//  Store.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 08.04.21.
//

import CombineRex
import Foundation
import LoggerMiddleware

class Store: ReduxStoreBase<AppAction, AppState> {
    init(world: World) {
        super.init(
            subject: .combine(initialValue: .initial),
            reducer: Reducer.app,
            middleware: ComposedMiddleware.app(world: world)
        )
    }
}
