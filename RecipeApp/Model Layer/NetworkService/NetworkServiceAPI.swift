//
//  NetworkServiceAPI.swift
//  RecipeApp
//
//

import Foundation

protocol NetworkServiceAPI {
    func getAllRecipes() async throws -> RecipesModel
    func downloadData(url: URL) async throws -> Data
    func cancelAllTasks()
    func cancelTask(for url: URL)
}
