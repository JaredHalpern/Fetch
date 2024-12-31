//
//  NetworkRequestable.swift
//  RecipeApp
//
//

import Foundation

protocol NetworkRequestable: CustomStringConvertible {
    associatedtype ResponseType
    
    var path: Path { get }
    var HTTPType: HTTPType { get }
    var responseType: ResponseType.Type { get }
    var pathJSON: PathJSON? { get }
}

extension NetworkRequestable {
    var description: String {
        return "NetworkRequestable: \(self.HTTPType.rawValue) \(self.path)"
    }
}
