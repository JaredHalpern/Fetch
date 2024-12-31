//
//  NoRecipesView.swift
//  RecipeApp
//
//

import SwiftUI

struct NoRecipesView<ViewModel: RecipeViewModelConformable>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center, content: {
            RecipeRow(viewModel: viewModel)
        })
    }
}

#Preview {
    let imageCache = ImageCacheService.shared()
    let recipeModel = RecipeModel.emptyRecipe()
    let networkService = NetworkService.shared()
    let modelLayer = ModelLayer(networkService: networkService,
                                imageCache: imageCache)
    let viewModel = RecipeViewModel(modelLayer: modelLayer, recipeModel: recipeModel)
    return NoRecipesView(viewModel: viewModel)
}
