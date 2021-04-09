//
//  ListingCharactersApp.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import CombineRex
import CombineRextensions
import SwiftUI

let world = World.live

@main
struct ListingCharactersApp: App {
    @StateObject var store = Store(world: world).asObservableViewModel(initialState: .initial)

    var body: some Scene {
        WindowGroup {
            ViewProducer.characterList(store: store).view()
        }
    }
}
