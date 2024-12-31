//
//  RecipeApp.swift
//  RecipeApp
//
//

import SwiftUI

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            
            let networkService = NetworkService.shared(environment: ProductionEnvironment())
            let imageCache = ImageCacheService.shared()
            let modelLayer = ModelLayer(networkService: networkService, imageCache: imageCache)
            let viewModel = RecipesViewModel(modelLayer: modelLayer)
            
            RecipesView(viewModel: viewModel)
        }
    }
}
