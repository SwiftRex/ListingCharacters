//
//  LifecycleAction.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation

enum LifecycleAction {
    case launched
    case backgrounded
    case foregrounded
}

extension LifecycleAction {
    public var launched: Void? {
        guard case .launched = self else { return nil }
        return ()
    }

    public var isLaunched: Bool {
        self.launched != nil
    }
}

extension LifecycleAction {
    public var backgrounded: Void? {
        guard case .backgrounded = self else { return nil }
        return ()
    }

    public var isBackgrounded: Bool {
        self.backgrounded != nil
    }
}

extension LifecycleAction {
    public var foregrounded: Void? {
        guard case .foregrounded = self else { return nil }
        return ()
    }

    public var isForegrounded: Bool {
        self.foregrounded != nil
    }
}
