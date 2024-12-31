//
//  RecipeViewModelTests.swift
//  RecipeAppTests
//
//

import XCTest
@testable import RecipeApp

final class RecipeViewModelTests: XCTestCase {
    
    var networkService: NetworkServiceStub!
    var imageCache: CacheServiceStub<URL, String>!
    var viewModel: RecipeViewModel!
    var mockModelLayer: MockModelLayer!
    var mockRecipeModel: RecipeModel!
    
    override func setUp() {
        networkService = NetworkServiceStub(.success)
        imageCache = CacheServiceStub()
        mockRecipeModel = TestableRecipeObjects.testableFullRecipe()
        mockModelLayer = MockModelLayer(networkService: networkService,
                                        imageCache: imageCache)
        viewModel = RecipeViewModel(modelLayer: mockModelLayer,
                                        recipeModel: mockRecipeModel)
    }
    
    override func tearDown() {
        networkService = nil
        imageCache = nil
        viewModel = nil
        mockModelLayer = nil
        mockRecipeModel = nil
        super.tearDown()
    }
    
    func testGetSmallImageURL() {
        
        XCTAssertEqual(viewModel?.getSmallImageURL()?.absoluteString,
                       mockRecipeModel?.photoURLSmall)
    }
    
    func testGetLargeImageURL() {
        XCTAssertEqual(viewModel?.getLargeImageURL()?.absoluteString,
                       mockRecipeModel?.photoURLLarge)
    }
    
    func testGetSmallFilename() {
        let filename = "0c6ca6e7-e32a-4053-b824-1dbf749910d8_small.jpg"
        XCTAssertEqual(viewModel?.getSmallFilename(),
                       filename)
    }
    
    func testGetLargeFilename() {
        let filename = "0c6ca6e7-e32a-4053-b824-1dbf749910d8_large.jpg"
        XCTAssertEqual(viewModel?.getLargeFilename(),
                       filename)
    }
    
    func testFlagForCuisine() {
        XCTAssertEqual(viewModel?.flagForCuisine("american"), "🇺🇸")
        XCTAssertEqual(viewModel?.flagForCuisine("british"), "🇬🇧")
        XCTAssertEqual(viewModel?.flagForCuisine("canadian"), "🇨🇦")
        XCTAssertEqual(viewModel?.flagForCuisine("unknown"), "🍳")
    }
}
