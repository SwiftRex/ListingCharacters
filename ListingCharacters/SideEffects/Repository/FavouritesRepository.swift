//
//  FavouriteRepository.swift
//  ListingCharacters
//
//  Created by Jarbas on 09/12/20.
//

import Foundation
protocol FavouritesRepository: AnyObject {
    var favouritesCharacters: [Int] { get }

    func addCharacterToFavouriteList(id: Int)
    func removeCharacterFromFavouriteList(id: Int)
    func isFavourite(id: Int) -> Bool

}

extension UserDefaults: FavouritesRepository {
    private(set) var favouritesCharacters: [Int] {

        get {

            let favchars = object(forKey: "favchars") as? [Int]
            guard let characters = favchars else {
                return [Int]()
            }
            return characters
        }

         set {
            set(newValue, forKey: "favchars")
        }
    }

    func addCharacterToFavouriteList(id: Int) {
        self.favouritesCharacters.append(id)
    }

    func removeCharacterFromFavouriteList(id: Int) {
        if let index = self.favouritesCharacters.firstIndex(of: id) {
            self.favouritesCharacters.remove(at: index)
        }
    }

    func isFavourite(id: Int) -> Bool {
        self.favouritesCharacters.contains(id)
    }
}

class FavouriteRepositoryFake: FavouritesRepository {
    var favouritesCharacters: [Int] = []

    func addCharacterToFavouriteList(id: Int) {

    }

    func removeCharacterFromFavouriteList(id: Int) {

    }

    func isFavourite(id: Int) -> Bool {
        return false
    }

}
