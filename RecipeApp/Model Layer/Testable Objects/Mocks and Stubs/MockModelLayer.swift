//
//  MockModelLayer.swift
//  RecipeAppTests
//
//

import Foundation

class MockModelLayer: ModelLayerConformable {
        
    typealias NetworkService = NetworkServiceStub
    typealias ImageCache = CacheServiceStub

    var networkService: NetworkServiceStub
    var imageCache: CacheServiceStub<URL, String>
    
    init(networkService: NetworkServiceStub = NetworkServiceStub(), imageCache: CacheServiceStub<URL, String> = CacheServiceStub()) {
        self.networkService = networkService
        self.imageCache = imageCache
    }
    
    func getAllRecipes() async throws -> RecipesModel {
        return TestableRecipesObjects.testableAllRecipes() ?? RecipesModel(recipes: [])
    }
    
    func cancelAllTasks() {}
}
