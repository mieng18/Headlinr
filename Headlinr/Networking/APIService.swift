//
//  APIService.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//


import Foundation


enum NetworkResult {
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



class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchRequest(client: EndpointProtocol) async throws -> Data {
        guard let request = client.request else {
            throw NetworkError.invalidRequest
        }
        
        let config = URLSessionConfiguration.default
        let (data, response) = try await URLSession(configuration: config).data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check Response Status
        switch checkResponse(httpResponse) {
        case .success:
            return data
        case .failure(let error):
            throw error
        }
    }
    
    /// Checks HTTP status codes and returns appropriate error
    private func checkResponse(_ response: HTTPURLResponse) -> NetworkResult {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(error: .serverError)
        default:
            return .failure(error: .unknown)
        }
    }
    
    /// Fetch and decode JSON data
    func fetchData<T: Decodable>(client: EndpointProtocol, type: T.Type) async throws -> T {
        let data = try await fetchRequest(client: client)
        let jsonDecoder = JSONDecoder()
        
        do {
            let objects = try jsonDecoder.decode(T.self, from: data)
            return objects
        } catch {
            throw NetworkError.decodeError
        }
    }
}
