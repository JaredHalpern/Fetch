//
//  RecipeViewModel.swift
//  RecipeApp
//
//

import Foundation

protocol RecipeViewModelConformable: ObservableObject {
    func flagForCuisine(_ cusine: String?) -> String
    func getSmallFilename() -> String?
    func getLargeFilename() -> String?
    func getSmallImageURL() -> URL?
    func getLargeImageURL() -> URL?
    
    var recipeModel: RecipeModel { get set }
    var modelLayer: any ModelLayerConformable { get set }
}

@Observable
class RecipeViewModel: RecipeViewModelConformable {
    
    var recipeModel: RecipeModel
    var modelLayer: any ModelLayerConformable
    
    init(modelLayer: any ModelLayerConformable, recipeModel: RecipeModel) {
        self.recipeModel = recipeModel
        self.modelLayer = modelLayer
    }
    
    func getSmallImageURL() -> URL? {
        if let imageURLString = recipeModel.photoURLSmall {
            return URL(string: imageURLString)
        }
        return nil
    }
    
    func getLargeImageURL() -> URL? {
        if let imageURLString = recipeModel.photoURLLarge {
            return URL(string: imageURLString)
        }
        return nil
    }

    func getSmallFilename() -> String? {
        if
            let imageURLString = recipeModel.photoURLSmall,
            let imageURL = URL(string: imageURLString),
            let lastComponent = imageURL.pathComponents.last
        {
            let filename: String = "\(recipeModel.uuid)" + "_" + "\(lastComponent)"
            return filename
        }
        return nil
    }
    
    func getLargeFilename() -> String? {
        if
            let imageURLString = recipeModel.photoURLLarge,
            let imageURL = URL(string: imageURLString),
            let lastComponent = imageURL.pathComponents.last
        {
            let filename: String = "\(recipeModel.uuid)" + "_" + "\(lastComponent)"
            return filename
        }
        return nil
    }
    
    func flagForCuisine(_ cusine: String? = nil) -> String {
        
        switch cusine?.lowercased() {
        case "american":
            return "🇺🇸"
        case "british":
            return "🇬🇧"
        case "canadian":
            return "🇨🇦"
        case "croatian":
            return "🇭🇷"
        case "french":
            return "🇫🇷"
        case "greek":
            return "🇬🇷"
        case "italian":
            return "🇮🇹"
        case "malaysian":
            return "🇲🇾"
        case "polish":
            return "🇵🇱"
        case "portuguese":
            return "🇵🇹"
        case "russian":
            return "🇷🇺"
        case "tunisian":
            return "🇹🇳"
        default:
            return "🍳"
        }
    }
}
