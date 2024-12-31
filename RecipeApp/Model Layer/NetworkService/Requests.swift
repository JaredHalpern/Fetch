//
//  Requests.swift
//  RecipeApp
//
//

import Foundation

// MARK: - NetworkResponseProtocol

protocol NetworkResponseProtocol {
    
    associatedtype ModelType

    var modelType: ModelType.Type { get }
}

// MARK: - Endpoint Specific Enums

enum Path: String {
    case recipes = "recipes"
    case malformedRecipes = "malformed-recipes"
    case emptyRecipes = "empty-recipes"
    case none = ""
}

enum PathJSON: String {
    case recipes = "recipes"
    case recipesMalformed = "recipes-malformed"
    case recipesEmpty = "recipes-empty"
}

enum HTTPType: String {
    case GET
    // TODO: Create private XXXXrequest methods for other HTTP Types
    // used in CRUD: POST, PUT, DELETE. Add cases here.
}

// MARK: - Endpoint Specific Requests

struct RecipesNetworkRequest: NetworkRequestable {
    
    var path: Path {
        return .recipes
    }
    
    var HTTPType: HTTPType {
        return .GET
    }
    
    var responseType = RecipesNetworkResponse.self
    var pathJSON: PathJSON?
}

struct MalformedRecipesNetworkRequest: NetworkRequestable {
    
    var path: Path {
        return .malformedRecipes
    }
    
    var HTTPType: HTTPType {
        return .GET
    }
    
    var responseType = RecipesNetworkResponse.self
    var pathJSON: PathJSON?
}

struct EmptyRecipesNetworkRequest: NetworkRequestable {
    
    var path: Path {
        return .emptyRecipes
    }
    
    var HTTPType: HTTPType {
        return .GET
    }
    
    var responseType = RecipesNetworkResponse.self
    var pathJSON: PathJSON?
}

// Add additional requests here.
