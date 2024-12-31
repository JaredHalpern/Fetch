//
//  ModelLayer.swift
//  RecipeApp
//
//

import Foundation
import SwiftUI

protocol ModelLayerConformable {
    
    associatedtype NetworkService: NetworkServiceAPI
    associatedtype ImageCache: CacheServiceAPI
    
    func getAllRecipes() async throws -> RecipesModel
    func cancelAllTasks()
    
    var networkService: NetworkService { get set }
    var imageCache: ImageCache { get set }
}

struct ModelLayer<NetworkService: NetworkServiceAPI, ImageCache: CacheServiceAPI>: ModelLayerConformable {
    
    var networkService: NetworkService
    var imageCache: ImageCache
    
    init(networkService: NetworkService,
         imageCache: ImageCache) {
        self.networkService = networkService
        self.imageCache = imageCache
    }
    
    func getAllRecipes() async throws -> RecipesModel {
        return try await networkService.getAllRecipes()
    }
    
    func cancelAllTasks() {
        networkService.cancelAllTasks()
    }
}
