//
//  RecipeModel.swift
//  RecipeApp
//
//

import Foundation

/*
 +=================+========+==========+==================================================================================+
 | Key             | Type   | Required | Notes                                                                            |
 +=================+========+==========+==================================================================================+
 | cuisine         | String | Yes      | The cuisine of the recipe.                                                       |
 | name            | String | Yes      | The name of the recipe.                                                          |
 | photo_url_large | String | No       | The URL of the recipes’s full-size photo.                                        |
 | photo_url_small | String | No       | The URL of the recipes’s small photo. Useful for list view.                      |
 | uuid            | String | Yes      | The unique identifier for the receipe. Represented as a UUID.                    |
 | source_url      | String | No       | The URL of the recipe's original website.                                        |
 | youtube_url     | String | No       | The URL of the recipe's YouTube video.                                           |
 | id              | String | Yes      | The unique identifier for the receipe. Represented as a UUID. Duplicate of uuid. |
 +-----------------+--------+----------+----------------------------------------------------------------------------------+
*/

// TODO: Document each variable

protocol RecipeModelConformable {
    var uuid: String { get }
    var cuisine: String { get }
    var name: String { get }
    var photoURLLarge: String? { get }
    var photoURLSmall: String? { get }
    var sourceURL: String? { get }
    var youtubeURL: String? { get }
    var id: String { get }
}

/// Individual Recipe Model
public struct RecipeModel: Codable, Identifiable, Hashable, RecipeModelConformable {
    public let id: String
    let uuid: String
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case uuid
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    public init(id: String, uuid: String, cuisine: String, name: String, photoURLLarge: String?, photoURLSmall: String?, sourceURL: String?, youtubeURL: String?) {
        self.id = id
        self.uuid = uuid
        self.cuisine = cuisine
        self.name = name
        self.photoURLLarge = photoURLLarge
        self.photoURLSmall = photoURLSmall
        self.sourceURL = sourceURL
        self.youtubeURL = youtubeURL
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoURLLarge = try container.decodeIfPresent(String.self, forKey: .photoURLLarge)
        self.photoURLSmall = try container.decodeIfPresent(String.self, forKey: .photoURLSmall)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.sourceURL = try container.decodeIfPresent(String.self, forKey: .sourceURL)
        self.youtubeURL = try container.decodeIfPresent(String.self, forKey: .youtubeURL)
        
        self.id = self.uuid
    }
}

extension RecipeModel {
    public static func emptyRecipe() -> RecipeModel {
        return RecipeModel(id: "",
                           uuid: "",
                           cuisine: "Please try again later.",
                           name: "No Recipes Available.",
                           photoURLLarge: nil,
                           photoURLSmall: nil,
                           sourceURL: nil,
                           youtubeURL: nil)
    }
}

extension RecipeModel: CustomStringConvertible {
    public var description: String {
        return """
        Recipe:
        cuisine: \(cuisine)
        name: \(name)
        photoURLSmall: \(photoURLSmall ?? "None")
        photoURLLarge: \(photoURLLarge ?? "None")
        sourceURL: \(sourceURL ?? "None")
        youtubeURL: \(youtubeURL ?? "None")
        id: \(id)
        uuid: \(uuid)
        """
    }
}
