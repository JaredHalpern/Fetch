//
//  CacheServiceStub.swift
//  RecipeAppTests
//
//

import Foundation

class CacheServiceStub<Key: Hashable & Codable, Value: Codable>: CacheServiceAPI {
    
    private var fileDirectory: URL?
    
    init(fileDirectory: URL? = nil) {
        self.fileDirectory = fileDirectory
    }
    
    func saveDataToDisk(data: Data, filename: String) throws {
    }
    
    func loadDataFromDisk(path: URL) -> Data? {
        return nil
    }
    
    func getDocumentsDirectory() -> URL? {
        return fileDirectory
    }
    
    func get(key: Key) -> Value? {
        return nil
    }
    
    func set(_ value: Value, _ key: Key) {
        
    }
    
    func saveDataToDisk(data: Data, url: URL, filename: String) async {
        
    }
    
    func loadDataFromDisk(url: URL) async -> Data? {
        return nil
    }
}
