//
//  AsyncView.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//  For further references, this is was implemented based on the following:
// https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
//    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image

    init(url: URL?,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self.placeholder = placeholder()
        self.image = image
        // _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }

    var body: some View {
        content
//            .onAppear(perform: loader.load)
    }

    private var content : some View {
        Group {
//            if loader.image != nil {
//                Image(uiImage: loader.image!)
//                    .resizable()
//            } else {
                placeholder
//            }
        }
    }
}
