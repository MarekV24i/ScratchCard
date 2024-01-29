//
//  Router.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import Foundation

enum Router {

    case activate(code: String)

    var host: String {
        switch self {
        case .activate:
            return "api.o2.sk"
        }
    }

    var scheme: String {
        switch self {
        case .activate:
            return "https"
        }
    }

    var path: String {
        switch self {
        case .activate:
            return "/version"
        }
    }

    var method: String {
        switch self {
        case .activate:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .activate(let code):
            return [URLQueryItem(name: "code", value: code)]
        }
    }

}
