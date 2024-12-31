//
//  CacheServiceTests.swift
//  RecipeAppTests
//
//

import XCTest
@testable import RecipeApp

class CacheServiceTests: XCTestCase {
    
    func testAddToCache() {
        let cache = CacheService<String, Int>(capacity: 2)
        
        // Test adding elements
        cache.set(1, "one")
        cache.set(2, "two")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(cache.get(key: "one"), 1)
            XCTAssertEqual(cache.get(key: "two"), 2)
        }
    }
    
    func testUpdateExistingElement() {
        let cache = CacheService<String, Int>(capacity: 2)
        
        cache.set(2, "two")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(cache.get(key: "two"), 2)
        }
        
        // Test updating existing element
        cache.set(22, "two")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(cache.get(key: "two"), 22)
        }
    }
        
    func testCacheCapacity() {
        let cache = CacheService<String, Int>(capacity: 2)
        
        cache.set(1, "one")
        cache.set(2, "two")
        cache.set(3, "three")
        
        XCTAssertEqual(cache.get(key: "three"), 3)
        XCTAssertEqual(cache.get(key: "two"), 2)
        XCTAssertNil(cache.get(key: "one"))
    }
    
    func testSaveDataToDisk() throws {
        guard let data = "Hello".data(using: .utf8) else {
            XCTFail("Unable to create data for test.")
            return
        }
        
        let filename = "data.txt"
        let tempDirectory = getTemporaryTestingDirectory()
        
        let cache = CacheService<String, String>(documentsDirectory: tempDirectory)
        try cache.saveDataToDisk(data: data, filename: filename)
        
        let readDirectory = tempDirectory.appendingPathComponent(filename)
        let savedData = try Data(contentsOf: readDirectory)
        XCTAssertEqual(savedData, data)
    }
    
    func testLoadDataFromDisk() throws {
        guard let data = "Hello".data(using: .utf8) else {
            XCTFail("Unable to create data for test.")
            return
        }
        
        let filename = "data.txt"
        let tempDirectory = getTemporaryTestingDirectory().appendingPathComponent(filename)
        let cache = CacheService<String, String>(documentsDirectory: tempDirectory)
        
        try data.write(to: tempDirectory)
        
        let loadedData = try cache.loadDataFromDisk(path: tempDirectory)
        
        XCTAssertEqual(loadedData, data)
    }
}

extension CacheServiceTests {
    
    private func getTemporaryTestingDirectory() -> URL {
        return FileManager.default.temporaryDirectory
    }
}
