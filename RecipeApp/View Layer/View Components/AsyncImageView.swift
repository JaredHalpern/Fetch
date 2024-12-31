//
//  AsyncImageView.swift
//  RecipeApp
//
//

import SwiftUI

struct AsyncImageView: View, ImageCachable {
    
    @State var imageLoader = ImageLoader()
    var url: URL
    var filename: String
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1.8)
                    )
            } else {
                Image(systemName: "frying.pan")
            }
        }
        .onAppear {
            imageLoader.loadImage(url: url, filename: filename)
        }
        .onDisappear {
            imageLoader.cancel()
        }
    }
}
