//
//  RecipesViewModelTests.swift
//  RecipeAppTests
//
//

import XCTest
@testable import RecipeApp

final class RecipesViewModelTests: XCTestCase {
    
    var networkService: NetworkServiceStub!
    var imageCache: CacheServiceStub<URL, String>!
    var viewModel: RecipesViewModel!
    var mockModelLayer: MockModelLayer!
    
    override func setUp() {
        networkService = NetworkServiceStub(.success)
        imageCache = CacheServiceStub()
        mockModelLayer = MockModelLayer(networkService: networkService,
                                        imageCache: imageCache)
        viewModel = RecipesViewModel(modelLayer: mockModelLayer)
    }
    
    override func tearDown() {
        networkService = nil
        imageCache = nil
        viewModel = nil
        mockModelLayer = nil
        super.tearDown()
    }
    
    func testGetAllRecipes() async throws {
        await viewModel.getAllRecipes()
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.recipesModel)
        let recipesModel = try XCTUnwrap(viewModel.recipesModel)
        XCTAssertEqual(recipesModel.recipes.count, 63)
    }
    
    func testGetViewModelForRecipeModel() {
        let recipeModel = TestableRecipeObjects.testableFullRecipe()
        let recipeViewModel = viewModel.getViewModelForRecipeModel(recipeModel)
        XCTAssertEqual(recipeViewModel.recipeModel.uuid, recipeModel.uuid)
        XCTAssertEqual(recipeViewModel.recipeModel.name, recipeModel.name)
        XCTAssertEqual(recipeViewModel.recipeModel.photoURLSmall, recipeModel.photoURLSmall)
    }
    
}
