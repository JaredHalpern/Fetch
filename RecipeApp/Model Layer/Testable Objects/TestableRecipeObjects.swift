//
//  TestableRecipeObjects.swift
//  RecipeAppTests
//
//

import Foundation

/// These objects can be used for SwiftUI Previews as well as Unit Testing
public struct TestableRecipeObjects {
    
    /// Full recipe including optional fields
    private static let fullRecipeData = """
    {
      "cuisine": "Malaysian",
      "name": "Apam Balik",
      "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
      "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
      "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
      "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
      "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    }
""".data(using: .utf8)!
    
    /// Missing optional fields
    private static let partialRecipeDataWithoutOptionals = """
    {
      "cuisine": "Malaysian",
      "name": "Apam Balik",
      "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8"
    }
""".data(using: .utf8)!
    
    /// Missing required field: name
    private static let malformedRecipeData = """
    {
      "cuisine": "British",
      "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
      "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
      "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
      "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
      "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
    }
""".data(using: .utf8)!
    
    /// Get a full recipe `RecipeModel` including optional fields.
    /// - Returns: A `RecipeModel` object containing a full recipe including optional fields.
    public static func testableFullRecipe() -> RecipeModel {
        return try! JSONDecoder().decode(RecipeModel.self, from: fullRecipeData)
    }
    
    /// Get a testable `RecipeModel` object without the optional fields.
    /// - Returns: A `RecipeModel` object without the optional fields.
    public static func testablePartialRecipeWithoutOptionals() -> RecipeModel {
        return try! JSONDecoder().decode(RecipeModel.self, from: partialRecipeDataWithoutOptionals)
    }
    
    /// Get a testable `RecipeModel` object containg malformed data. The object will be missing required field: name.
    /// - Returns: A `RecipeModel` object missing the required name field.
    public static func testableMalformedData() -> RecipeModel {
        return try! JSONDecoder().decode(RecipeModel.self, from: malformedRecipeData)
    }
}
