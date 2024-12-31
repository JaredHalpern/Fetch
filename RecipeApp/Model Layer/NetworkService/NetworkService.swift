//
//  NetworkService.swift
//  RecipeApp
//
//

import Foundation
import SwiftUI

class NetworkService: NetworkServiceAPI {
    
    typealias DataResponse = (Data, URLResponse)
    
    private static var sharedNetworkService: NetworkService?
    
    private var dataTasks: [URL: URLSessionTask] = [:]
    private var environment: AppEnvironment
    private let taskQueue = DispatchQueue(label: "com.recipeApp.networkServiceQueue.taskQueue", attributes: .concurrent)
    
    private init(environment: AppEnvironment) {
        self.environment = environment
    }
    
    class func shared(environment: AppEnvironment = ProductionEnvironment()) -> NetworkService {
        if let shared = sharedNetworkService {
            return shared
        } else {
            let service = NetworkService(environment: environment)
            sharedNetworkService = service
            return service
        }
    }
}

extension NetworkService {
    
    /// Cancel a specified network task in the queue.
    /// - Parameter url: The URL of the network task to cancel.
    func cancelTask(for url: URL) {
        self.taskQueue.async (flags: .barrier) {
            self.dataTasks[url]?.cancel()
            self.dataTasks.removeValue(forKey: url)
        }
    }
    
    /// Cancel all outgoing network tasks in the queue.
    func cancelAllTasks() {
        self.taskQueue.async (flags: .barrier) {
            for task in self.dataTasks.values {
                task.cancel()
            }
            self.dataTasks.removeAll()
        }
    }
}

extension NetworkService {
    
    /// Download and return `Data` from a given `URL`
    /// - Parameter url: The `URL` from which to download the `Data`.
    /// - Returns: Downloaded `Data`.
    func downloadData(url: URL) async throws -> Data {
        
        return try await withTaskCancellationHandler {
            
            // Run the main task
            return try await withCheckedThrowingContinuation { continuation in
                
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    
                    self.taskQueue.async (flags: .barrier) {
                        self.dataTasks.removeValue(forKey: url)
                    }
                    
                    if let error = error {
                        
                        continuation.resume(throwing: NetworkServiceAPIError.unknown(error))
                        
                    } else if let data = data,
                              let response = response as? HTTPURLResponse,
                              (200..<300).contains(response.statusCode) {
                        
                        continuation.resume(returning: data)
                        
                    } else if let response = response as? HTTPURLResponse,
                              (400..<500).contains(response.statusCode) {
                        
                        continuation.resume(throwing: NetworkServiceAPIError.clientError("\(response.statusCode)"))
                        
                    } else if let response = response as? HTTPURLResponse,
                              (500..<600).contains(response.statusCode) {
                        
                        continuation.resume(throwing: NetworkServiceAPIError.serverError("\(response.statusCode)"))
                    } else if let data = data {
                        
                        continuation.resume(returning: data)
                    }
                    // TODO: add other HTTP Status Codes if desired.
                }
                
                self.taskQueue.async (flags: .barrier) {
                    self.dataTasks[url] = task
                }
                
                task.resume()
            }
        } onCancel: {
            // This block runs if the task is canceled
            self.taskQueue.async (flags: .barrier) {
                if let task = self.dataTasks[url] {
                    task.cancel()
                    self.dataTasks.removeValue(forKey: url)
                }
            }
        }
    }
}

extension NetworkService {
    
    // MARK: - Endpoint specific
    
    /// Get all recipes.
    /// - Returns: A `RecipesModel` object containing all recipes.
    public func getAllRecipes() async throws -> RecipesModel {
        let recipeRequest = RecipesNetworkRequest()
        return try await fetchForRequest(recipeRequest, modelType: RecipesModel.self)
    }
}

// MARK: - Private

extension NetworkService {
    
    private func GETrequest(path: Path, json: PathJSON?) -> URLRequest {
        
        var url = self.environment.apiBaseURL.appending(path: path.rawValue)
                
        // handle paths like /recipes.json
        if let json = json {
            url = url.appending(path: json.rawValue)
        }
        
        url = url.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPType.GET.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.url = url
        return request
    }
    
    // TODO: Create private XXXrequest methods for other HTTP Types used in CRUD: POST, PUT, DELETE
    
    private func makeRequest(_ networkRequest: any NetworkRequestable) -> URLRequest {
        switch networkRequest.HTTPType {
        case .GET:
            return GETrequest(path: networkRequest.path,
                              json: networkRequest.pathJSON)
            // TODO: Once other CRUD methods are created, add cases here.
        }
    }
    
    // MARK: - Generic
    
    private func fetchForRequest<ModelType: Decodable>(_ networkRequest: any NetworkRequestable, modelType: ModelType.Type) async throws -> ModelType {
        
        let request = makeRequest(networkRequest)
        
        guard let url = request.url else {
            throw NetworkServiceAPIError.unableToFormRequest
        }
        
        // Cancel task if already exists
        cancelTask(for: url)
        
        let data = try await downloadData(url: url)
        return try decodeJSON(modelType, data: data)
    }
    
    /// Exists in a separate function for when we build out the rest of the HTTP methods: POST, etc. Can also add analytics around failed fields here.
    private func decodeJSON<ModelType: Decodable>(_ modelType: ModelType.Type, data: Data) throws -> ModelType {
        do {
            return try JSONDecoder().decode(modelType, from: data)
        } catch {
            throw NetworkServiceAPIError.failedToDecode(error)
        }
    }
}
