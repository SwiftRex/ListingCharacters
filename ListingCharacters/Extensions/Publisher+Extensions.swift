//
//  DataTaskPublisher+Extensions.swift
//  ListingCharacters
//
//  Created by Jarbas on 08/12/20.
//

import Combine
import CoreGraphics
import CoreImage
import Foundation

#if canImport(UIKit)
import UIKit
public typealias XXImage = UIImage
#endif
#if canImport(AppKit)
import AppKit
public typealias XXImage = NSImage
#endif


public enum APIError: Error {
    case urlError(URLError)
    case invalidResponse(URLResponse)
    case unexpectedStatusCode(Int)
    case decodingError(DecodingError)
    case unknownError(Error)
    case imageDataError
}

extension Publisher where Output == (data: Data, response: URLResponse), Failure == URLError {
    public func decode<T: Decodable, Decoder: TopLevelDecoder>(type: T.Type, decoder: Decoder)
    -> AnyPublisher<T, APIError> where Decoder.Input == Data {
        mapError(APIError.urlError)
            .flatMapResult(Self.ensureStatusCode)
            .flatMapResult(Self.decodeSync(type: type, decoder: decoder))
            .eraseToAnyPublisher()
    }

    private static func ensureStatusCode(data: Data, urlResponse: URLResponse) -> Result<Data, APIError> {
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            return .failure(.invalidResponse(urlResponse))
        }

        guard (200 ..< 300) ~= httpURLResponse.statusCode else {
            return .failure(.unexpectedStatusCode(httpURLResponse.statusCode))
        }

        return .success(data)
    }

    private static func decodeSync<T: Decodable, Decoder: TopLevelDecoder>(type: T.Type, decoder: Decoder)
    -> (Data) -> Result<T, APIError> where Decoder.Input == Data {
        return {
            data in
            decoder
                .decodeResult(type, from: data)
                .mapError {error in
                    if let decodingError = error as? DecodingError { return .decodingError(decodingError)}
                    return .unknownError(error)
                }
        }
    }

    public func decodeImage() -> AnyPublisher<CGImage, APIError> {
        mapError(APIError.urlError)
            .flatMapResult(Self.ensureStatusCode)
            .flatMap { data -> AnyPublisher<CGImage, APIError> in
                XXImage(data: data)?
                    .cgImage
                    .map { Just($0).setFailureType(to: APIError.self).eraseToAnyPublisher() }
                ?? Fail(error: .imageDataError).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

extension TopLevelDecoder {
    public func decodeResult<T: Decodable>(_ type: T.Type, from data: Input) -> Result<T, Error> {
        Result {
            try decode(type, from: data)
        }
    }
}

extension Publisher {
    public func flatMapResult<NewOutput>(_ transform: @escaping (Output) -> Result<NewOutput, Failure>)
    -> Publishers.FlatMap<Result<NewOutput, Failure>.Publisher, Self> {
        flatMap { output -> Result<NewOutput, Failure>.Publisher in
            transform(output).publisher
        }
    }
}
