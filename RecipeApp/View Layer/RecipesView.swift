//
//  RecipesView.swift
//  RecipeApp
//
//

import SwiftUI

struct RecipesView<ViewModel: RecipesViewModelConformable>: View {
    
    var viewModel: ViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else  if viewModel.error != nil {
                    StructuredNoRecipesView(viewModel: viewModel)
                        .refreshable {
                            await getAllRecipes()
                        }
                        .padding()
                }  else if let recipesModel = viewModel.recipesModel {
                    
                    let recipes = recipesModel.recipes.compactMap { $0 }
                    
                    if recipes.count > 0 {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 10, content: {
                                if recipes.count > 0 {
                                    ForEach(recipes, id: \.self) { recipe in
                                        NavigationLink {
                                            Text("Recipe Details")
                                        } label: {
                                            let recipeViewModel = viewModel.getViewModelForRecipeModel(recipe)
                                            RecipeRow(viewModel: recipeViewModel)
                                        }
                                    }
                                } else {
                                    StructuredNoRecipesView(viewModel: viewModel)
                                        .refreshable {
                                            await getAllRecipes()
                                        }
                                        .padding()
                                }
                            })
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .refreshable {
                            await getAllRecipes()
                        }
                        .padding()
                    } else if recipes.count == 0 && viewModel.error == nil {
                        Text("viewmodel error = nil")
                        StructuredNoRecipesView(viewModel: viewModel)
                            .refreshable {
                                await getAllRecipes()
                            }
                            .padding()
                    }
                }
            }
            .task(priority: .background) {
                await getAllRecipes()
            }
            .onChange(of: scenePhase) {
                if scenePhase == .background || scenePhase == .inactive {
                    self.viewModel.viewEnteringInactivePhase()
                }
            }
        }
    }
}

extension RecipesView {
    
    func getAllRecipes() async {
        await viewModel.getAllRecipes()
    }
}

struct StructuredNoRecipesView<ViewModel: RecipesViewModelConformable>: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, spacing: 10) {
                ForEach(0..<20) { _ in
                    NoRecipesView(viewModel: viewModel.getViewModelForRecipeModel(RecipeModel.emptyRecipe()))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    // let networkService = NetworkService.shared(environment: ProductionEnvironment())
    // let networkService = NetworkService.shared(environment: FakeEnvironment())
    let networkService = NetworkServiceStub(.malformed)
    
    let imageCache = ImageCacheService.shared()
    let modelLayer = ModelLayer(networkService: networkService,
                                imageCache: imageCache)
    let viewModel = RecipesViewModel(modelLayer: modelLayer)
    return RecipesView(viewModel: viewModel)
}
