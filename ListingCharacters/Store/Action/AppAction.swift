//
//  AppAction.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation

enum AppAction {
    case lifecycle(LifecycleAction)
    case character(CharacterAction)
}

extension AppAction {
    public var lifecycle: LifecycleAction? {
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

    public var character: CharacterAction? {
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
