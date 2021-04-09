//
//  LazyImage.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import CoreGraphics
import Foundation
import SwiftUI

typealias CacheReader = () -> CGImage?

struct LazyImage<MainImage: View, PlaceholderImage: View>: View {
    private let possibleImage: CGImage?
    private let mainImageBuilder: (CGImage) -> MainImage
    private let placeholderBuilder: () -> PlaceholderImage

    private let onFetch: () -> Void
    private let onCancel: () -> Void

    init(
        cacheReader: CacheReader,
        fetch: @escaping () -> Void,
        cancel: @escaping () -> Void,
        @ViewBuilder image: @escaping (CGImage) -> MainImage,
        @ViewBuilder placeholder: @escaping () -> PlaceholderImage
    ) {
        self.mainImageBuilder = image
        self.placeholderBuilder = placeholder
        self.onFetch = fetch
        self.onCancel = cancel
        self.possibleImage = cacheReader()
    }

    var body: some View {
        if let image = possibleImage {
            self.mainImageBuilder(image)
        } else {
            self.placeholderBuilder()
                .onAppear {
                    onFetch()
                }
                .onDisappear {
                    onCancel()
                }
        }
    }
}
