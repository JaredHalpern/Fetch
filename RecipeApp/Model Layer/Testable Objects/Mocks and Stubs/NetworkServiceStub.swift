//
//  NetworkServiceStub.swift
//  RecipeApp
//
//

import Foundation

enum NetworkServiceStubResponseType {
    case success
    case malformed
    case empty
}

class NetworkServiceStub: NetworkServiceAPI {
        
    private var responseType: NetworkServiceStubResponseType
    
    init(_ responseType: NetworkServiceStubResponseType = .success) {
        self.responseType = responseType
    }
    
    func getAllRecipes() async throws -> RecipesModel {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        switch responseType {
        case .success:
            return TestableRecipesObjects.testableAllRecipes() ?? RecipesModel(recipes: [])
        case .malformed:
            return TestableRecipesObjects.testableMalformedRecipes() ?? RecipesModel(recipes: [])
        case .empty:
            return TestableRecipesObjects.testableEmptyRecipes() ?? RecipesModel(recipes: [])
        }
        
    }
    
    func downloadData(url: URL) async throws -> Data {
        return Data()
    }
    
    func cancelAllTasks() {}
    
    func cancelTask(for url: URL) {}
}
