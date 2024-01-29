//
//  NetworkError.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

// Possible errors
enum NetworkError: Error {
    case badUrl
    case noData
    case connectionError
    case activationFailed
}

