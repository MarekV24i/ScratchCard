//
//  NetworkRepository.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import Foundation

// NetworkRepository for card activation
public class O2ActivationAPI: NetworkRepository {
    
    public func activateCard(code: String)  async throws -> String?  {
        
        let response: ActivationEntity  = try await RequestDispatcher.request(apiRouter: .activate(code: code))
        return response.ios
    }
}
