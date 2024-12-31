//
//  RecipesViewModel.swift
//  RecipeApp
//
//

import Foundation
import SwiftUI

protocol RecipesViewModelConformable: ObservableObject {
    func getAllRecipes() async
    func getViewModelForRecipeModel(_ recipeModel: RecipeModel) -> RecipeViewModel
    func viewEnteringInactivePhase()
    
    var recipesModel: RecipesModel? { get set }
    var isLoading: Bool { get set }
    var modelLayer: any ModelLayerConformable { get set }
    var error: Error? { get set }
}
    
@Observable
class RecipesViewModel: RecipesViewModelConformable {
    
    var recipesModel: RecipesModel?
    var isLoading = false
    var modelLayer: any ModelLayerConformable
    var error: Error? = nil
    
    init(modelLayer: any ModelLayerConformable){
        self.modelLayer = modelLayer
    }
    
    func getAllRecipes() async {
        isLoading = true
        
        do {
            modelLayer.cancelAllTasks()
            self.recipesModel = try await modelLayer.getAllRecipes()
            self.error = nil
        } catch {
            self.error = error
            print("getAllRecipes error: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func getViewModelForRecipeModel(_ recipeModel: RecipeModel) -> RecipeViewModel {
        return RecipeViewModel(modelLayer: modelLayer, recipeModel: recipeModel)
    }
    
    func viewEnteringInactivePhase() {
        print("view entering inactive phase")
        modelLayer.cancelAllTasks()
    }
}
