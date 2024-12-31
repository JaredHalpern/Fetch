//
//  AppEnvironment.swift
//  RecipeApp
//
//

import Foundation

protocol AppEnvironment {
    var host: String { get }
    var apiBaseURL: URL { get }
}

extension AppEnvironment {
    var apiBaseURL: URL {
        URL(string: host)!
    }
}

// MARK: - Environments

public class ProductionEnvironment: AppEnvironment {
    let host = "https://d3jbb8n5wk0qxi.cloudfront.net"
}

/// Good for testing "No Recipe" screen, etc.
public class FakeEnvironment: AppEnvironment {
    let host = "https://FAKEURL/api"
}

// Add additional environments as needed for Staging, QA, Development.
