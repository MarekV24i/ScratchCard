//
//  VyoralTests.swift
//  VyoralTests
//
//  Created by Marek on 27.01.2024.
//

import XCTest

@testable import Vyoral


// Mockup of network repository that returns success (high version value)
struct MockUpNetworkRepositorySuccess: NetworkRepository{
    func activateCard(code: String) async throws -> String? {
        return "7.0"
    }
}

// Mockup of network repository that fails (low version value)
struct MockUpNetworkRepositoryFail: NetworkRepository{
    func activateCard(code: String) async throws -> String? {
        return "1.0"
    }
}

// Mockup of network repository that returns error
struct MockUpNetworkRepositoryError: NetworkRepository{
    func activateCard(code: String) async throws -> String? {
        throw NetworkError.activationFailed
    }
}




