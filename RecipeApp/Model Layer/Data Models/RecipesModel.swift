//
//  RecipesModel.swift
//  RecipeApp
//
//

import Foundation

/*
+=========+==========+==========+===========================================+
| Key     | Type     | Required | Notes                                     |
+=========+==========+==========+===========================================+
| recipes | [Recipe] | Yes      | An array of recipes.                      |
+---------+----------+----------+-------------------------------------------+
*/

protocol RecipesModelConformable {
    var recipes: [RecipeModel?] { get }
}

/// The top-level Recipes model
public struct RecipesModel: Codable, RecipesModelConformable {
    var recipes: [RecipeModel?]
}

extension RecipesModel: CustomStringConvertible {
    public var description: String {
        return """
        All Recipes:
        \(recipes)
        """
    }
}
