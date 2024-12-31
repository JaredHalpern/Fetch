//
//  RecipeRow.swift
//  RecipeApp
//
//

import SwiftUI

struct RecipeRow<ViewModel: RecipeViewModelConformable>: View {

    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10, content: {
            
            let name = viewModel.recipeModel.name
            let cuisine = viewModel.recipeModel.cuisine
            let flagString = viewModel.flagForCuisine(cuisine)
            
            Group {
                if let filename = viewModel.getSmallFilename(),
                   let imageURL = viewModel.getSmallImageURL()
                {
                    AsyncImageView(url: imageURL, filename: filename)
                } else {
                    Image(systemName: "frying.pan")
                }
            }
            .scaledToFit()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.gray, lineWidth: 1.8)
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                HStack(spacing: 4) {
                    Text(flagString)
                    Text(cuisine)
                        .font(.caption)
                }
            }
            .foregroundColor(.black)
        })
        .cornerRadius(5.0)
    }
}

#Preview {
    let imageCache = ImageCacheService.shared()
    let recipeModel = TestableRecipeObjects.testableFullRecipe()
    let networkService = NetworkService.shared()
    let modelLayer = ModelLayer(networkService: networkService,
                                imageCache: imageCache)
    let viewModel = RecipeViewModel(modelLayer: modelLayer, recipeModel: recipeModel)
    return RecipeRow(viewModel: viewModel)
}
