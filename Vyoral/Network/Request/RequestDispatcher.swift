//
//  RequestDispatcher.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import Foundation

class RequestDispatcher {

    // Creates and performs URL request
    class func request<T: Codable>(apiRouter: Router) async throws -> T {
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        components.queryItems = apiRouter.parameters
        
        guard let url = components.url else {
            throw NetworkError.badUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRouter.method
        
        let session = URLSession(configuration: .default)

        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, _, error in
                if let _ = error {
                    return continuation.resume(with: .failure(NetworkError.connectionError))
                }

                guard let data = data else {
                    return continuation.resume(with: .failure(NetworkError.noData))
                }

                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    return continuation.resume(with: .failure(error))
                }
            }
            dataTask.resume()
        }
    }
}

