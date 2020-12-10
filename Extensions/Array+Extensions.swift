//
//  Array+Extensions.swift
//  ListingCharacters
//
//  Created by Jarbas on 10/12/20.
//

import Foundation

extension Array where Element: Identifiable {
    @discardableResult
    public mutating func change(id: Element.ID, transform: (Array.Index, inout Element) -> Void) -> Bool {
        guard let index = firstIndex(where: { $0.id == id }) else { return false }
        var copy = self[index]
        transform(index, &copy)
        self[index] = copy
        return true
    }
}
