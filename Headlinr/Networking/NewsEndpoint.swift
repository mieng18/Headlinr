//
//  NewsEndpoint.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/3/25.
//


import Foundation

enum NewsEndpoint{
    case search(value: String)
}


extension NewsEndpoint: EndpointProtocol {
    var baseURL: String {
        return "https://newsapi.org"
    }
    
    var path: String {
        return "/v2/top-headlines"
    }
    
    var parameter: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        switch self {
        case .search(let country):
            queryItems.append(URLQueryItem(name: "country", value: country))
            queryItems.append(URLQueryItem(name: "apiKey",value: "77fb5ec5a30c46f0a5641551dbc0ffa0"))
        }
        return queryItems
    }
    
    var request: URLRequest? {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path = path
        urlComponent?.queryItems = parameter
        
        if let urlString = urlComponent?.url {
            var request = URLRequest(url: urlString)
            request.httpMethod = httpMethod.rawValue
            request.allHTTPHeaderFields = header
            return request
            
        }
        
        return nil
     
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var header: [String : String] {
        return ["Content-Type":"application/json"]
    }

}
