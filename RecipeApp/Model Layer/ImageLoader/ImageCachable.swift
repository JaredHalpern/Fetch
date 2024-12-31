//
//  ImageCachable.swift
//  RecipeApp
//
//

import Foundation

/// Provide `URL` and a `String` for the filename to be used by the internal cache.
protocol ImageCachable {
    var url: URL { get set }
    var filename: String { get set }
}
