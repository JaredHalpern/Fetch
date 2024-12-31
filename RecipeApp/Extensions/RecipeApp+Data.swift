//
//  RecipeApp+Data.swift
//  RecipeApp
//
//

import SwiftUI

extension Data {
    
    /// Convert a `Data` representation to a SwiftUI `Image`.
    /// - Returns: A SwiftUI `Image`.
    func convertImageDataToImage() -> Image? {
        guard let uiImage = UIImage(data: self) else {
            print("Unable to convert data to UIImage.")
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
