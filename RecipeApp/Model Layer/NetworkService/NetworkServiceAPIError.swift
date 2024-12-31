//
//  NetworkServiceAPIError.swift
//  RecipeApp
//
//

import Foundation

enum NetworkServiceAPIError: Error {
    case unknown(Error)
    case failedToDecode(Error)
    case clientError(String)
    case serverError(String)
    case unableToFormRequest
    
    var message: String {
        switch self {
        case .unknown:
            return "--> Unknown error"
        case .failedToDecode:
            return "--> Failed to decode response"
        case .clientError:
            return "--> Client Error"
        case .serverError:
            return "--> Server Error"
        case .unableToFormRequest:
            return "--> Unable to form request"
        }
    }
}
