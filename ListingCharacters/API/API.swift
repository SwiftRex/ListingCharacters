//
//  API.swift
//  ListingCharacters
//
//  Created by Jarbas on 07/12/20.
//

import Combine
import Foundation

struct API<Model: Decodable, ResponseType: Decodable> {
    let urlBase: () -> String
    let getById: (Int) -> AnyPublisher<Model, Error>
    let getAllAtPage: (Int) -> AnyPublisher<ResponseType, Error>
}
