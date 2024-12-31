//
//  Responses.swift
//  RecipeApp
//
//

import Foundation

struct RecipesNetworkResponse: NetworkResponseProtocol {
    var modelType = RecipesModel.self
    var model: RecipesModel
}
