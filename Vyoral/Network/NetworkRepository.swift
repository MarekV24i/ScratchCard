//
//  NetworkRepositoryProtocol.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

public protocol NetworkRepository {
    // Activate card by its code
    func activateCard(code: String) async throws -> String?
}

