//
//  ImageLoader.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    private(set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "image-processsing")

    private let url: URL

    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }

    deinit {
        cancel()
    }

    func cancel() {
        cancellable?.cancel()
    }

    func load() {
        if let image = cache?[url] {
            self.image = image
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: {[weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: {[weak self] _ in self?.onFinish() },
                          receiveCancel: {[weak self]  in self?.cancel() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }
}
