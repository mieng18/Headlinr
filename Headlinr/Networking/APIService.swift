//
//  APIService.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//


import Foundation


enum Result {
    case success
    case failure(error: NetworkError)
}

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case decodeError
    case serverError
    case unknown
    
    
    // MARK: - Error Description
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "The request is invalid. Please check the URL and parameters."
        case .invalidResponse:
            return "The response is invalid."
        case .decodeError:
            return "Failed to decode the response. Please check the data format."
        case .serverError:
            return "The server encountered an error. Please try again later."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}



