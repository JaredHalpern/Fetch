//
//  ImageLoader.swift
//  RecipeApp
//
//

import SwiftUI

protocol ImageLoaderConformable: ObservableObject {
    func loadImage(url: URL, filename: String)
    func cancel()
}

@Observable
class ImageLoader: ImageLoaderConformable {
    
    var image: Image?
    
    private let imageCache: ImageCacheService
    private var task: Task<Void, Never>?
    
    init(image: Image? = nil, imageCache: ImageCacheService = ImageCacheService.shared()) {
        self.image = image
        self.imageCache = imageCache
    }
    
    // MARK: - 
    
    func loadImage(url: URL, filename: String) {
        self.task?.cancel()

        self.task = Task {
            do {
                
                if
                    let imageData = try imageCache.getImageDataFromLocalCache(remoteURL: url),
                    let image = imageData.convertImageDataToImage()
                {
//                    print("Retrieved image from disk cache.")
                    
                    await MainActor.run {
                        self.image = image
                    }
                } else {
                    async let data = try await downloadData(url: url)
                    
                    let imageData = try await data
                    imageCache.set(imageData: imageData, remoteURL: url, filename: filename)
                    
//                    print("Retrieved image from remote source and saved locally to disk cache.")
                    
                    if let image = imageData.convertImageDataToImage() {
                        await MainActor.run {
                            self.image = image
                        }
                    }
                    
                }
            } catch {
                print("ImageLoader - loadImage(url:) - error: \(error)")
            }
        }
    }
    
    func cancel() {
        task?.cancel()
    }
    
    // MARK: - Private
        
    private func downloadData(url: URL) async throws -> Data {
        return try await NetworkService.shared().downloadData(url: url)
    }
}
